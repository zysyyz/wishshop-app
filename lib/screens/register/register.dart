import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import '../../models/models.dart';
import '../../plugins/plugins.dart';
import '../../redux/redux.dart';
import '../../routes/routes.dart';
import '../../widgets/widgets.dart';
import '../home/home.dart';
import '../register/register.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;
  bool _processing = false;
  String _name = '';
  String _email = '';
  String _password = '';

  void _handleSubmit(BuildContext context, _ViewModel vm) async {
    if (_processing) return;
    if (!_formKey.currentState.validate()) {
      setState(() {
        _autoValidate = true;
      });
      return;
    }

    _formKey.currentState.save();

    setState(() {
      _processing = true;
    });

    try {
      await vm.doRegister(_name, _email, _password);
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
        title: Text('注册'),
        backgroundColor: Colors.white,
        elevation: 0.0,
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
                autofocus: true,
                maxLength: 32,
                maxLengthEnforced: false,
                decoration: new InputDecoration(
                  labelText: '姓名',
                ),
                // validator: Validator.name,
                onSaved: (value) {
                  _name = value;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(
                  labelText: '邮箱',
                ),
                // validator: Validator.email,
                onSaved: (value) {
                  _email = value;
                },
              ),
              TextFormField(
                obscureText: true,
                maxLength: 32,
                decoration: new InputDecoration(
                  labelText: '密码',
                ),
                // validator: Validator.password,
                onSaved: (value) {
                  _password = value;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Row(
                  children: <Widget>[
                    Text("注册即表示你同意我们的"),
                    GestureDetector(
                      child: Text(
                        '服务条款',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () async {
                        const url = 'https://wishshop.thecode.me/legal/terms/';
                        if (await canLaunch(url)) {
                          await launch(url);
                        }
                      },
                    ),
                    Text("和"),
                    GestureDetector(
                      child: Text(
                        '隐私声明',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () async {
                        const url = 'https://wishshop.thecode.me/legal/privacy/';
                        if (await canLaunch(url)) {
                          await launch(url);
                        }
                      },
                    ),
                    Text("。"),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 0,
                    highlightElevation: 0,
                    onPressed: () => this._handleSubmit(context, vm),
                    child: _processing ? SpinKitFadingCube(color: Colors.white, size: 16.0) : Text(
                      '注册',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
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
  final Function doRegister;

  _ViewModel({
    this.user,
    this.doRegister
  });

  static _ViewModel fromStore(redux.Store<AppState> store) {
    final auth = store.state.auth;
    return _ViewModel(
      user: auth.user,
      doRegister: (String name, String email, String password) {
        RegisterAction action = new RegisterAction(name, email, password);
        store.dispatch(action);

        return action.completer.future;
      }
    );
  }
}
