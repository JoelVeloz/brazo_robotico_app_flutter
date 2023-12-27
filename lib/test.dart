import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class Asdasdasdas extends StatefulWidget {
  const Asdasdasdas({super.key});
  
  get title => null;

  @override
  State<Asdasdasdas> createState() => _AsdasdasdasState();
}

class _AsdasdasdasState extends State<Asdasdasdas> with SingleTickerProviderStateMixin {
  late Scene _scene;
  Object? _cube;
  late AnimationController _controller;

  Object? _c;
  void _onSceneCreated(Scene scene) async {
    _scene = scene;
    scene.camera.position.z = 50;
    _cube = Object(scale: Vector3(5.0, 5.0, 5.0), backfaceCulling: true, fileName: 'assets/file.obj');
    _c = Object(scale: Vector3(5.0, 5.0, 5.0), backfaceCulling: true, fileName: 'assets/file.obj');

    // Posiciona el segundo cubo en la esquina del primer cubo
    _c!.position.x = 5.0;
    _c!.position.y = 5.0;
    _c!.position.z = 5.0;

    _cube!.add(_c!);
    scene.world.add(_cube!);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 30000), vsync: this)
      ..addListener(() {
        if (_cube != null) {
          // Rotación del primer cubo alrededor de su propio eje Y
          _cube!.rotation.y = _controller.value * 360;

          // Rotación del segundo cubo alrededor de la esquina del primer cubo
          _c!.rotation.y = _controller.value * 360;
          _c!.updateTransform();

          _cube!.updateTransform();
          _scene.update();
        }
      })
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title ?? 'Flutter "hola"'),
      ),
      body: Center(
        child: Cube(
          onSceneCreated: _onSceneCreated,
        ),
      ),
    );
  }
}
