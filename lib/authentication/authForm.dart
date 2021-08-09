import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(
    String email,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var isLogin = true;
  String _userEmail = '';
  String _userPassword = '';

  String _selectedUser;

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 57, 252, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              width: 200,
              child: Text(
                "MYSELAMAT APP",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
                softWrap: true,
              )),
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isLogin == true ? 'Login' : 'Sign Up',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Card(
                margin: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              key: ValueKey('email'),
                              validator: (value) {
                                if (value.isEmpty || !value.contains('@')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                              ),
                              onSaved: (value) {
                                _userEmail = value;
                              },
                            ),
                            TextFormField(
                              key: ValueKey('password'),
                              validator: (value) {
                                if (value.isEmpty || value.length < 8) {
                                  return 'Password must be at least 8 character long.';
                                }
                                return null;
                              },
                              decoration:
                                  InputDecoration(labelText: 'Password'),
                              obscureText: true,
                              onSaved: (value) {
                                _userPassword = value;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            if (widget.isLoading) CircularProgressIndicator(),
                            if (!widget.isLoading)
                              RaisedButton(
                                onPressed: _trySubmit,
                                child:
                                    Text(isLogin == true ? 'Login' : 'Signup'),
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(isLogin == true
                                    ? 'Doesn\'t have an account? '
                                    : 'Already have an account?'),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isLogin = !isLogin;
                                      });
                                    },
                                    child: Text(
                                      isLogin == true ? 'Sign Up' : 'Login',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
