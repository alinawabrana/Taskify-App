import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taskify/utils/helpers/helper_function.dart';
import 'package:taskify/utils/loaders/loaders.dart';

class OverlayDropdown extends StatelessWidget {
  OverlayDropdown({
    super.key,
    required this.linkLayer,
    this.icon,
    this.size,
    this.color,
    this.isFloatingButton = false,
    this.onTap,
    required this.options,
  });

  final LayerLink linkLayer;
  final IconData? icon;
  final double? size;
  final Color? color;
  final bool isFloatingButton;
  final List<Map<String, dynamic>> options;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    OverlayEntry? _activeOverlay;
    LayerLink? _activeLink;

    OverlayEntry buildDropdown(
      BuildContext context,
      LayerLink link,
      List<Map<String, dynamic>> items,
      VoidCallback onDismiss,
    ) {
      return OverlayEntry(
        builder: (context) {
          final AnimationController controller = AnimationController(
            vsync: Navigator.of(context),
            duration: Duration(milliseconds: 300),
          )..forward();
          return Stack(
            children: [
              // Transparent backdrop to detect taps outside
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    controller.reverse().then((_) => onDismiss());
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(),
                ),
              ),

              // Dropdown itself
              Positioned(
                width: 160,
                child: CompositedTransformFollower(
                  link: link,
                  offset:
                      isFloatingButton ? Offset(-50, -220) : Offset(-90, 45),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      final Animation<Offset> slideAnimation = Tween<Offset>(
                        begin:
                            isFloatingButton ? Offset(0, 0.1) : Offset(0, -0.1),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: controller,
                          curve: Curves.easeOut,
                        ),
                      );

                      final Animation<double> fadeAnimation = CurvedAnimation(
                        parent: controller,
                        curve: Curves.easeIn,
                      );

                      return FadeTransition(
                        opacity: fadeAnimation,
                        child: SlideTransition(
                          position: slideAnimation,
                          child: Material(
                            elevation: 8,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children:
                                    items.map((item) {
                                      return ListTile(
                                        title: Text(item['name']),
                                        onTap: () {
                                          controller.reverse().then(
                                            (_) => onDismiss(),
                                          );
                                          item['navigate'] != ''
                                              ? GoRouter.of(context).push(
                                                item['navigate'],
                                                extra: item['extra'],
                                              )
                                              : null;
                                        },
                                      );
                                    }).toList(),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    void showDropdown({
      required BuildContext context,
      required LayerLink link,
      required List<Map<String, dynamic>> items,
    }) {
      // Remove any existing overlay
      if (_activeOverlay != null) {
        _activeOverlay?.remove();
        _activeOverlay = null;
        _activeLink = null;
      }

      // Defer the new overlay insertion to the next microtask
      Future.microtask(() {
        _activeLink = link;

        _activeOverlay = buildDropdown(context, link, items, () {
          _activeOverlay?.remove();
          _activeOverlay = null;
          _activeLink = null;
        });

        Overlay.of(context).insert(_activeOverlay!);
      });
    }

    return CompositedTransformTarget(
      link: linkLayer,
      child: IconButton(
        icon: Icon(icon, size: size ?? 25, color: color ?? Colors.grey),
        onPressed: () {
          showDropdown(context: context, link: linkLayer, items: options);
        },
      ),
    );
  }
}
