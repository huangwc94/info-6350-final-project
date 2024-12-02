import 'components/body.dart';
import 'package:flutter/material.dart';

class HomeScreen  extends StatelessWidget {
	static String routeName = '/home-screen';
	const HomeScreen({Key? key}) : super(key: key);

	@override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset:false,
	    body: Body(),
    );
  }
}