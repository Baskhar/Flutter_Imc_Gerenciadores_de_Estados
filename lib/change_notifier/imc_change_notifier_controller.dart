import 'dart:math';

import 'package:flutter/cupertino.dart';

class ImcChangeNotifierController extends ChangeNotifier{
  var imc = 0.0;

  Future<void> calcularIMC({required double peso,required double altura})async{
    imc = 0;
    notifyListeners();//notificar mudança
    await Future.delayed((Duration(seconds: 1)));
    imc= peso / pow (altura,2);
    notifyListeners();//notificar mudança
  }

}