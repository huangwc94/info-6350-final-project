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
                SizedBox(height: 70),
                Icon(
                  Icons.account_circle_outlined,
                  color: Color.fromARGB(255, 108, 76, 149),
                  size: 80,
                ),
                SizedBox(height: 13),
                Text(
                  '',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: colorScheme.primary),
                ),
                SizedBox(height: 44),
              ],
            ),
            AutofillGroup(
              child: Form(
                // key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      autofillHints: const [AutofillHints.username],
                      decoration: InputDecoration(
                          labelText: 'Username/Email',
                          border: OutlineInputBorder()),
                      validator: (val) => (val?.length ?? 0) < 1
                          ? 'Username/Email Required'
                          : null,
                      onSaved: (val) => _username = val,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      // controller: _controllerUsername,
                      autocorrect: false,
                    ),
                    SizedBox(height: 36),
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
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Checkbox(
                    value: true,
                    onChanged: (bool? newValue) {
                      print("Checkbox value changed to: $newValue");
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      height: 48,
                      child: Text(
                        'Remember Me',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    // onTap: () {
                    //   _auth.handleRememberMe(!_auth.rememberMe);
                    // },
                  )
                ]),
                TextButton(
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(color: Color.fromARGB(255, 108, 76, 149),),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgetpassword');
                  },
                ),
              ],
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
                Navigator.pushNamed(context, "/home-screen");
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 12),
            TextButton(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Color.fromARGB(255, 108, 76, 149), fontSize: 18),
                  // textScaleFactor: textScaleFactor,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/signup_screen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
