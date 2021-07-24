import 'package:flutter/material.dart';
import 'package:udesign/components/drawer_widget.dart';
import 'package:udesign/resources/style_resourses.dart';

class ProductsScreen extends StatelessWidget {
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
        itemCount: 15,
        itemBuilder: (context, i) => productCard(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 10 / 11,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }

  Widget productCard() {
    return GridTile(
        child: FadeInImage(
          placeholder: AssetImage(
            'assets/logo.jpeg',
          ),
          image: NetworkImage(
            'https://cdn.vox-cdn.com/thumbor/2RAPXv49KHKLzmQom0i3QxDml6Y=/1400x1050/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/19539424/mickeyclock.jpg',
          ),
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
            ),
            onPressed: () {
              // product.toggleFavorite(authData.token, authData.userId);
            },
          ),
          title: Text(
            'title',
            textAlign: TextAlign.center,
          ),
        ));
  }
}
