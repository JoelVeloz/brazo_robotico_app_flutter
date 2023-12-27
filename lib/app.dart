// ignore_for_file: library_private_types_in_public_api, avoid_print
import 'package:app_flutter_esp32_brazo_robotico2/data.dart' as data;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SliderComponent extends StatefulWidget {
  final String label;
  final String keyValue;
  final void Function(double)? onChangedCallback;

  const SliderComponent({
    Key? key,
    required this.label,
    required this.keyValue,
    this.onChangedCallback,
  }) : super(key: key);

  @override
  _SliderComponentState createState() => _SliderComponentState();
}

class _SliderComponentState extends State<SliderComponent> {
  double _value = 0.0;
  double _previousValue = 0.0;
  final double _divisions = 18;
  final double _max = 180;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('0.0'),
            SizedBox(
              width: 200,
              child: Text("[${_value.round().toString()}]  ${widget.label}", style: const TextStyle(fontSize: 20)),
            ),
            Text(_max.toString()),
          ],
        ),
        Slider(
          value: _value,
          min: 0.0,
          max: _max,
          divisions: _divisions.toInt(),
          onChanged: (value) {
            if (value != _previousValue) {
              setState(() {
                _value = value;
                _previousValue = value;
              });
              data.sendDataToArduino(widget.keyValue, value.toString());
              // widget.onChangedCallback(value);
              widget.onChangedCallback?.call(value);
            }
          },
        ),
      ],
    );
  }
}

class SliderArms extends StatefulWidget {
  const SliderArms({Key? key}) : super(key: key);

  @override
  State<SliderArms> createState() => _SliderArmsState();
}

class _SliderArmsState extends State<SliderArms> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 700,
        width: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            SliderComponent(label: "Garra", keyValue: 'garra'),
            SliderComponent(label: "Muñeca Pitch", keyValue: 'muneca_pitch'),
            SliderComponent(label: "Muñeca Yaw", keyValue: 'muneca_yaw'),
            SliderComponent(label: "Codo", keyValue: 'codo'),
            SliderComponent(label: "Antebrazo", keyValue: 'antebrazo'),
            SliderComponent(label: "Base", keyValue: 'base'),
          ],
        ),
      ),
    );
  }
}
