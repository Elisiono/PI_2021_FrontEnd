import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projeto/models/cliente.dart';
import 'package:flutter_projeto/screens/home/widgets/cliente_form_widget.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pesquisa = fb.control(''),
      pesquisaRG = fb.control(''),
      pesquisaCPF = fb.control(''),
      pesquisaRA = fb.control('');
  List<Cliente> clientes = [];

  final maskCPF = MaskTextInputFormatter(mask: '###.###.###-##');

  Future<void> _showModel(BuildContext context, {Cliente? cliente}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Center(child: ClienteFormWidget(cliente: cliente));
      },
    );

    return;
  }

  Future<void> _pesquisar() async {
    final result = await Cliente.pesquisar(pesquisa.value!);

    setState(() {
      clientes = result;
    });
  }

  Future<void> _pesquisarRG() async {
    final result = await Cliente.pesquisarRG(pesquisaRG.value!);

    setState(() {
      clientes = result;
    });
  }

  Future<void> _pesquisarCPF() async {
    final result = await Cliente.pesquisarCPF(pesquisaCPF.value!);

    setState(() {
      clientes = result;
    });
  }

  Future<void> _pesquisarRA() async {
    final result = await Cliente.pesquisarRA(pesquisaRA.value!);

    setState(() {
      clientes = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prontuarios'),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Pesquisar Prontuario'),
              ),
              ReactiveTextField(
                formControl: pesquisa,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Digite o Nome',
                ),
                onSubmitted: _pesquisar,
              ),
              ListTile(
                title: Text('Pesquisa por RA'),
              ),
              ReactiveTextField(
                formControl: pesquisaRA,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Digite o numero do RA sem ponto ou traço',
                ),
                maxLength: 11,
                onSubmitted: _pesquisarRA,
              ),
              ListTile(
                title: Text('Pesquisa por RG'),
              ),
              ReactiveTextField(
                formControl: pesquisaRG,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Digite o numero do RG sem ponto ou traço',
                ),
                maxLength: 11,
                onSubmitted: _pesquisarRG,
              ),
              ListTile(
                title: Text('Pesquisa por CPF'),
              ),
              ReactiveTextField(
                formControl: pesquisaCPF,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Digite o numero do CPF sem ponto ou traço',
                ),
                inputFormatters: [maskCPF],
                onSubmitted: _pesquisarCPF,
              ),
              SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: clientes.length,
                  itemBuilder: (context, index) {
                    final cliente = clientes[index];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(clientes[index].nome),
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                dense: true,
                                title: Text('Matricula'),
                                subtitle: Text(cliente.numeroMatricula),
                              ),
                              ListTile(
                                dense: true,
                                title: Text('RA'),
                                subtitle: Text(cliente.ra),
                              ),
                              ListTile(
                                dense: true,
                                title: Text('CPF'),
                                subtitle: Text(cliente.cpf),
                              ),
                              ListTile(
                                dense: true,
                                title: Text('RG'),
                                subtitle: Text(cliente.rg),
                              )
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () => _showModel(
                              context,
                              cliente: cliente,
                            ),
                            icon: Icon(Icons.edit),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showModel(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
