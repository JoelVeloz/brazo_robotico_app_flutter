import 'dart:math';

import 'package:http/http.dart' as http;

enum SliderKey {
  garra,
  // ignore: constant_identifier_names
  muneca_pitch,
  // ignore: constant_identifier_names
  muneca_yaw,
  codo,
  antebrazo,
  base,
}

class Step {
  SliderKey name;
  String rotation;
  int time;
  Step(this.name, this.rotation, this.time);
}

class Process {
  String uuid;
  String name;
  String description;
  List<Step> steps;

  Process(this.uuid, this.name, this.description, this.steps);
}

List<Process> processList = [
  Process(
    'asdasdasdsad',
    'Proceso 1',
    'Descripcion del proceso 1',
    [
      Step(SliderKey.garra, '0', 1000),
      Step(SliderKey.muneca_pitch, '0', 1000),
      Step(SliderKey.muneca_yaw, '0', 1000),
      Step(SliderKey.codo, '0', 1000),
      Step(SliderKey.antebrazo, '0', 1000),
      Step(SliderKey.base, '0', 1000),
    ],
  ),
];
const defaultSpeed = 200;

void initData() {
  processList.clear();
  // AHORA GENERA PROCESOS CON DATOS ALEATORIOS
  for (var i = 0; i < 3; i++) {
    randoIntBetween(int min, int max) => min + Random().nextInt(max - min);
    processList.add(Process(
      generateUUID(),
      'Proceso $i',
      'Descripcion del proceso $i',
      [
        Step(SliderKey.garra, randoIntBetween(0, 180).toString(), defaultSpeed),
        Step(SliderKey.muneca_pitch, randoIntBetween(0, 180).toString(), defaultSpeed),
        Step(SliderKey.muneca_yaw, randoIntBetween(0, 180).toString(), defaultSpeed),
        Step(SliderKey.codo, randoIntBetween(0, 180).toString(), defaultSpeed),
        Step(SliderKey.antebrazo, randoIntBetween(0, 180).toString(), defaultSpeed),
        Step(SliderKey.base, randoIntBetween(0, 180).toString(), defaultSpeed),
      ],
    ));
  }
}

List<Process> getData() {
  // LIMPIA processList

  return processList;
}

String generateUUID() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}

void addProcess(String name, String description, List<Step> steps) {
  processList.add(Process(generateUUID(), name, description, steps));
}

void deleteProcess(String uuid) {
  processList.removeWhere((element) => element.uuid == uuid);
}

void deleteStepForProcess(String uuid, int index) {
  processList.firstWhere((element) => element.uuid == uuid).steps.removeAt(index);
}

void addStepForProcess(String uuid, Step step) {
  processList.firstWhere((element) => element.uuid == uuid).steps.add(step);
}

void updateStepForProcess(String uuid, Step step, int index) {
  processList.firstWhere((element) => element.uuid == uuid).steps[index] = step;
}
void updateProcess(String uuid, String name, String description) {
  processList.firstWhere((element) => element.uuid == uuid).name = name;
  processList.firstWhere((element) => element.uuid == uuid).description = description;
}

void playProcess(String uuid) async {
  Process process = processList.firstWhere((element) => element.uuid == uuid);

  for (var step in process.steps) {
    print(step.name);
    print(step.rotation);
    print(step.time);
    await Future.delayed(Duration(milliseconds: step.time));
    // call api
    sendDataToArduino(step.name.toString().split('.').last, step.rotation);
  }
}

// default value
Process defaultProcess = Process(
  generateUUID(),
  'Proceso 2',
  'Descripcion del proceso 2',
  [
    Step(SliderKey.garra, '0', defaultSpeed),
    Step(SliderKey.muneca_pitch, '0', defaultSpeed),
    Step(SliderKey.muneca_yaw, '0', defaultSpeed),
    Step(SliderKey.codo, '0', defaultSpeed),
    Step(SliderKey.antebrazo, '0', defaultSpeed),
    Step(SliderKey.base, '0', defaultSpeed),
  ],
);

void sendDataToArduino(String varName, String varValue) async {
  String _ipRed = "192.168.4.1";
  try {
    var url = Uri.parse('http://$_ipRed/servos?varName=$varName&varValue=$varValue');
    print(url.toString());
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  } catch (e) {
    print('error');
    print(e);
  }
}
