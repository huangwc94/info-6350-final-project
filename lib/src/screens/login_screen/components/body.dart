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
          padding: const EdgeInsets.symmetric(horizontal: 36),
          physics: const AlwaysScrollableScrollPhysics(),
          key: const PageStorageKey("Divider 1"),
          children: <Widget>[
            Column(
              children: [
                const SizedBox(height: 70),
                const Icon(
                  Icons.account_circle_outlined,
                  color: Color.fromARGB(255, 108, 76, 149),
                  size: 80,
                ),
                const SizedBox(height: 13),
                Text(
                  '',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: colorScheme.primary),
                ),
                const SizedBox(height: 44),
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
                      decoration: const InputDecoration(
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
                    const SizedBox(height: 36),
                    TextFormField(
                      autofillHints: const [AutofillHints.password],
                      decoration: const InputDecoration(
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
            const SizedBox(height: 8),
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
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Remember Me',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    ),
                    // onTap: () {
                    //   _auth.handleRememberMe(!_auth.rememberMe);
                    // },
                  )
                ]),
                TextButton(
                  child: const Text(
                    'Forget Password?',
                    style: TextStyle(color: Color.fromARGB(255, 108, 76, 149),),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgetpassword');
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  const Color.fromARGB(255, 108, 76, 149), 
                ),
                padding: WidgetStateProperty.all(
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
            const SizedBox(height: 12),
            TextButton(
              child: const Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 24),
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
