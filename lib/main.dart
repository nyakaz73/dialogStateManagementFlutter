import 'package:flutter/material.dart';
import 'application/landing_page.dart';
import 'application/models/register_customer.dart';
import 'package:provider/provider.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterCustomerModel>(
      builder: (context) => RegisterCustomerModel(),
      child:  MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: LandingPage(),
      ),
    );
  }
}

