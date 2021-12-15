import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projeto/models/cliente.dart';
import 'package:flutter_projeto/screens/home/models/form_cliente.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ClienteFormWidget extends StatefulWidget {
  final Cliente? cliente;

  ClienteFormWidget({Key? key, this.cliente}) : super(key: key);

  @override
  State<ClienteFormWidget> createState() => _ClienteFormWidgetState();
}

class _ClienteFormWidgetState extends State<ClienteFormWidget> {
  final FormCliente formCliente = FormCliente();

  final maskCPF = MaskTextInputFormatter(mask: '###.###.###-##');
  final maskData = MaskTextInputFormatter(mask: '##/##/####');
  final maskCel = MaskTextInputFormatter(mask: '(##)#####-####');

  Future<void> _sumit(BuildContext context) async {
    final cliente = await formCliente.sumit();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              (cliente == null) ? 'Falta Cadastro' : 'Cadastrado com sucesso'),
          content: Text((cliente == null) ? 'Tente novamente' : ''),
        );
      },
    );

    if (cliente != null) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    if (widget.cliente != null) {
      final cliente = widget.cliente!;
      formCliente.form.control('id').value = cliente.id.toString();
      formCliente.form.control('nome').value = cliente.nome;
      formCliente.form.control('numeroMatricula').value =
          cliente.numeroMatricula;
      formCliente.form.control('rg').value = cliente.rg;
      formCliente.form.control('cpf').value = cliente.cpf;
      formCliente.form.control('ra').value = cliente.ra;
      formCliente.form.control('dataNascimento').value = cliente.dataNascimento;
      formCliente.form.control('numeroContato').value = cliente.numeroContato;
      formCliente.form.control('nomeResponsavel').value =
          cliente.nomeResponsavel;
      formCliente.form.control('rgResponsavel').value = cliente.rgResponsavel;
      formCliente.form.control('cpfResponsavel').value = cliente.cpfResponsavel;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Card(
        child: ReactiveForm(
          formGroup: formCliente.form,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ReactiveTextField(
                formControlName: 'nome',
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z- -]"))
                ],
              ),
              SizedBox(height: 8),
              ReactiveTextField(
                formControlName: 'numeroMatricula',
                decoration: InputDecoration(
                  labelText: 'Numero de Matricula',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              SizedBox(height: 8),
              ReactiveTextField(
                formControlName: 'ra',
                decoration: InputDecoration(
                  labelText: "RA",
                ),
                maxLength: 11,
              ),
              SizedBox(height: 8),
              ReactiveTextField(
                formControlName: 'rg',
                decoration: InputDecoration(
                  labelText: 'RG',
                ),
                maxLength: 11,
              ),
              SizedBox(height: 8),
              ReactiveTextField(
                formControlName: 'cpf',
                decoration: InputDecoration(
                  labelText: 'CPF',
                ),
                inputFormatters: [maskCPF],
              ),
              SizedBox(height: 8),
              ReactiveTextField(
                formControlName: 'dataNascimento',
                decoration: InputDecoration(
                  labelText: 'Data de Nascimento',
                ),
                inputFormatters: [maskData],
              ),
              SizedBox(height: 8),
              ReactiveTextField(
                formControlName: 'numeroContato',
                decoration: InputDecoration(
                  labelText: 'Numero para Contato',
                ),
                inputFormatters: [maskCel],
              ),
              SizedBox(height: 8),
              ReactiveTextField(
                formControlName: 'nomeResponsavel',
                decoration: InputDecoration(
                  labelText: 'Nome do Responsavel',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z- -]"))
                ],
              ),
              SizedBox(height: 8),
              ReactiveTextField(
                formControlName: 'rgResponsavel',
                decoration: InputDecoration(
                  labelText: 'RG do Responsavel',
                ),
                maxLength: 11,
              ),
              SizedBox(height: 8),
              ReactiveTextField(
                formControlName: 'cpfResponsavel',
                decoration: InputDecoration(
                  labelText: 'CPF do Responsavel',
                ),
                inputFormatters: [maskCPF],
              ),
              SizedBox(
                height: 16,
              ),
              ReactiveFormConsumer(
                builder: (context, form, _) {
                  return ElevatedButton(
                    onPressed: (form.valid) ? () => _sumit(context) : null,
                    child: Text('Cadastrar'),
                  );
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
