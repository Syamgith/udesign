import 'package:flutter/material.dart';
import 'package:udesign/components/drawer_widget.dart';
import 'package:udesign/components/product_card.dart';
import 'package:udesign/components/recommeded_view.dart';
import 'package:udesign/models/user_model.dart';
import 'package:udesign/resources/product_datas.dart';
import 'package:udesign/resources/style_resourses.dart';

class ProductsScreen extends StatelessWidget {
  final _productslist = ProductDatas.productsList;
  UserModel user;
  ProductsScreen({this.user});
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
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  text: 'All Products',
                ),
                Tab(
                  text: 'Recommended for You',
                ),
              ],
            ),
            Expanded(
              //flex: 2,
              child: TabBarView(
                children: [
                  allProducts(context),
                  RecommededView(
                    context: context,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget allProducts(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10.0),
            itemCount: _productslist.length,
            itemBuilder: (context, i) =>
                ProductCard(context: context, product: _productslist[i]),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 10 / 11,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          ),
          end(
            context,
          )
        ],
      ),
    );
  }

  Widget end(context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.black87,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height / 4,
        child: Center(
            child: Text(
          'More products coming soon',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.amber),
        )),
      ),
    );
  }
}
