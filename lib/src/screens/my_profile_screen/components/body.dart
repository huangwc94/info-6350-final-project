import 'package:flutter/material.dart';
import '../../../../services/service.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? _username, _password, _email;
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  bool _isFetching = true;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    try {
      final userInfo = await _apiService.fetchUserInfo();
      setState(() {
        _username = userInfo['username'];
        _email = userInfo['user']['name'];
        _isFetching = false;
      });
    } catch (e) {
      setState(() {
        _isFetching = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch user info: $e')),
      );
    }
  }

  Future<void> _handleUpdate() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      setState(() {
        _isLoading = true;
      });

      try {
        await _apiService.updateUser(_password, _username);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Update Failed'),
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

  void _handleLogout() async {
    await _apiService.logout();
    Navigator.pushNamedAndRemoveUntil(
        context, '/login-screen', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color.fromARGB(255, 108, 76, 149),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: SafeArea(
        child: _isFetching
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                physics: const AlwaysScrollableScrollPhysics(),
                key: const PageStorageKey("Divider 1"),
                children: <Widget>[
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      const Icon(
                        Icons.account_circle_outlined,
                        color: Color.fromARGB(255, 108, 76, 149),
                        size: 60,
                      ),
                      const SizedBox(height: 13),
                      Text(
                        _username ?? '',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                  AutofillGroup(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Username:'),
                          const SizedBox(height: 10),
                          TextFormField(
                            initialValue: _username,
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
                          const SizedBox(height: 15),
                          const Text('Email:'),
                          const SizedBox(height: 10),
                          TextFormField(
                            initialValue: _email,
                            decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder()),
                            validator: (val) => (val?.isEmpty ?? true)
                                ? 'Email Required'
                                : null,
                            onSaved: (val) => _email = val,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                          ),
                          const SizedBox(height: 15),
                          const Text('Password:'),
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder()),
                            validator: (val) => (val?.isEmpty ?? true)
                                ? 'Password Required'
                                : null,
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
                          const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 24),
                        ),
                      ),
                      onPressed: _handleUpdate,
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  FilledButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 108, 76, 149),
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 24),
                      ),
                    ),
                    onPressed: _handleLogout,
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
