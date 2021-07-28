import 'package:flutter/material.dart';
import 'package:udesign/models/product_model.dart';
import 'package:udesign/resources/style_resourses.dart';
import 'package:udesign/screens/home_screen.dart';

class ProductCard extends StatelessWidget {
  ProductCard(
      {Key key,
      @required this.context,
      @required this.product,
      this.fromScan = false,
      this.onTap})
      : super(key: key);

  final BuildContext context;
  final Product product;
  Function onTap;
  bool fromScan;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.black,
                title: InkWell(
                  onTap: () {
                    if (fromScan) {
                      onTap(product);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    } else {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(
                                    index: 0,
                                    selectedProduct: product,
                                  )));
                    }
                  },
                  child: Text(
                    "Click to show in room",
                    style: StyleResourse.primaryTitleStyle,
                  ),
                ),
              );
            });
      },
      child: GridTile(
          child: FadeInImage(
            placeholder: AssetImage(
              'assets/logo.jpeg',
            ),
            image: NetworkImage(
              product.imgUrl,
            ),
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
              style: StyleResourse.primaryTitleStyle,
            ),
          )),
    );
  }
}
