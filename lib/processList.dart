// crear un stateful widget
import 'package:app_flutter_esp32_brazo_robotico2/data.dart' as data;
import 'package:app_flutter_esp32_brazo_robotico2/processDetail.dart';
import 'package:flutter/material.dart';

class ProcessList extends StatefulWidget {
  const ProcessList({super.key});

  @override
  State<ProcessList> createState() => _ProcessListState();
}

class _ProcessListState extends State<ProcessList> {
  List<data.Process> processListData = data.getData();
  data.Process defaultProcess = data.defaultProcess;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    processListData = data.getData();
    print("se ejecuto init state");
  }

  void refresh() {
    setState(() {
      processListData = data.getData();
    });
    print("se ejecuto init state22");
  }
  // state when return to this page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Procesos'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                refresh();
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                data.addProcess(defaultProcess.name, defaultProcess.description, defaultProcess.steps);
              });
            },
            label: const Text('Nuevo Proceso'),
            icon: const Icon(Icons.add),
            backgroundColor: Colors.amber),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: processListData.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.list),
                  title: Text(processListData[index].name),
                  subtitle: Text(processListData[index].description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProcessDetail(
                          process: processListData[index],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ));
  }
}
