import 'package:flutter/material.dart';
import 'package:udesign/models/product_model.dart';

class ListObjectSelection extends StatefulWidget {
  final Function onTap;

  ListObjectSelection({this.onTap});

  @override
  _ListObjectSelectionState createState() => _ListObjectSelectionState();
}

class _ListObjectSelectionState extends State<ListObjectSelection> {
  // List<String> imageUrls = [
  //   'https://i.pinimg.com/originals/cc/5e/31/cc5e311fba93e4d2da4a25f04e9bb212.png',
  //   'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/GlamVelvetSofa/screenshot/screenshot.jpg',
  //   'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/BoomBox/screenshot/screenshot.jpg',
  //   'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/SheenChair/screenshot/screenshot.jpg',
  // ];

  // List<String> objectsFileName = [
  //   'couch.sfb',
  //   // 'rv_table_with_vase.sfb',
  //   'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/GlamVelvetSofa/glTF/GlamVelvetSofa.gltf',
  //   'https://github.com/pmndrs/market-assets/raw/main/files/models/apple/model.gltf',
  //   'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/SheenChair/glTF/SheenChair.gltf',
  // ];

  List<Product> _productsList = [
    Product(
        title: 'Coloured Sofa',
        imgUrl:
            'https://i.pinimg.com/originals/cc/5e/31/cc5e311fba93e4d2da4a25f04e9bb212.png',
        model: Model3D(
          address: 'couch.sfb',
        )),
    Product(
        title: 'Glam Sofa',
        imgUrl:
            'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/GlamVelvetSofa/screenshot/screenshot.jpg',
        model: Model3D(
          address:
              'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/GlamVelvetSofa/glTF/GlamVelvetSofa.gltf',
          isRemote: true,
        )),
    Product(
        title: 'Sheen Chair',
        imgUrl:
            'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/SheenChair/screenshot/screenshot.jpg',
        model: Model3D(
          address:
              'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/SheenChair/glTF/SheenChair.gltf',
          isRemote: true,
        )),
  ];

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
