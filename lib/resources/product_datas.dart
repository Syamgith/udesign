import 'package:udesign/models/product_model.dart';

class ProductDatas {
  static List<Product> productsList = [
    Product(
        title: 'Colour Sofa',
        imgUrl:
            'https://i.pinimg.com/originals/cc/5e/31/cc5e311fba93e4d2da4a25f04e9bb212.png',
        model: Model3D(
          address: 'couch.sfb',
        )),
    Product(
        title: 'Piano',
        imgUrl:
            'https://kawaius.com/wp-content/uploads/2018/04/GL50-Polished-Ebony-450x450.jpg',
        model: Model3D(
          address: 'piano.sfb',
        )),
    Product(
        title: 'Tredmill',
        imgUrl:
            'https://3.imimg.com/data3/LR/PI/MY-2184756/lifeline-motorised-treadmill-250x250.jpg',
        model: Model3D(
          address: 'tredmill.sfb',
        )),
    Product(
        title: 'Wide floor sofa',
        imgUrl:
            'https://i.pinimg.com/originals/9a/e7/07/9ae707a786355bd292a8a8eca65c2079.jpg',
        model: Model3D(
          address: 'sofa.sfb',
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
    Product(
        title: 'Wall light',
        imgUrl:
            'https://www.luxurylighting.co.uk/ekmps/shops/luxurylighting/images/huguenot-lake-single-bathroom-wall-light-feiss-lighting-62097-p.jpg',
        model: Model3D(
          address: 'light.sfb',
        )),
    Product(
        title: 'Table lamp',
        imgUrl:
            'https://www.homesrus.ae/media/catalog/product/cache/a804bc9a22f55bdcc68786db3543c068/5/1/5110100200806_1_3.jpg',
        model: Model3D(
          address: 'lamp3.sfb',
        )),
    Product(
        title: 'Silver pot',
        imgUrl:
            'http://www.artnet.com/WebServices/images/ll01361lldREbJFg8ZECfDrCWvaHBOcBpoF/buccellati-(co.)-buccellati-sterling-silver-vase.jpg',
        model: Model3D(
          address: 'potted_plant.sfb',
        )),
  ];
}
