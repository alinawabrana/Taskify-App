import 'package:go_router/go_router.dart';
import 'package:taskify/features/authentication/screens/login/login_screen.dart';
import 'package:taskify/features/authentication/screens/signup/signup_screen.dart';
import 'package:taskify/features/authentication/screens/success/success_screen.dart';
import 'package:taskify/features/authentication/screens/verify_email/verify_email_screen.dart';
import 'package:taskify/features/personlization/screens/change_password/change_password.dart';
import 'package:taskify/features/personlization/screens/notification_preference/notification_preference.dart';
import 'package:taskify/features/todo/screens/calender/calender_screen.dart';
import 'package:taskify/features/todo/screens/event/event_screen.dart';
import 'package:taskify/features/todo/screens/home/home_screen.dart';
import 'package:taskify/features/todo/screens/milestone/milestone_screen.dart';
import 'package:taskify/features/todo/screens/new_events/new_events_screen.dart';
import 'package:taskify/features/todo/screens/new_milestones/new_milestones_screen.dart';
import 'package:taskify/features/todo/screens/new_todo/new_todo_screen.dart';
import 'package:taskify/features/todo/screens/search/search_screen.dart';
import 'package:taskify/features/todo/screens/todo/todo_screen.dart';
import 'package:taskify/navigation_menu.dart';

import '../../features/personlization/screens/profile/profile.dart';
import '../../features/personlization/screens/setting/setting_screen.dart';
import '../../features/personlization/screens/task_completion/task_completion_rate.dart';
import '../../features/todo/screens/event/events_detail/events_detail_screen.dart';
import '../../features/todo/screens/milestone/milestones_detail/milestones_details_screen.dart';
import '../../features/todo/screens/todo/todo_detail/todo_detail_screen.dart';

class AGoRouters {
  final router = GoRouter(
    initialLocation: '/navigation',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => SignupScreen(),
      ),
      GoRoute(
        path: '/verify-email',
        name: 'verify-email',
        builder: (context, state) => VerifyEmailScreen(),
      ),
      GoRoute(
        path: '/success',
        name: 'success',
        builder: (context, state) => SuccessScreen(),
      ),
      GoRoute(
        path: '/navigation',
        name: 'navigation',
        builder: (context, state) => BottomAppBarMenu(),
      ),
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (context, state) => SearchScreen(),
      ),
      GoRoute(
        path: '/calender',
        name: 'calender',
        builder: (context, state) => CalenderScreen(),
      ),
      GoRoute(
        path: '/setting',
        name: 'setting',
        builder: (context, state) => SettingScreen(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) {
          final arg = state.extra as Map<String, dynamic>;
          final Map<String, dynamic> currentUser = arg['currentUser'];
          return Profile(currentUser: currentUser);
        },
      ),
      GoRoute(
        path: '/change_password',
        name: 'change_password',
        builder: (context, state) {
          final arg = state.extra as Map<String, dynamic>;
          final Map<String, dynamic> currentUser = arg['currentUser'];
          return ChangePassword(currentUser: currentUser);
        },
      ),
      GoRoute(
        path: '/task_completion_rate',
        name: 'task_completion_rate',
        builder: (context, state) => TaskCompletionRate(),
      ),
      GoRoute(
        path: '/notification_preference',
        name: 'notification_preference',
        builder: (context, state) => NotificationPreference(),
      ),
      GoRoute(
        path: '/todo',
        name: 'todo',
        builder: (context, state) => TodoScreen(),
      ),
      GoRoute(
        path: '/todo_detail',
        name: 'todo_detail',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          final Map<String, dynamic> todo = args['todo'];
          final double percent = args['percent'];

          return TodoDetailScreen(todo: todo, percent: percent);
        },
      ),
      GoRoute(
        path: '/events/:eventType',
        name: 'events',
        builder: (context, state) {
          final eventType = state.pathParameters['eventType']!;
          return EventScreen(eventType: eventType);
        },
      ),
      GoRoute(
        path: '/events_detail',
        name: 'events_detail',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          final Map<String, dynamic> event = args['event'];
          final String eventType = args['eventType'];
          return EventsDetailScreen(event: event, eventType: eventType);
        },
      ),
      GoRoute(
        path: '/milestones',
        name: 'milestones',
        builder: (context, state) => MilestoneScreen(),
      ),
      GoRoute(
        path: '/milestones_detail',
        name: 'milestones_detail',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          final Map<String, dynamic> milestone = args['milestone'];

          return MilestonesDetailsScreen(milestone: milestone);
        },
      ),
      GoRoute(
        path: '/new_todo',
        name: 'new_todo',
        builder: (context, state) => NewTodoScreen(),
      ),
      GoRoute(
        path: '/new_events',
        name: 'new_events',
        builder: (context, state) => NewEventsScreen(),
      ),
      GoRoute(
        path: '/new_milestones',
        name: 'new_milestones',
        builder: (context, state) => NewMilestonesScreen(),
      ),
    ],
  );
}
