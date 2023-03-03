import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gerenciaestadosblock/widgets/imc_gauge.dart';
import 'package:gerenciaestadosblock/widgets/imc_gauge_range.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class ImcSetState extends StatefulWidget {
  const ImcSetState({Key? key}) : super(key: key);

  @override
  State<ImcSetState> createState() => _ImcSetStateState();
}

class _ImcSetStateState extends State<ImcSetState> {
  void _calcIMC({required double peso, required double altura}) async{
    setState(() {
      imc = 0;
    });
    await Future.delayed(Duration(seconds: 1));
    //calculo imc
    setState(() {
      imc = peso / pow(altura, 2); //imc
    });
  }
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var imc = 0.0;

  @override
  void dispose() {
    // TODO: implement dispose
    pesoEC.dispose();
    alturaEC.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('IMC Set State'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ImcGauge(imc: imc),
                SizedBox(
                  height: 20,
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
                        double altura = formatter.parse(alturaEC.text) as double;

                        _calcIMC(peso: peso, altura: altura);
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
