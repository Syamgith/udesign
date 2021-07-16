import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  ArCoreController arCoreController;

  String objectSelected;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Udesign'),
        ),
        body: Stack(
          children: <Widget>[
            ArCoreView(
              onArCoreViewCreated: _onArCoreViewCreated,
              enableTapRecognizer: true,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: ListObjectSelection(
                onTap: (value) {
                  objectSelected = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);
    arCoreController.onPlaneTap = _handleOnPlaneTap;
  }

  void _addToucano(ArCoreHitTestResult plane) {
    if (objectSelected != null) {
      //"https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF/Duck.gltf"
      final toucanoNode = ArCoreReferenceNode(
          name: objectSelected,
          object3DFileName: objectSelected,
          position: plane.pose.translation,
          rotation: plane.pose.rotation);

      arCoreController.addArCoreNodeWithAnchor(toucanoNode);
    } else {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(content: Text('Select an object!')),
      );
    }
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    _addToucano(hit);
  }

  void onTapHandler(String name) {
    print("Flutter: onNodeTap");
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          children: <Widget>[
            Text('Remove $name?'),
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
    'http://4.bp.blogspot.com/-tsGDGlr87iY/T7A0g_AGs_I/AAAAAAAACgI/PTUgmoFOGXQ/s1600/Toco+toucan+Ramphastos+toco.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/Android_robot.svg/1200px-Android_robot.svg.png',
    'https://images.squarespace-cdn.com/content/v1/556323dee4b006bb6875f975/1612901885769-SW2M6UAY8ZVXKZRL11JB/Arctic%2BFox%252C%2BWhite%2Bon%2BWhite-2593%2Bcopy.jpg',
  ];

  List<String> objectsFileName = [
    'toucan.sfb',
    'andy.sfb',
    'artic_fox.sfb',
  ];

  String selected;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: ListView.builder(
        itemCount: imageUrls.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selected = imageUrls[index];
                widget.onTap(objectsFileName[index]);
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
                    ? Colors.red
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
