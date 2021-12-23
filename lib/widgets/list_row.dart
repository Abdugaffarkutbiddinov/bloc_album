import 'package:bloc_album/model/albums_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListRow extends StatelessWidget {
  final Album album;

  const ListRow({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(album.title,style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),),
        ],
      ),
    );
  }
}
