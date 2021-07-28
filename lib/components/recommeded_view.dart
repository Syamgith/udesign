import 'package:flutter/material.dart';
import 'package:udesign/components/product_card.dart';
import 'package:udesign/models/product_model.dart';
import 'package:udesign/models/user_model.dart';
import 'package:udesign/resources/product_datas.dart';

class RecommededView extends StatelessWidget {
  UserModel user;
  RecommededView({@required this.context, this.user});

  final List<Product> _productslist = ProductDatas.productsList;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}
