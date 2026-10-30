import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cadastro_usuario_flutter/main.dart';

void main() {
  testWidgets('Mostra erros ao tentar cadastrar sem preencher os campos', (
    tester,
  ) async {
    await tester.pumpWidget(const CadastroUsuarioApp());
    await tester.ensureVisible(find.text('CADASTRAR'));
    await tester.tap(find.text('CADASTRAR'));
    await tester.pumpAndSettle();

    expect(find.text('Informe seu nome completo.'), findsOneWidget);
    expect(find.text('Informe seu e-mail.'), findsOneWidget);
    expect(find.text('Informe seu CPF.'), findsOneWidget);
    expect(find.text('Informe seu telefone.'), findsOneWidget);
    expect(find.text('Informe sua senha.'), findsOneWidget);
    expect(find.text('Confirme sua senha.'), findsOneWidget);
  });

  testWidgets('Mostra sucesso ao preencher todos os dados válidos', (
    tester,
  ) async {
    await tester.pumpWidget(const CadastroUsuarioApp());
    final campos = find.byType(TextFormField);
    final dados = [
      'Ana Silva',
      'ana@email.com',
      '12345678901',
      '11987654321',
      'senha123',
      'senha123',
    ];

    for (var i = 0; i < dados.length; i++) {
      await tester.ensureVisible(campos.at(i));
      await tester.enterText(campos.at(i), dados[i]);
    }
    await tester.ensureVisible(find.text('CADASTRAR'));
    await tester.tap(find.text('CADASTRAR'));
    await tester.pumpAndSettle();

    expect(find.text('Cadastro realizado com sucesso!'), findsOneWidget);
  });
}
