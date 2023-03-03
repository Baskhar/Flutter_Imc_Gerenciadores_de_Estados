class ImcState{
  final double? imc;

  ImcState({this.imc});


}

class ImcStateLoading extends ImcState{//classe loader

}
class ImcStateError extends ImcState {
  String message;

  ImcStateError({
    required this.message
  });
}