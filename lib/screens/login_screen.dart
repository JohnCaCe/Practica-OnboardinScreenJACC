import 'package:app1flutter/firebase/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //final emailAuth = ;
  TextEditingController txtConUser = TextEditingController();
  TextEditingController txtConPass = TextEditingController();
  bool recordarButton = false;
  SharedPreferences? _pref;

  @override
  void initState() {
    cargarPreferencias();
    super.initState();
  }

  cargarPreferencias() async {
    _pref = await SharedPreferences.getInstance();
    _pref?.setBool("session", recordarButton);
  }

  @override
  Widget build(BuildContext context) {
    final txtUser = TextFormField(
        controller: txtConUser,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          //PONER BORDES A LAS CAJAS DE TEXTO
        ));

    final txtPass = TextFormField(
        controller: txtConPass,
        obscureText: true,
        decoration: const InputDecoration(
            border: OutlineInputBorder() //PONER BORDES A LAS CAJAS DE TEXTO
            ));

    final imgLogo = Container(
      width: 200,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://yt3.googleusercontent.com/ytc/AOPolaSnpjJcpB9T-kWOTCRP-1XNooGSkbxBs_enDgpT6A=s900-c-k-c0x00ffffff-no-rj'))),
    );

    final btnEntrar = FloatingActionButton.extended(
      icon: const Icon(Icons.login),
      label: const Text('Entrar'),
      onPressed: () {
        /*bool res = await emailAuth.validateUser(emailUser: textConUser.text, pwdUser: textConPass);
        if (res) {
          
        }*/
        cargarPreferencias();
        Navigator.pushNamed(context, '/dash');
      },
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: .5,
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSi7A7xVymqIT29MDAr5IvDQO3eNdhLBKRN4g&usqp=CAU'))),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: const Text(
                    "Registrarse =)",
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                height: 249,
                padding: const EdgeInsets.all(30),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightBlue),
                child: Column(
                  children: [
                    txtUser,
                    const SizedBox(
                      height: 10,
                    ),
                    txtPass,
                    const SizedBox(
                      height: 5,
                    ),
                    CheckboxListTile(
                      value: recordarButton,
                      title: const Text("Recordarme"),
                      onChanged: (bool? value) {
                        setState(() {
                          recordarButton = value!;
                          cargarPreferencias();
                        });
                      },
                    )
                  ],
                ),
              ),
              imgLogo
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: btnEntrar,
    );
  }
}
