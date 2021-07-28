class Product {
  final id;
  String title;
  String imgUrl;
  Model3D model;
  Product({this.id, this.title, this.imgUrl, this.model});
}

class Model3D {
  final String address;
  final bool isRemote;
  Model3D({this.address, this.isRemote = false});
}
