import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? _username, _password;

	@override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      // key: _scaffoldKey,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 36),
          physics: AlwaysScrollableScrollPhysics(),
          key: PageStorageKey("Divider 1"),
          children: <Widget>[
            Column(
              children: [
                SizedBox(height: 30),
                Text(
                  'Profile',
                  style: TextStyle(fontSize: 24),
                  ),
                SizedBox(height: 20),
                Icon(
                  Icons.account_circle_outlined,
                  color: Color.fromARGB(255, 108, 76, 149),
                  size: 60,
                ),
                // SizedBox(height: 13),
                Text(
                  'Mona',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 30),
              ],
            ),
            AutofillGroup(
              child: Form(
                // key: formKey,
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Username:'),
                    SizedBox(height: 10),
                    TextFormField(
                      autofillHints: const [AutofillHints.username],
                      decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder()),
                      validator: (val) => (val?.length ?? 0) < 1
                          ? 'Username Required'
                          : null,
                      onSaved: (val) => _username = val,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      // controller: _controllerUsername,
                      autocorrect: false,
                    ),
                    SizedBox(height: 15),
                    Text('Email:'),
                    SizedBox(height: 10),
                    TextFormField(
                      autofillHints: const [AutofillHints.username],
                      decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder()),
                      validator: (val) => (val?.length ?? 0) < 1
                          ? 'Email Required'
                          : null,
                      onSaved: (val) => _username = val,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      // controller: _controllerUsername,
                      autocorrect: false,
                    ),
                    SizedBox(height: 15),
                    Text('Password:'),
                    SizedBox(height: 10),
                    TextFormField(
                      autofillHints: const [AutofillHints.password],
                      decoration: InputDecoration(
                          labelText: 'Password', border: OutlineInputBorder()),
                      validator: (val) =>
                          (val?.length ?? 0) < 1 ? 'Password Required' : null,
                      onSaved: (val) => _password = val,
                      obscureText: true,
                      // controller: _controllerPassword,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      // onFieldSubmitted: (value) => doLogin(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            FilledButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 108, 76, 149), // Custom purple color
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Confirm',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
                        SizedBox(height: 24),
            FilledButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 108, 76, 149),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login-screen');
              },
              child: const Text(
                'Log out',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
