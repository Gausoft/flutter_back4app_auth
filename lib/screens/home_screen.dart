import 'package:flutter/material.dart';
import 'package:flutter_back4app_auth/constants.dart';
import 'package:flutter_back4app_auth/screens/login_screen.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ParseUser _authUser;

  @override
  void initState() {
    initData().then((bool success) {
      ParseUser.currentUser().then((currentUser) {
        setState(() {
          _authUser = currentUser;
        });
      });
    }).catchError((dynamic _) {});
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage("assets/images/back4app.png"),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Welcome',
                      style: Theme.of(context).textTheme.headline,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('${_authUser.username}', style: Theme.of(context).textTheme.title),
                    SizedBox(
                      height: 20,
                    ),
                    Text('${_authUser.emailAddress}', style: Theme.of(context).textTheme.title),
                    SizedBox(height: 50,)                                        
                  ],
                ),
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
                onTap: () async {
                  // final ParseUser user = await ParseUser.currentUser();
                  // user.logout(deleteLocalUserData: true);
                  // Navigator.pop(context, true);

                  ParseResponse response = await _authUser.logout(deleteLocalUserData: true);
                  if (response.success) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false,
                    );
                  }
                },
                child: Text(
                  'Logout',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF645AFF),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
