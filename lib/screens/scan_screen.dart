import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  ArCoreController arCoreController;

  String objectSelected;
  bool isRemote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onTap: (value, remote) {
                objectSelected = value;
                isRemote = remote;
              },
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

      arCoreController.addArCoreNodeWithAnchor(node);
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
      height: 150.0,
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
