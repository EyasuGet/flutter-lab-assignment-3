import 'package:album_app_flutter_application_1/views/album_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/album_repository.dart';
import 'viewmodels/album_bloc.dart';
import 'views/album_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Albums Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RepositoryProvider(
        create: (context) => AlbumRepository(),
        child: BlocProvider(
          create: (context) => AlbumBloc(
            RepositoryProvider.of<AlbumRepository>(context),
          ),
          child: const AlbumListScreen(),
        ),
      ),
    );
  }
}