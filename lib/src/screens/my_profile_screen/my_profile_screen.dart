import 'components/body.dart';
import 'package:flutter/material.dart';

class MyProfileScreen  extends StatelessWidget {
	static String routeName = '/my_profile_screen';
	const MyProfileScreen({Key? key}) : super(key: key);

	@override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset:false,
	    body: Body(),
    );
  }
}
