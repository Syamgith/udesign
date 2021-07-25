import 'dart:io';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:native_screenshot/native_screenshot.dart';
import 'package:udesign/components/drawer_widget.dart';
import 'package:udesign/resources/style_resourses.dart';
import 'package:udesign/utils/utils.dart';

class ScanScreen extends StatefulWidget {
  final Function setHomeIcon;
  ScanScreen({this.setHomeIcon});
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  ArCoreController arCoreController;
  Widget _imgHolder;

  String objectSelected;
  bool isRemote;
  bool showInstrutions = true;
  bool save = false;
  @override
  void initState() {
    super.initState();
    _imgHolder = Center(
      child: Icon(Icons.image),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: save
          ? null
          : AppBar(
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.white),
              title: const Text(
                'Udesign',
                style: StyleResourse.AppBarTitleStyle,
              ),
            ),
      body: Stack(
        children: <Widget>[
          ArCoreView(
            onArCoreViewCreated: _onArCoreViewCreated,
            enableTapRecognizer: true,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: save
                ? Container()
                : ListObjectSelection(
                    onTap: (value, remote) {
                      objectSelected = value;
                      isRemote = remote;
                    },
                  ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: save
                ? Container()
                : Center(
                    child: showInstrutions
                        ? Text(
                            'Detect a plane and tap on dots!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )
                        : Container(),
                  ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: save
                ? Container()
                : IconButton(
                    padding: EdgeInsets.all(10),
                    icon: Icon(
                      Icons.save,
                      size: 32,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: saveImage,
                  ),
          ),
        ],
      ),
    );
  }

  void saveImage() {
    save = true;
    widget.setHomeIcon(false);
    showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                content: Text(
                  "Capture and Save",
                  style: StyleResourse.primaryTitleStyle,
                ),
                actions: [
                  TextButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      })
                ],
              );
            })
        .then((value) =>
            Future.delayed((Duration(seconds: 1)), () => nativeSS()));
  }

  Future<dynamic> showimgWidget(BuildContext context, imgFile) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Your Design"),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(top: 16),
              height: MediaQuery.of(context).size.height / 1.5,
              //constraints: BoxConstraints.expand(),
              child: _imgHolder,
            ),
            IconButton(
                onPressed: () {
                  _shareImage(imgFile);
                },
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Share'),
                    Icon(Icons.share),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Future<void> _shareImage(imgFile) async {
    try {
      final bytes1 = await imgFile.readAsBytes(); // Uint8List
      final bytes = bytes1.buffer.asByteData(); // ByteData
      await Share.file(
          'Share image', 'esys.png', bytes.buffer.asUint8List(), 'image/png',
          text: 'check out my pic.');
    } catch (e) {
      print('error: $e');
    }
  }

  void nativeSS() async {
    String path = await NativeScreenshot.takeScreenshot();

    debugPrint('Screenshot taken, path: $path');

    if (path == null || path.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error saving image :('),
        backgroundColor: Colors.red,
      )); // showSnackBar()
      save = false;
      widget.setHomeIcon(true);
      return;
    } // if error

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('The image has been saved to: $path')));

    File imgFile = File(path);
    _imgHolder = Image.file(imgFile);

    save = false;
    widget.setHomeIcon(true);
    setState(() {});
    showimgWidget(context, imgFile);
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);
    arCoreController.onPlaneTap = _handleOnPlaneTap;
  }

  void _addObject(ArCoreHitTestResult plane) {
    if (objectSelected != null) {
      Utils.showLoadingModel(context);
      //"https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF/Duck.gltf"
      final node = isRemote
          ? ArCoreReferenceNode(
              name: objectSelected,
              objectUrl: objectSelected,
              position: plane.pose.translation,
              rotation: plane.pose.rotation)
          : ArCoreReferenceNode(
              name: objectSelected,
              object3DFileName: objectSelected,
              position: plane.pose.translation,
              rotation: plane.pose.rotation);

      arCoreController
          .addArCoreNodeWithAnchor(node)
          .then((value) => Utils.hideProgress(context));

      setState(() {
        showInstrutions = false;
      });
    } else {
      Utils.popUpDelayed(context, "Select a Product");
    }
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    _addObject(hit);
  }

  void onTapHandler(String name) {
    print("Flutter: onNodeTap");
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          children: <Widget>[
            Text('Remove?'),
            IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: () {
                  arCoreController.removeNode(nodeName: name);
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}

class ListObjectSelection extends StatefulWidget {
  final Function onTap;

  ListObjectSelection({this.onTap});

  @override
  _ListObjectSelectionState createState() => _ListObjectSelectionState();
}

class _ListObjectSelectionState extends State<ListObjectSelection> {
  List<String> imageUrls = [
    'https://i.pinimg.com/originals/cc/5e/31/cc5e311fba93e4d2da4a25f04e9bb212.png',
    'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/GlamVelvetSofa/screenshot/screenshot.jpg',
    'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/BoomBox/screenshot/screenshot.jpg',
    'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/SheenChair/screenshot/screenshot.jpg',
  ];

  List<String> objectsFileName = [
    'couch.sfb',
    'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/GlamVelvetSofa/glTF/GlamVelvetSofa.gltf',
    'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/BoomBox/glTF/BoomBox.gltf',
    'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/SheenChair/glTF/SheenChair.gltf'
  ];

  String selected;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.0,
      child: ListView.builder(
        itemCount: imageUrls.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selected = imageUrls[index];
                var remote = index != 0;
                widget.onTap(objectsFileName[index], remote);
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
                color: selected == imageUrls[index]
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                padding:
                    selected == imageUrls[index] ? EdgeInsets.all(8.0) : null,
                child: Image.network(imageUrls[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
