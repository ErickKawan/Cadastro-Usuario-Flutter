import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CadastroUsuarioApp());
}

class CadastroUsuarioApp extends StatelessWidget {
  const CadastroUsuarioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Usuário',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3159C9)),
        scaffoldBackgroundColor: const Color(0xFFF6F8FC),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFD9E0ED)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFF3159C9),
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
      home: const TelaCadastro(),
    );
  }
}

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  bool _senhaVisivel = false;

  // Exige texto antes e depois do @ e um domínio com ponto.
  final RegExp _emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  final RegExp _somenteNumeros = RegExp(r'^\d+$');

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  InputDecoration _decoracao(String rotulo, IconData icone) {
    return InputDecoration(
      labelText: rotulo,
      prefixIcon: Icon(icone),
    );
  }

  String? _validarObrigatorio(String? valor, String nomeDoCampo) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Informe $nomeDoCampo.';
    }
    return null;
  }

  void _cadastrar() {
    FocusScope.of(context).unfocus();
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();

    // Valida todos os campos e mostra as mensagens logo abaixo deles.
    if (!_formKey.currentState!.validate()) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Corrija os campos destacados antes de cadastrar.'),
          backgroundColor: Color(0xFFB3261E),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Exemplo acadêmico: o cadastro é validado localmente; não há servidor.
    messenger.showSnackBar(
      const SnackBar(
        content: Text('Cadastro realizado com sucesso!'),
        backgroundColor: Color(0xFF17804B),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
        centerTitle: true,
        backgroundColor: const Color(0xFF3159C9),
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12),
                    const Icon(
                      Icons.person_add_alt_1_rounded,
                      size: 64,
                      color: Color(0xFF3159C9),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Crie sua conta',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1C2B48),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Preencha seus dados para realizar o cadastro.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF64748B)),
                    ),
                    const SizedBox(height: 28),

                    // 1. Nome completo: texto livre e obrigatório.
                    TextFormField(
                      controller: _nomeController,
                      decoration: _decoracao(
                        'Nome completo',
                        Icons.person_outline,
                      ),
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.name],
                      validator: (valor) =>
                          _validarObrigatorio(valor, 'seu nome completo'),
                    ),
                    const SizedBox(height: 16),

                    // 2. E-mail: obrigatório e validado por expressão regular.
                    TextFormField(
                      controller: _emailController,
                      decoration: _decoracao(
                        'E-mail',
                        Icons.email_outlined,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autocorrect: false,
                      autofillHints: const [AutofillHints.email],
                      validator: (valor) {
                        if (valor == null || valor.trim().isEmpty) {
                          return 'Informe seu e-mail.';
                        }
                        if (!_emailRegex.hasMatch(valor.trim())) {
                          return 'Digite um e-mail válido (ex.: nome@email.com).';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // 3. CPF: somente dígitos, sem pontos ou traços.
                    TextFormField(
                      controller: _cpfController,
                      decoration: _decoracao(
                        'CPF (somente números)',
                        Icons.badge_outlined,
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (valor) {
                        if (valor == null || valor.isEmpty) {
                          return 'Informe seu CPF.';
                        }
                        if (!_somenteNumeros.hasMatch(valor)) {
                          return 'O CPF deve conter apenas números.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // 4. Telefone: somente dígitos.
                    TextFormField(
                      controller: _telefoneController,
                      decoration: _decoracao(
                        'Telefone (somente números)',
                        Icons.phone_outlined,
                      ),
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (valor) {
                        if (valor == null || valor.isEmpty) {
                          return 'Informe seu telefone.';
                        }
                        if (!_somenteNumeros.hasMatch(valor)) {
                          return 'O telefone deve conter apenas números.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // 5. Senha: mínimo de 6 caracteres e visibilidade opcional.
                    TextFormField(
                      controller: _senhaController,
                      decoration: _decoracao(
                        'Senha',
                        Icons.lock_outline,
                      ).copyWith(
                        suffixIcon: IconButton(
                          tooltip: _senhaVisivel
                              ? 'Ocultar senha'
                              : 'Mostrar senha',
                          icon: Icon(
                            _senhaVisivel
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          onPressed: () {
                            setState(() => _senhaVisivel = !_senhaVisivel);
                          },
                        ),
                      ),
                      obscureText: !_senhaVisivel,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      enableSuggestions: false,
                      autocorrect: false,
                      autofillHints: const [AutofillHints.newPassword],
                      validator: (valor) {
                        if (valor == null || valor.isEmpty) {
                          return 'Informe sua senha.';
                        }
                        if (valor.length < 6) {
                          return 'A senha deve ter no mínimo 6 caracteres.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Desafio extra: confirmação de senha.
                    TextFormField(
                      controller: _confirmarSenhaController,
                      decoration: _decoracao(
                        'Confirmar senha',
                        Icons.verified_user_outlined,
                      ),
                      obscureText: !_senhaVisivel,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      enableSuggestions: false,
                      autocorrect: false,
                      autofillHints: const [AutofillHints.newPassword],
                      validator: (valor) {
                        if (valor == null || valor.isEmpty) {
                          return 'Confirme sua senha.';
                        }
                        if (valor != _senhaController.text) {
                          return 'As senhas não coincidem.';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) => _cadastrar(),
                    ),
                    const SizedBox(height: 24),

                    // Botão que valida e apresenta o SnackBar de resultado.
                    SizedBox(
                      height: 54,
                      child: ElevatedButton.icon(
                        onPressed: _cadastrar,
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text('CADASTRAR'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3159C9),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
