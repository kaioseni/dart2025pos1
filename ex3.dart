// Exercicio 16

void main() {
  DateTime hoje = DateTime.now();
  DateTime primeiroDiaMes = DateTime(hoje.year, hoje.month, 1);
 
  print( D  S  T  Q  Q  S  S );
 
  int inicioSemana = primeiroDiaMes.weekday % 7; 

  String linha = ;
 
  for (int i = 0; i  inicioSemana; i++) {
    linha +=     ;
  }
 
  for (int dia = 1; dia = hoje.day; dia++) {
    String diaFormatado = dia.toString().padLeft(2, '0');
    linha +=  $diaFormatado;
 
    DateTime dataAtual = DateTime(hoje.year, hoje.month, dia);
    if (dataAtual.weekday == DateTime.sunday) {
      linha += ;
      print(linha);
      linha = ;
    }
  }
 
  if (linha.isNotEmpty) {
    linha += ;
    print(linha);
  }
}
