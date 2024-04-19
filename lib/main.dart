import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatefulWidget {
  const MeuApp({super.key});

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  final List<Tarefa> _tarefas = [];
  final TextEditingController controlador = TextEditingController();
  late Tarefa tarefaAtual;
  String modoAtual = 'add';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Afazeres'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (context, index) {
                  return Row(children: [
                    Container(
                      color: _tarefas[index].cor,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            _tarefas[index].descricao,
                          ),
                          if (!_tarefas[index].status)
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  tarefaAtual = _tarefas[index];
                                  controlador.text = _tarefas[index].descricao;
                                  modoAtual = 'edit';
                                });
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blue[400],
                              ),
                            ),
                          if (!_tarefas[index].status)
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _tarefas[index].status = true;
                                  _tarefas[index].cor = Colors.green;
                                });
                              },
                              icon: Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                            ),
                          if (!_tarefas[index].status)
                            IconButton(
                              alignment: Alignment.center,
                              onPressed: () {
                                setState(() {
                                  _tarefas.remove(_tarefas[index]);
                                });
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red[500],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ]);
                },
              ),
            ),
            if (modoAtual == 'add')
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: controlador,
                        decoration: const InputDecoration(
                          hintText: 'Descrição',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(Size(200, 60)),
                      ),
                      child: const Text('Adicionar Tarefa'),
                      onPressed: () {
                        if (controlador.text.isEmpty) {
                          return;
                        }
                        setState(() {
                          _tarefas.add(
                            Tarefa(
                                descricao: controlador.text,
                                status: false,
                                cor: Colors.white),
                          );
                          controlador.clear();
                        });
                      },
                    ),
                  ),
                ],
              ),
            if (modoAtual == 'edit')
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: controlador,
                        decoration: const InputDecoration(
                          hintText: 'Nova Descrição',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(Size(200, 60)),
                      ),
                      child: const Text('Editar Tarefa'),
                      onPressed: () {
                        if (controlador.text.isEmpty) {
                          return;
                        }
                        setState(() {
                          tarefaAtual.descricao = controlador.text;
                          controlador.clear();
                          modoAtual = 'add';
                        });
                      },
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class Tarefa {
  String descricao;
  Color cor;
  bool status;

  Tarefa({required this.descricao, required this.status, required this.cor});
}
