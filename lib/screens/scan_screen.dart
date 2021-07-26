import 'dart:io';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:native_screenshot/native_screenshot.dart';
import 'package:udesign/components/drawer_widget.dart';
import 'package:udesign/components/list_object_selection.dart';
import 'package:udesign/models/product_model.dart';
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

  Product objectSelected;
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
                    onTap: (prod) {
                      objectSelected = prod;
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
                            'Detect a plane and tap on dotted plane.',
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

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);
    arCoreController.onPlaneTap = _handleOnPlaneTap;
  }

  void _addObject(ArCoreHitTestResult plane) {
    if (objectSelected != null) {
      Utils.showLoadingModel(context);
      //"https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF/Duck.gltf"
      final node = objectSelected.model.isRemote
          ? ArCoreReferenceNode(
              name: objectSelected.title,
              objectUrl: objectSelected.model.address,
              position: plane.pose.translation,
              rotation: plane.pose.rotation)
          : ArCoreReferenceNode(
              name: objectSelected.title,
              object3DFileName: objectSelected.model.address,
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

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
