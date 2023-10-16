import 'package:app1flutter/provider/test_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderScreen extends StatelessWidget {
  const ProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<TestProvider>(context);

    return Scaffold(
      body: Center(
        child: Text(userProvider.user),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        userProvider.user = 'Rubicon RGG';
      }),
    );
  }
}
