import 'package:flutter/material.dart';
import 'package:flutter_back4app_auth/constants.dart';
import 'package:flutter_back4app_auth/screens/home_screen.dart';
import 'package:flutter_back4app_auth/screens/register_screen.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isShowPwd;
  bool _hasError = false;
  String _errorMessage;

  @override
  void initState() {
    _isShowPwd = false;
    _usernameController.text = '';
    _passwordController.text = '';
    initData().then((bool success) {
      setState(() {
        _hasError = !success;
      });
    }).catchError((dynamic _) {
      setState(() {
        _hasError = true;
      });
    });
    super.initState();
  }

  Future<bool> initData() async {
    await Parse().initialize(
      keyParseApplicationId,
      keyParseServerUrl,
      clientKey: keyParseClientKey,
      debug: keyDebug,
    );

    return (await Parse().healthCheck()).success;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage("assets/images/back4app.png"),
                ),
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  key: Key('Username'),
                  controller: _usernameController,
                  validator: (value) =>
                      (value.isEmpty) ? "Please Enter Username" : null,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                    hintText: 'Username',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  key: Key('Password'),
                  controller: _passwordController,
                  validator: (value) =>
                      (value.isEmpty) ? "Please Enter Password" : null,
                  obscureText: (_isShowPwd) ? false : true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _isShowPwd = !_isShowPwd;
                        });
                      },
                      child: _isShowPwd
                          ? Icon(
                              Icons.visibility,
                              color: Theme.of(context).primaryColor,
                            )
                          : Icon(Icons.visibility_off,
                              color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                _hasError
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.error_outline,
                              color: Theme.of(context).errorColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _errorMessage,
                              style: TextStyle(
                                  color: Theme.of(context).errorColor),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xFF645AFF),
                  ),
                  child: FlatButton(
                    onPressed: () async {
                      setState(() {
                        _hasError = false;
                      }); //reset previous error message

                      if (_formKey.currentState.validate()) {
                        ParseUser user = ParseUser(_usernameController.text,
                            _passwordController.text, '');
                        ParseResponse response = await user.login();

                        _usernameController.clear();
                        _passwordController.clear();

                        if (response.success) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        } else {
                          setState(() {
                            _hasError = true;
                            _errorMessage = response.error.message;
                          });
                        }
                      }
                    },
                    child: Center(
                      child: Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Text(
                    '_____OR_____',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "You don't have an account yet? ",
                      style: Theme.of(context).textTheme.display1,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Register',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF645AFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Theme.of(context).accentColor)
                      ),
                      child: InkWell(
                        onTap: (){},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/google.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Theme.of(context).accentColor)
                      ),
                      child: InkWell(
                        onTap: (){},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/facebook.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Theme.of(context).accentColor)
                      ),
                      child: InkWell(
                        onTap: (){},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/twitter.png'),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
