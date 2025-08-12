import 'package:flutter/material.dart';
import 'package:validar_cartoes/logica.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ValidadorCartao());
  }
}

class ValidadorCartao extends StatefulWidget {
  const ValidadorCartao({super.key});

  @override
  State<ValidadorCartao> createState() => _ValidadorCartaoState();
}

class _ValidadorCartaoState extends State<ValidadorCartao> {
  final n = TextEditingController();
  String resultado = "";
  String bandeira = "";

  void validarNumero(String numeroInformado) {
    String numeroCorrigido = numeroInformado.replaceAll(RegExp(r'[^0-9]'), '');
    String numeroValido = validarTamanho(numeroCorrigido);

    if (numeroValido.isNotEmpty) {
      String bandeiraReconhecida = validarBandeira(numeroValido);
      bool luhnValido = validarLuhn(numeroValido);

      setState(() {
        bandeira = bandeiraReconhecida;
        resultado = luhnValido
            ? "Número de cartão válido"
            : "Número de cartão inválido";
      });
    } else {
      setState(() {
        bandeira = "";
        resultado = "Tamanho inválido";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(133, 135, 167, 100),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(57, 54, 92, 1),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(80),
                ),
              ),
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      "Valide seus Cartões",
                      style: TextStyle(
                        fontSize: 64,
                        color: const Color.fromARGB(230, 234, 255, 255),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Descubra a bandeira do seu cartão",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                        color: const Color.fromRGBO(230, 234, 255, 100),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  TextFormField(
                    controller: n,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: 'Digite o número do cartão',
                      filled: true,
                      fillColor: const Color.fromRGBO(230, 234, 255, 100),
                    ),
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    height: 50,
                    width: 880,
                    child: ElevatedButton(
                      onPressed: () {
                        validarNumero(n.text);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        backgroundColor: const Color.fromRGBO(
                          254,
                          189,
                          85,
                          100,
                        ),
                        foregroundColor: const Color.fromRGBO(
                          230,
                          234,
                          255,
                          100,
                        ),
                        elevation: 5,
                      ),
                      child: const Text("Validar"),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    resultado,
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  Text(
                    bandeira.isNotEmpty ? "Bandeira: $bandeira" : "",
                    style: const TextStyle(fontSize: 20, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Image.asset(
                'lib/assets/images/credit_card.png',
                height: 400,
                width: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
