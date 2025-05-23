import 'package:go_router/go_router.dart';
import '../views/album_list_screen.dart';
import '../views/album_detail_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AlbumListScreen(),
      routes: [
        GoRoute(
          path: 'album/:id',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id']!);
            return AlbumDetailScreen(albumId: id!);
          },
        ),
      ],
    ),
  ],
);