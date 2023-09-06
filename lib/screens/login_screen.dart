import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController txtConUser = TextEditingController();
    TextEditingController txtConPass = TextEditingController();
    final txtUser = TextField(
        controller: txtConUser,
        decoration: const InputDecoration(
            border: OutlineInputBorder() //PONER BORDES A LAS CAJAS DE TEXTO
            ));

    final txtPass = TextField(
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
        Navigator.pushNamed(context, '/dash');
      },
    );

    final btnOnBoard = FloatingActionButton.extended(
      icon: const Icon(Icons.login),
      label: const Text('Entrar'),
      onPressed: () {
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
              Container(
                height: 200,
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
                    txtPass
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
