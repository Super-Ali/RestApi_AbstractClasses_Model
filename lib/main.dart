import 'package:flutter/material.dart';
import 'package:rest_api_app/Screens/Home.dart';

void main() {
  runApp(const RestApiCrud());
}

class RestApiCrud extends StatelessWidget {
  const RestApiCrud({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
