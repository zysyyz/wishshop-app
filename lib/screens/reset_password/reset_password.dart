import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../plugins/plugins.dart';
import '../../redux/redux.dart';
import '../../routes/routes.dart';
import '../../widgets/widgets.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  void _handleSubmit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(
        title: Text('重置密码'),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "请输入您注册时填写的邮箱地址，我们将向您发送重置密码的链接。",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              TextFormField(
                autofocus: true,
                decoration: new InputDecoration(
                  labelText: '邮箱',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return '邮箱不能为空。';
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 0,
                    highlightElevation: 0,
                    onPressed: this._handleSubmit,
                    child: Text(
                      '发送重置密码邮件',
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
}
