import 'dart:async';

import 'package:flutter/material.dart';
import 'package:search_snackbar_bottomsheet_flutter/src/data/network.dart';
import 'package:search_snackbar_bottomsheet_flutter/src/model/album.dart';
import 'package:search_snackbar_bottomsheet_flutter/src/widget/detail_text.dart';
import 'package:substring_highlight/substring_highlight.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var _listController = StreamController<List<Album>?>();

  var _textFieldController = TextEditingController();

  List<Album> _albums = [];

  List<Album> get _visibleAlbums => _albums
      .where((e) => e.title.contains(RegExp(_textFieldController.text)))
      .toList();

  _getAlbums() async {
    _listController.add(null);
    _albums = await Network.getAlbums();
    _listController.add(_visibleAlbums);
  }

  @override
  void initState() {
    _getAlbums();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      body: StreamBuilder<List<Album>?>(
        stream: _listController.stream,
        initialData: null,
        builder: (context, snapshot) {
          if (snapshot.data == null)
            return Center(
              child: CircularProgressIndicator(),
            );

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: TextField(
                  controller: _textFieldController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (_) => _listController.add(_visibleAlbums),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var album = snapshot.data![index];
                    return ListTile(
                      title: SubstringHighlight(
                        text: album.title,
                        term: _textFieldController.text,
                        textStyle: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      trailing: IconButton(
                        icon: Icon(album.favourited
                            ? Icons.favorite
                            : Icons.favorite_border),
                        onPressed: () {
                          final value = !album.favourited;
                          final snackBar = SnackBar(
                            backgroundColor: value ? Colors.red : Colors.black,
                            content: Text(
                                value
                                    ? 'ID: ${album.id} added to favourites'
                                    : 'ID: ${album.id} removed from favourites',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )),
                            action: SnackBarAction(
                              textColor: Colors.white,
                              label: 'Undo',
                              onPressed: () {
                                setState(() {
                                  album.favourited = !value;
                                });
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          setState(() {
                            album.favourited = value;
                          });
                        },
                      ),
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (context) {
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DetailText('USERID', '${album.userId}'),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  DetailText('ID', '${album.id}'),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  DetailText('TITLE', '${album.title}'),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, _) {
                    return Divider();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
