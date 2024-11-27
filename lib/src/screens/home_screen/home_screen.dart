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


    // SizeConfig().init(context);
    // return BaseView<HomeScreenViewModel>(
    //     onModelReady: (model) => {
    //           model.generateRandomNumber(),
    //         },
    //     builder: (context, model, child) {
    //       return DefaultTabController(
    //         length: 3,
    //         child: Scaffold(
    //           appBar: AppBar(
    //             toolbarHeight: getProportionateScreenHeight(60),
    //             elevation: 0,
    //             iconTheme: const IconThemeData(color: Colors.black),
    //             title: Padding(
    //               padding: EdgeInsets.symmetric(
    //                 horizontal: getProportionateScreenWidth(
    //                   4,
    //                 ),
    //               ),
    //               child: Row(
    //                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     'Hi, Lex',
    //                     style: Theme.of(context).textTheme.headline1,
    //                   ),
    //                   SizedBox(
    //                     width: getProportionateScreenWidth(60),
    //                   ),
    //                   Container(
    //                     width: 50,
    //                     height: 50,
    //                     decoration: const BoxDecoration(
    //                       color: Color(0xffdadada),
    //                       borderRadius:
    //                           BorderRadius.all(Radius.elliptical(45, 45)),
    //                     ),

    //                     child: IconButton(
    //                       splashRadius: 25,
    //                       icon: const Icon(
    //                         FontAwesomeIcons.solidUser,
    //                         color: Colors.amber,
    //                       ),
    //                       onPressed: () {
    //                         // Navigator.of(context).pushNamed(EditProfile.routeName);
    //                         Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfile(),));
    //                       },

    //                     ),
    //                   ),
    //                   SizedBox(
    //                     width: getProportionateScreenWidth(5),
    //                   ),
    //                   Container(
    //                     width: 50,
    //                     height: 50,
    //                     decoration: const BoxDecoration(
    //                       color: Color(0xffdadada),
    //                       borderRadius:
    //                       BorderRadius.all(Radius.elliptical(45, 45)),
    //                     ),

    //                     child: IconButton(
    //                       splashRadius: 25,
    //                       icon: const Icon(
    //                         CupertinoIcons.heart_fill,
    //                         color: Colors.grey,
    //                         size: 30,
    //                       ),
    //                       onPressed: () {
    //                         // Navigator.of(context).pushNamed(EditProfile.routeName);
    //                         Navigator.push(context, MaterialPageRoute(builder: (context) =>
    //                             Favourites(
    //                               model:model,
    //                             ),));
    //                       },
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             bottom: PreferredSize(
    //               child: TabBar(
    //                   isScrollable: true,
    //                   unselectedLabelColor: Colors.white.withOpacity(0.3),
    //                   indicatorColor: const Color(0xFF464646),
    //                   tabs: [
    //                     Tab(
    //                       child: Text(
    //                         'Living Room',
    //                         style: Theme.of(context).textTheme.headline3,
    //                       ),
    //                     ),
    //                     Tab(
    //                       child: Text(
    //                         'Dining',
    //                         style: Theme.of(context).textTheme.headline4,
    //                       ),
    //                     ),
    //                     Tab(
    //                       child: Text(
    //                         'Kitchen',
    //                         style: Theme.of(context).textTheme.headline4,
    //                       ),
    //                     ),
    //                   ]),
    //               preferredSize: Size.fromHeight(
    //                 getProportionateScreenHeight(
    //                   35,
    //                 ),
    //               ),
    //             ),
    //           ),
    //           drawer: SizedBox(
    //              width: getProportionateScreenWidth(270),
    //               child: const Menu()),
    //           body: TabBarView(
    //             children: <Widget>[
    //               Body(
    //                 model: model,
    //               ),
    //               Center(
    //                 child: Text(
    //                   'To be Built Soon',
    //                   style: Theme.of(context).textTheme.headline3,
    //                 ),
    //               ),
    //               const Center(
    //                 child: Text('under construction'),
    //               ),
    //             ],
    //           ),
    //           bottomNavigationBar: CustomBottomNavBar(model: model),
    //         ),
    //       );
    //     });
