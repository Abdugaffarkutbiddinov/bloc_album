import 'package:bloc_album/bloc/albums/events.dart';
import 'package:bloc_album/bloc/albums/states.dart';
import 'package:bloc_album/model/albums_list.dart';
import 'package:bloc_album/widgets/error.dart';
import 'package:bloc_album/widgets/list_row.dart';
import 'package:bloc_album/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:bloc_album/bloc/albums/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({Key? key}) : super(key: key);

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    _loadAlbums();
  }

  _loadAlbums() async{
    context.read<AlbumsBloc>().add(AlbumEvents.fetchAlbums);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: Container(
        child: _body(),
      ),
    );
  }

  _body() {
    return Column(
      children: [
        BlocBuilder<AlbumsBloc,AlbumsState>(builder: (BuildContext context, AlbumsState state) {
          if(state is AlbumsListError) {
            final error = state.error;
            return ErrorWidgetCustom(message: error.message);
          }
          if(state is AlbumsLoaded) {
              List<Album> albums = state.albums;
              return _list(albums);
          }
          return LoadingCustom();
        }),
      ],
    );
  }
  Widget _list(List<Album> albums) {
    return Expanded(
      child: ListView.builder(itemBuilder: (_,index) {
        Album album = albums[index];
        return ListRow(album: album);
      }),
    );
  }

}
