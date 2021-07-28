import 'package:flutter/material.dart';
import 'package:udesign/components/recommeded_view.dart';
import 'package:udesign/models/product_model.dart';
import 'package:udesign/resources/product_datas.dart';
import 'package:udesign/resources/style_resourses.dart';
import 'package:udesign/screens/home_screen.dart';
import 'package:udesign/utils/utils.dart';

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
      height: MediaQuery.of(context).size.height / 6,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3.5,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Home(
                            index: 1,
                          )));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  elevation: 4.0,
                  margin: EdgeInsets.all(4.0),
                  child: Container(
                    child: Center(
                      child: Text(
                        'See all\nProducts',
                        textAlign: TextAlign.center,
                        style: StyleResourse.regularLargeStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: _productsList.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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
                      // width: MediaQuery.of(context).size.width / 3,
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
            Container(
              width: MediaQuery.of(context).size.width / 3,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Dialog(
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            'Recommendations for you',
                                            style:
                                                StyleResourse.AppBarTitleStyle,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              icon: Icon(Icons.close)),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: RecommededView(
                                        context: context,
                                        fromScan: true,
                                        onTap: widget.onTap,
                                      ),
                                    )),
                                  ],
                                )));
                      });
                },
                child: Card(
                  elevation: 4.0,
                  margin: EdgeInsets.all(4.0),
                  child: Container(
                    child: Center(
                      child: Text(
                        'Click for Recommended Products',
                        textAlign: TextAlign.center,
                        style: StyleResourse.regularLargeStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
