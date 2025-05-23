import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/album_repository.dart';
import 'viewmodels/album_bloc.dart';
import 'routes/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AlbumRepository(),
      child: BlocProvider(
        create: (context) => AlbumBloc(
          RepositoryProvider.of<AlbumRepository>(context),
        ),
        child: MaterialApp.router(
          routerConfig: router,
          title: 'Albums Demo',
          theme: ThemeData(primarySwatch: Colors.blue),
        ),
      ),
    );
  }
}