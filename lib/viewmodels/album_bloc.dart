import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/album_repository.dart';
import '../models/album.dart';
import 'album_state.dart';

abstract class AlbumEvent {}

class FetchAlbums extends AlbumEvent {}

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository albumRepository;

  AlbumBloc(this.albumRepository) : super(AlbumInitial()) {
    on<FetchAlbums>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albums = await albumRepository.fetchAlbums();
        emit(AlbumLoaded(albums));
      } catch (e) {
        emit(AlbumError('Failed to fetch albums'));
      }
    });
  }
}