import 'dart:async';
import 'dart:math';

import 'package:gerenciaestadosblock/bloc_pattern/imc_state.dart';

class ImcBlocPatternController{
  final _imcStreamController = StreamController<ImcState>.broadcast()
    ..add(ImcStateLoading());//criandoa  stream controller e adcionando o tipo
  Stream<ImcState> get imcOut => _imcStreamController.stream;

  Future<void> CalcularImc({required double peso, required double altura})async{
    try {
      _imcStreamController.add(ImcStateLoading());
      await Future.delayed(Duration(seconds: 1));
     // throw Exception();
      final imc = peso/pow(altura, 2);
      _imcStreamController.add(ImcState(imc: imc));
    } on Exception catch (e) {
      _imcStreamController.add(ImcStateError(message: 'Erro ao caluclar o IMC'));
      // TODO
    }
  }













  void dispose(){
    _imcStreamController.close();
  }
}