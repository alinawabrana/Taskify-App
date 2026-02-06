import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taskify/provider.dart';
import 'package:taskify/utils/helpers/helper_function.dart';
import 'package:taskify/utils/loaders/loaders.dart';

class OverlayDropdownPriority extends StatefulWidget {
  const OverlayDropdownPriority({
    super.key,
    required this.linkLayer,
    this.onTap,
    required this.options,
    this.todo,
    this.fontSize,
    this.iconSize,
    this.fontColor,
    this.iconColor,
    this.isFilter = false,
    this.ref,
  });

  final LayerLink linkLayer;
  final double? fontSize;
  final double? iconSize;
  final Color? fontColor;
  final Color? iconColor;
  final List<Map<String, dynamic>> options;
  final VoidCallback? onTap;
  final Map<String, dynamic>? todo;
  final bool isFilter;
  final WidgetRef? ref;

  @override
  State<OverlayDropdownPriority> createState() =>
      _OverlayDropdownPriorityState();
}

class _OverlayDropdownPriorityState extends State<OverlayDropdownPriority>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _activeOverlay;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    _activeOverlay?.remove();
    super.dispose();
  }

  void _showDropdown() {
    _controller.forward(from: 0);

    _activeOverlay = OverlayEntry(
      builder:
          (context) => Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    _controller.reverse().then((_) {
                      _activeOverlay?.remove();
                      _activeOverlay = null;
                    });
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(),
                ),
              ),
              Positioned(
                width: 160,
                child: CompositedTransformFollower(
                  link: widget.linkLayer,
                  offset: const Offset(-90, 45),
                  showWhenUnlinked: false,
                  child: Material(
                    color: Colors.transparent,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Material(
                          elevation: 8,
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children:
                                  widget.options.map((item) {
                                    return ListTile(
                                      title: Text(
                                        widget.isFilter
                                            ? item['filter']
                                            : item['priority'],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onTap: () {
                                        _controller.reverse().then((_) {
                                          _activeOverlay?.remove();
                                          _activeOverlay = null;
                                          setState(() {
                                            widget.isFilter
                                                ? widget.ref!
                                                    .read(taskProvider)
                                                    .changeFilter(
                                                      item['filter'],
                                                    )
                                                : widget.todo!['priority'] =
                                                    item['priority'];
                                          });
                                          widget.onTap?.call();
                                        });
                                      },
                                    );
                                  }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
    );

    Overlay.of(context).insert(_activeOverlay!);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: widget.linkLayer,
      child: TextButton(
        onPressed: () {
          if (_activeOverlay != null) {
            _controller.reverse().then((_) {
              _activeOverlay?.remove();
              _activeOverlay = null;
            });
          } else {
            _showDropdown();
          }
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        ),
        child: Row(
          children: [
            Text(
              '${widget.isFilter ? widget.ref!.watch(taskProvider).filterTasks : widget.todo!['priority']}',
              style: TextStyle(
                color: widget.fontColor ?? Colors.white,
                fontSize: widget.fontSize ?? 18,
                decoration: TextDecoration.underline,
                decorationColor:
                    widget.isFilter
                        ? null
                        : widget.todo!['priority'] == 'High'
                        ? Colors.redAccent
                        : widget.todo!['priority'] == 'Medium'
                        ? Colors.blueAccent
                        : Colors.greenAccent,
                decorationThickness: 2,
              ),
            ),
            const SizedBox(width: 3),
            Icon(
              Iconsax.arrow_down_1,
              color: widget.iconColor ?? Colors.white,
              size: widget.iconSize ?? 15,
            ),
          ],
        ),
      ),
    );
  }
}
