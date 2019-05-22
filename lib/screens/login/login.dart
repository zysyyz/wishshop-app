import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../models/models.dart';
import '../../plugins/plugins.dart';
import '../../redux/redux.dart';
import '../../routes/routes.dart';
import '../../widgets/widgets.dart';
import '../home/home.dart';
import '../register/register.dart';
import '../reset_password/reset_password.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;
  bool _processing = false;
  String _email = 'lijy91@foxmail.com';
  String _password = '123456';

  void _handleSubmit(BuildContext context, _ViewModel vm) async {
    if (_processing) return;
    if (!_formKey.currentState.validate()) {
      setState(() {
        _autoValidate = true;
      });
      return;
    }

    _formKey.currentState.save();

    try {
      setState(() {
        _processing = true;
      });
      await vm.doLogin(_email, _password);
      Navigator.of(context).pop();
    } catch (e) {
       _scaffoldKey.currentState.hideCurrentSnackBar();
      final snackBar = SnackBar(content: Text(e.message));
       _scaffoldKey.currentState.showSnackBar(snackBar);
    } finally {
      setState(() {
        _processing = false;
      });
    }
  }

  Widget _build(BuildContext context, _ViewModel vm) {
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          child: Container(),
          preferredSize: Size.fromHeight(0),
        ),
      ),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                initialValue: _email,
                textInputAction: TextInputAction.next,
                decoration: new InputDecoration(
                  labelText: '邮箱',
                ),
                onSaved: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              TextFormField(
                initialValue: _password,
                obscureText: true,
                maxLength: 32,
                textInputAction: TextInputAction.go,
                decoration: new InputDecoration(
                  labelText: '密码',
                ),
                // validator: Validator.password,
                onSaved: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: <Widget>[
              //       GestureDetector(
              //         child: Text(
              //           '忘记密码？',
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         onTap: () {
              //           Navigator
              //             .of(context)
              //             .push(MaterialPageRoute(builder: (_) => ResetPasswordScreen()));
              //         },
              //       )
              //     ],
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 0,
                    highlightElevation: 0,
                    onPressed: () => this._handleSubmit(context, vm),
                    child: _processing ? SpinKitFadingCube(color: Colors.white, size: 16.0) : Text(
                      '登录',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("还没有账号？"),
                    GestureDetector(
                      child: Text(
                        '注册',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator
                          .of(context)
                          .push(MaterialPageRoute(builder: (_) => RegisterScreen()));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return _build(context, vm);
      },
    );
  }
}

class _ViewModel {
  final User user;
  final Function doLogin;

  _ViewModel({
    this.user,
    this.doLogin
  });

  static _ViewModel fromStore(Store<AppState> store) {
    final auth = store.state.auth;
    return _ViewModel(
      user: auth.user,
      doLogin: (String email, String password) {
        LoginAction action = new LoginAction(email, password);
        store.dispatch(action);

        return action.completer.future;
      }
    );
  }
}
