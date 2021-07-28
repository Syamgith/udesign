import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udesign/components/product_card.dart';
import 'package:udesign/models/product_model.dart';
import 'package:udesign/models/user_model.dart';
import 'package:udesign/resources/product_datas.dart';

class RecommededView extends StatelessWidget {
  Function onTap;
  bool fromScan;
  RecommededView({@required this.context, this.fromScan = false, this.onTap});

  final List<Product> _productslist = ProductDatas.recomProdList;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(builder: (context, user, _) {
      return SingleChildScrollView(
        child: user.registered
            ? Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10.0),
                    itemCount: _productslist.length,
                    itemBuilder: (context, i) {
                      return fromScan
                          ? ProductCard(
                              context: context,
                              product: _productslist[i],
                              fromScan: true,
                              onTap: onTap,
                            )
                          : ProductCard(
                              context: context,
                              product: _productslist[i],
                              fromScan: false,
                            );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 10 / 11,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                  ),
                ],
              )
            : Card(
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
                    'Login for recommendation',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.amber),
                  )),
                ),
              ),
      );
    });
  }
}
