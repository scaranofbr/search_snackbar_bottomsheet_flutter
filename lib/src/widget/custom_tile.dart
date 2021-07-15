import 'package:flutter/material.dart';
import 'package:substring_highlight/substring_highlight.dart';

class CustomTile extends StatefulWidget {
  final String text;
  final String term;

  const CustomTile({required this.text, required this.term, Key? key})
      : super(key: key);

  @override
  _CustomTileState createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  bool _isFavouriteSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: SubstringHighlight(
        text: widget.text,
        term: widget.term,
        textStyle: TextStyle(color: Colors.black, fontSize: 20),
      ),
      trailing: IconButton(
        icon: Icon(!_isFavouriteSelected ? Icons.favorite_border : Icons.favorite, color: Colors.red,),
        onPressed: () {
          setState(() {
            _isFavouriteSelected = !_isFavouriteSelected;
          });
        },
      ),
    );
  }
}
