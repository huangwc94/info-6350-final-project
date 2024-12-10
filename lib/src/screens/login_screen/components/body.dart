import 'package:flutter/material.dart';
import '../../../../services/service.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? _username, _password;
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService(); // Replace with your base URL

  bool _isLoading = false;

  Future<void> _doLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      setState(() {
        _isLoading = true;
      });

      try {
        await _apiService.login(_username!, _password!);
        Navigator.pushNamed(context, "/home-screen");
      } catch (e) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Login Failed'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
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
                  'Login',
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
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      autofillHints: const [AutofillHints.username],
                      decoration: const InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder()),
                      validator: (val) => (val?.isEmpty ?? true)
                          ? 'Username Required'
                          : null,
                      onSaved: (val) => _username = val,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                    ),
                    const SizedBox(height: 36),
                    TextFormField(
                      autofillHints: const [AutofillHints.password],
                      decoration: const InputDecoration(
                          labelText: 'Password', border: OutlineInputBorder()),
                      validator: (val) =>
                          (val?.isEmpty ?? true) ? 'Password Required' : null,
                      onSaved: (val) => _password = val,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              FilledButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 108, 76, 149),
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                  ),
                ),
                onPressed: _doLogin,
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
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Color.fromARGB(255, 108, 76, 149), fontSize: 18),
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
