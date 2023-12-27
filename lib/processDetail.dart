import 'package:app_flutter_esp32_brazo_robotico2/app.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter_esp32_brazo_robotico2/data.dart' as data;

class ProcessDetail extends StatefulWidget {
  final data.Process process;

  const ProcessDetail({Key? key, required this.process}) : super(key: key);

  @override
  _ProcessDetailState createState() => _ProcessDetailState();
}

class _ProcessDetailState extends State<ProcessDetail> {
  List<data.Process> processListData = data.getData();
  void refresh() {
    setState(() {
      processListData = data.getData();
    });
    print("se ejecuto init state22");
  }

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.process.name);
    _descriptionController = TextEditingController(text: widget.process.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.process.name}",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'RobotoMono')),
        actions: [
          // save button
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              setState(() {
                data.updateProcess(
                  widget.process.uuid, _nameController.text, // Use the controller value
                  _descriptionController.text,
                );
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              setState(() {
                data.playProcess(widget.process.uuid);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                refresh();
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                data.deleteProcess(widget.process.uuid);
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            SizedBox(height: 16),
            Text('Pasos:'),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.process.steps.length,
                itemBuilder: (context, index) {
                  final step = widget.process.steps[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('${step.name.toString().split('.').last}'),
                    subtitle: Text('R: ${step.rotation}, T: ${step.time} ms'),
                    // edit button
                    leading: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SelectedStep(process: widget.process, step: step)),
                        );
                      },
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          // widget.process.steps.removeAt(index);
                          data.deleteStepForProcess(widget.process.uuid, index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  data.addStepForProcess(widget.process.uuid, data.Step(data.SliderKey.garra, '0', data.defaultSpeed));
                });
              },
              child: Text('Agregar otro paso'),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectedStep extends StatefulWidget {
  final data.Process process;
  final data.Step step;
  const SelectedStep({Key? key, required this.process, required this.step}) : super(key: key);

  @override
  State<SelectedStep> createState() => _SelectedStepState();
}

class _SelectedStepState extends State<SelectedStep> {
  late data.SliderKey selectedSliderKey;

  @override
  void initState() {
    super.initState();
    selectedSliderKey = data.SliderKey.garra; // Puedes establecer un valor predeterminado aquí si lo deseas
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.step.name.toString().split('.').last),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              DropdownButton<data.SliderKey>(
                value: selectedSliderKey,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (data.SliderKey? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedSliderKey = newValue;
                    });
                  }
                },
                items: data.SliderKey.values.map((data.SliderKey value) {
                  return DropdownMenuItem<data.SliderKey>(
                    value: value,
                    child: Text(value.toString().split('.').last),
                  );
                }).toList(),
              ),
              SizedBox(height: 50),
              SliderComponent(
                keyValue: selectedSliderKey.toString().split('.').last,
                label: selectedSliderKey.toString().split('.').last,
                onChangedCallback: (value) {
                  setState(() {
                    widget.step.rotation = value.round().toString();
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    data.updateStepForProcess(widget.process.uuid, data.Step(selectedSliderKey, widget.step.rotation, data.defaultSpeed),
                        widget.process.steps.indexOf(widget.step));
                  });
                  Navigator.pop(context);
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ));
  }
}
