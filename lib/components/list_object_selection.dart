import 'package:flutter/material.dart';
import 'package:udesign/models/product_model.dart';
import 'package:udesign/resources/product_datas.dart';

class ListObjectSelection extends StatefulWidget {
  final Function onTap;

  ListObjectSelection({this.onTap});

  @override
  _ListObjectSelectionState createState() => _ListObjectSelectionState();
}

class _ListObjectSelectionState extends State<ListObjectSelection> {
  final _productsList = ProductDatas.productsList;
  Product selected;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.0,
      child: ListView.builder(
        itemCount: _productsList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selected = _productsList[index];

                widget.onTap(_productsList[index]);
              });
            },
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Container(
                color: selected == _productsList[index]
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                padding: selected == _productsList[index]
                    ? EdgeInsets.all(8.0)
                    : null,
                child: Image.network(_productsList[index].imgUrl),
              ),
            ),
          );
        },
      ),
    );
  }
}
