import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/album_repository.dart';
import 'album_state.dart';

abstract class AlbumEvent {}
class FetchAlbums extends AlbumEvent {}
class FetchAlbumDetail extends AlbumEvent {
  final int albumId;
  FetchAlbumDetail(this.albumId);
}

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository albumRepository;
  AlbumBloc(this.albumRepository) : super(AlbumInitial()) {
    on<FetchAlbums>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albums = await albumRepository.fetchAlbums();
        final photos = await albumRepository.fetchPhotos();
        emit(AlbumLoaded(albums, photos));
      } catch (e) {
        emit(AlbumError('Failed to fetch albums or photos'));
      }
    });

    on<FetchAlbumDetail>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albums = await albumRepository.fetchAlbums();
        final photos = await albumRepository.fetchPhotos();
        final album = albums.firstWhere((a) => a.id == event.albumId);
        final albumPhotos = photos.where((p) => p.albumId == event.albumId).toList();
        emit(AlbumDetailLoaded(album, albumPhotos));
      } catch (e) {
        emit(AlbumError('Failed to fetch album details'));
      }
    });
  }
}