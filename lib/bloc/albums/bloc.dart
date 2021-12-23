import 'dart:io';

import 'package:bloc_album/api/exceptions.dart';
import 'package:bloc_album/api/services.dart';
import 'package:bloc_album/bloc/albums/events.dart';
import 'package:bloc_album/bloc/albums/states.dart';
import 'package:bloc_album/model/albums_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumsBloc extends Bloc<AlbumEvents, AlbumsState> {
  final AlbumsRepo albumsRepo;
  late List<Album> albumsList;

  AlbumsBloc(this.albumsRepo) : super(AlbumsInitState());

  @override
  Stream<AlbumsState> mapEventToState(AlbumEvents event) async* {
    switch (event) {
      case AlbumEvents.fetchAlbums:
        yield AlbumsLoading();
        try {
          albumsList = await albumsRepo.getAlbumList();
          yield AlbumsLoaded(albumsList);
          break;
        } on SocketException {
          yield AlbumsListError(NoInternetException('No Internet'));
        } on HttpException {
          yield AlbumsListError(NoServiceFoundException('No Service Found'));
        } on FormatException {
          yield AlbumsListError(InvalidFormatException('Invalid Response Format'));
        } catch (e) {
          yield AlbumsListError(InvalidFormatException('Unknown Error'));
        }
    }
  }
}
