import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:gerenciaestadosblock/bloc_pattern/imc_bloc_pattern_controller.dart';
import 'package:gerenciaestadosblock/bloc_pattern/imc_state.dart';
import 'package:intl/intl.dart';

import '../widgets/imc_gauge.dart';

class BlocPAtternPage extends StatefulWidget {
  const BlocPAtternPage({Key? key}) : super(key: key);

  @override
  State<BlocPAtternPage> createState() => _BlocPAtternPageState();
}

class _BlocPAtternPageState extends State<BlocPAtternPage> {
  final controller = ImcBlocPatternController();
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  //var imc = 0.0;

  @override
  void dispose() {
    // TODO: implement dispose
    pesoEC.dispose();
    alturaEC.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMC BlockPattern'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                StreamBuilder<ImcState>(
                  stream: controller.imcOut, //quem ele vai escutar
                  builder: (context, snapshot) {
                    var imc = snapshot.data?.imc ?? 0.0;
                    // if(snapshot.hasData){
                    //   imc = snapshot.data?.imc ?? 0;
                    // }
                    return ImcGauge(imc: imc);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder<ImcState>(
                  stream: controller.imcOut,
                  builder: (context, snapshot) {
                    final dataValue = snapshot.data;
                    if (dataValue is ImcStateLoading) {
                      return Center(child: CircularProgressIndicator());
                    };


                    if (dataValue is ImcStateError) {
                      return Text(dataValue.message);
                    }
                    return SizedBox.shrink();
                  }
                ),
                TextFormField(
                  controller: pesoEC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Peso',
                  ),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                        locale: 'pt_BR', //vigula por ponto
                        symbol: '',
                        decimalDigits: 2,
                        turnOffGrouping: true)
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Peso obrigatório';
                    }
                  },
                ),
                TextFormField(
                  controller: alturaEC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Altura',
                  ),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                        locale: 'pt_BR', //vigula por ponto
                        symbol: '',
                        decimalDigits: 2,
                        turnOffGrouping: true),
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Alutra obrigatória';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      var formValid = formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        var formatter = NumberFormat.simpleCurrency(
                          //formatador
                          locale: 'pt_BR', //como ele vai receber
                          decimalDigits: 2,
                        );
                        double peso = formatter.parse(pesoEC.text) as double;
                        double altura =
                            formatter.parse(alturaEC.text) as double;

                        controller.CalcularImc(peso: peso, altura: altura);
                        //_calcIMC(peso: peso, altura: altura);
                      }
                    },
                    child: Text('Calcular IMC'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
