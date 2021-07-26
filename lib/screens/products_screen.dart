import 'package:flutter/material.dart';
import 'package:udesign/components/drawer_widget.dart';
import 'package:udesign/models/product_model.dart';
import 'package:udesign/resources/product_datas.dart';
import 'package:udesign/resources/style_resourses.dart';
import 'package:udesign/screens/home_screen.dart';
import 'package:udesign/utils/utils.dart';

class ProductsScreen extends StatelessWidget {
  final _productslist = ProductDatas.productsList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Products',
          style: StyleResourse.AppBarTitleStyle,
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: _productslist.length,
        itemBuilder: (context, i) => productCard(context, _productslist[i]),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 10 / 11,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }

  Widget productCard(BuildContext context, Product product) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.black,
                title: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home(
                                  index: 0,
                                  selectedProduct: product,
                                )));
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
            ),
          )),
    );
  }
}
