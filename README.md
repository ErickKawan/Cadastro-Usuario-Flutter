# Cadastro de Usuário em Flutter

**Disciplina:** Desenvolvimento Mobile  
**Atividade:** Formulário de Cadastro de Usuário  
**Aluno:** Erick Kawan Gomes da Rocha

## Sobre a atividade

Aplicativo de demonstração que implementa um formulário de cadastro de usuário com `Scaffold`, `Form`, `SingleChildScrollView`, `Column`, `TextFormField` e `ElevatedButton`.

### Funcionalidades

- Nome completo obrigatório.
- E-mail obrigatório, validado por expressão regular.
- CPF obrigatório, apenas números.
- Telefone obrigatório, apenas números.
- Senha obrigatória, com no mínimo seis caracteres.
- Mensagens específicas abaixo de cada campo inválido.
- `SnackBar` verde após validação bem-sucedida.
- Desafios extras: confirmar senha; mostrar/ocultar senha; validar e-mail por `RegExp`; `SnackBar` vermelho para dados inválidos.
- Layout rolável, evitando problemas de overflow ao abrir o teclado.

**Importante:** este é um exercício de interface e validação. A mensagem de sucesso indica que os dados passaram pela validação local; **não são enviados a um servidor nem salvos em banco de dados**.

## Pré-requisitos

1. [Flutter SDK](https://docs.flutter.dev/install/with-vs-code), instalado e configurado no `PATH`.
2. [Visual Studio Code](https://code.visualstudio.com/), com extensão **Flutter** (ela instala a extensão Dart).
3. [Git para Windows](https://git-scm.com/downloads/win), para publicar no GitHub.
4. Para testar no navegador: **Google Chrome**. Para um dispositivo Android: configurar Android Studio/SDK ou um aparelho com depuração USB.

Confira a instalação no terminal do VS Code (PowerShell):

```powershell
flutter --version
flutter doctor
```

## Como abrir e executar

1. Extraia o ZIP e abra a pasta **cadastro_usuario_flutter** no VS Code (**Arquivo > Abrir Pasta**).
2. Abra **Terminal > Novo Terminal**.
3. Execute, dentro dessa pasta:

```powershell
flutter create . --platforms=android,web
flutter pub get
flutter run -d chrome
```

O comando `flutter create .` completa as pastas de plataforma (`android/` e `web/`) necessárias para executar o projeto fornecido. O código do formulário está em `lib/main.dart`.

Para executar no Android, inicie um emulador ou conecte um dispositivo e rode:

```powershell
flutter devices
flutter run
```

Para rodar os testes automatizados e a análise estática:

```powershell
flutter test
flutter analyze
```

## Como testar o formulário

- Tente cadastrar com todos os campos vazios: os erros devem aparecer logo abaixo dos respectivos campos, além do aviso vermelho.
- Digite e-mail inválido: a mensagem de validação deve aparecer.
- Digite letras ou pontuação no CPF e telefone: o filtro permite apenas dígitos.
- Digite uma senha com menos de seis caracteres: a validação deverá rejeitá-la.
- Digite duas senhas diferentes: o campo de confirmação mostrará o erro.
- Preencha tudo corretamente: aparecerá o `SnackBar` verde de sucesso.

Exemplo de preenchimento para demonstração (dados fictícios):

| Campo | Exemplo |
| --- | --- |
| Nome | Ana Silva |
| E-mail | ana@email.com |
| CPF | 12345678901 |
| Telefone | 11987654321 |
| Senha | senha123 |
| Confirmação | senha123 |

*Observação:* CPF e telefone são validados para aceitar somente dígitos, conforme o enunciado. Não há validação de dígitos verificadores do CPF nem verificação de linha telefônica.

## Publicar no GitHub

1. No GitHub, crie um repositório público chamado `cadastro_usuario_flutter`: <https://github.com/new>.
2. **Deixe desmarcadas** as opções de inicialização com README, `.gitignore` e licença (esses arquivos já vêm no ZIP).
3. No terminal do VS Code, ainda na pasta raiz do projeto, execute os comandos abaixo. Substitua o nome e e-mail da configuração somente se o Git solicitar que você os configure.

```powershell
git init
git branch -M main
git add .
git commit -m "Atividade de cadastro de usuario em Flutter"
git remote add origin https://github.com/ErickKawan/cadastro_usuario_flutter.git
git push -u origin main
```

Se o Git pedir sua identidade antes do commit:

```powershell
git config --global user.name "Erick Kawan"
git config --global user.email "SEU_EMAIL_DO_GITHUB"
```

O GitHub poderá solicitar autenticação no navegador. Não compartilhe senhas ou tokens.

Nas próximas alterações:

```powershell
git add .
git commit -m "Atualiza formulario Flutter"
git push
```

Se aparecer `remote origin already exists`, verifique `git remote -v` antes de alterar o repositório remoto.

## Entrega pelo AVA

1. Execute o aplicativo e preencha os dados fictícios válidos.
2. Clique em **CADASTRAR**, com o `SnackBar` verde exibido.
3. Faça uma captura de tela (no Windows: **Win + Shift + S**) e salve como `print_cadastro.png`.
4. Envie o print e o link do repositório: <https://github.com/ErickKawan/cadastro_usuario_flutter>.

## Estrutura do projeto

```text
cadastro_usuario_flutter/
├── lib/
│   └── main.dart                # Tela e validações
├── test/
│   └── widget_test.dart         # Testes básicos
├── .vscode/
│   └── extensions.json          # Extensões recomendadas
├── .gitignore
├── analysis_options.yaml
├── pubspec.yaml
└── README.md
```

As pastas `android/` e `web/` são geradas no seu computador ao executar `flutter create . --platforms=android,web`.
