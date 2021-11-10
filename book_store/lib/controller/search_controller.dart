import 'package:flutter/material.dart';

class SearchController extends StatefulWidget {
  // const SearchController({Key? key}) : super(key: key);
  final Function searchTextfieldCallBack;
  SearchController({required this.searchTextfieldCallBack});

  @override
  _SearchControllerState createState() =>
      _SearchControllerState(searchTextfieldCallBack);
}

class _SearchControllerState extends State<SearchController> {
  // SearchController({this.searchTextfieldCallBack});
  final Function searchTextfieldCallBack;
  final FocusNode _focusNode = FocusNode();

  _SearchControllerState(this.searchTextfieldCallBack);
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: TextField(
          onChanged: (value) {
            searchTextfieldCallBack(value);
          },
          cursorColor: Colors.grey,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(2),
              hintText: "Search...",
              fillColor: Colors.white,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(),
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: _focusNode.hasFocus
                          ? Colors.grey.shade600
                          : Colors.grey.shade500))),
        ));
  }
}
