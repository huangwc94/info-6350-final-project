import 'components/body.dart';
import 'package:flutter/material.dart';

class SignupScreen  extends StatelessWidget {
	static String routeName = '/signup_screen';
	const SignupScreen({Key? key}) : super(key: key);

	@override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset:false,
	    body: Body(),
    );
  }
}



