import 'package:flutter/material.dart';

class SliderComponent extends StatelessWidget {
  final double value;
  final String label;
  final ValueChanged<double> onChanged;

  const SliderComponent({
    super.key,
    required this.value,
    required this.label,
    required this.onChanged,
  });

  final _min = 0.0;
  final _max = 180.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Column(
        children: [
          // row of 2 texts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_min.toString()),
              Container(
                width: 200,
                child: Text("[${value.round().toString()}]  ${label}",
                    style: TextStyle(fontSize: 20)),
              ),
              Text(_max.toString()),
            ],
          ),
          Slider(
            value: value,
            min: _min,
            max: _max,
            divisions: _max.toInt(),
            label: '0',
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class SliderArms extends StatefulWidget {
  const SliderArms({super.key});

  @override
  State<SliderArms> createState() => _SliderArmsState();
}

class _SliderArmsState extends State<SliderArms> {
  double _slider_1 = 0.0;
  double _slider_2 = 0.0;
  double _slider_3 = 0.0;
  double _slider_4 = 0.0;
  double _slider_5 = 0.0;
  double _slider_6 = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brazo robótico con ESP32'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SliderComponent(
              value: _slider_1,
              label: "Garra",
              onChanged: (double value) {
                setState(() {
                  _slider_1 = value;
                });
              },
            ),
            SliderComponent(
              value: _slider_2,
              label: "Muñeca Pitch",
              onChanged: (double value) {
                setState(() {
                  _slider_2 = value;
                });
              },
            ),
            SliderComponent(
              value: _slider_3,
              label: "Muñeca Yaw",
              onChanged: (double value) {
                setState(() {
                  _slider_3 = value;
                });
              },
            ),
            SliderComponent(
              value: _slider_4,
              label: "Codo",
              onChanged: (double value) {
                setState(() {
                  _slider_4 = value;
                });
              },
            ),
            SliderComponent(
              value: _slider_5,
              label: "Antebrazo",
              onChanged: (double value) {
                setState(() {
                  _slider_5 = value;
                });
              },
            ),
            SliderComponent(
              value: _slider_6, // Puedes ajustar el valor según sea necesario
              label: "Base",
              onChanged: (double value) {
                setState(() {
                  _slider_6 = value;
                });
              },
            ),
            // Repite el componente SliderComponent según sea necesario
          ],
        ),
      ),
    );
  }
}
