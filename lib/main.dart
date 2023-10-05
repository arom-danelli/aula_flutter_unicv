import 'package:aula/tarefa.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ListaDeTarefasApp());
}

class ListaDeTarefasApp extends StatelessWidget {
  const ListaDeTarefasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TelaInicial(),
    );
  }
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela Inicial')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ListaDeTarefasScreen(
                    mensagem: 'Dados da tela Inicial'),
              ),
            );
          },
          child: const Text('Iniciar uma lista de tarefas'),
        ),
      ),
    );
  }
}

class ListaDeTarefasScreen extends StatefulWidget {
  final String mensagem;
  const ListaDeTarefasScreen({super.key, required this.mensagem});

  @override
  ListaDeTarefasScreenState createState() => ListaDeTarefasScreenState();
}

class ListaDeTarefasScreenState extends State<ListaDeTarefasScreen> {
  final List<Tarefa> _tarefas = [];
  final TextEditingController _controller = TextEditingController();

  void _adicionarTarefa(String descricao) {
    setState(() {
      _tarefas.add(Tarefa(descricao, false));
      _controller.clear();
    });
  }

   void _removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Tarefas - ${widget.mensagem}')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _tarefas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_tarefas[index].descricao),
                  leading: Checkbox(  value: _tarefas[index].concluida,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _tarefas[index].concluida = newValue ?? false;
                    });
                  },
                  ), 
                  trailing: IconButton(
                    onPressed: () {
                      _removerTarefa(index);
                    },
                    icon: const Icon(Icons.delete),

                  ),               
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (descricao) {
                      _adicionarTarefa(descricao);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Adicionar Tarefa',
                    ),
                  ),
                ),
                  ElevatedButton(
                    child: const Text('Adicionar'),
                    onPressed: () {
                      if(_controller.text.isNotEmpty){
                        _adicionarTarefa(_controller.text);
                      }

                    }
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

