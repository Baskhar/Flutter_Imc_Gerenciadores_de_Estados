import 'package:flutter/material.dart';
import 'package:gerenciaestadosblock/bloc_pattern/imc_bloc_pattern_page.dart';
import 'package:gerenciaestadosblock/change_notifier/imc_change_notifier_page.dart';
import 'package:gerenciaestadosblock/setState/imc_setstate_page.dart';
import 'package:gerenciaestadosblock/value_notifier/value_notifier_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _goToPage(BuildContext context, Widget page) {//função de navegação
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => page,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              _goToPage(context, ImcSetState());
            }, child: Text('Set State')),
            ElevatedButton(onPressed: () {
              _goToPage(context, ValueNotifierPage());
            }, child: Text('ChangeNotifier')),
            ElevatedButton(onPressed: () {
              _goToPage(context, ChangeNotifierPage());
            }, child: Text('ValueNotifier')),
            ElevatedButton(
                onPressed: () {
                  _goToPage(context, BlocPAtternPage());
                }, child: Text('Streams (Block Patterner')),
          ],
        ),
      ),
    );
  }
}
