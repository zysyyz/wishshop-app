import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../models/models.dart';
import '../../plugins/plugins.dart';
import '../../redux/redux.dart';
import '../../widgets/widgets.dart';

class ProfileEditNameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileEditNameScreenState();
}

class _ProfileEditNameScreenState extends State<ProfileEditNameScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;
  String _newName;

  Widget _build(BuildContext context, _ViewModel vm) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: DefaultAppBar(
        title: Text('修改姓名'),
        actions: <Widget>[
          IconButton(
            icon: Text("确定"),
            onPressed: () async {
              if (!_formKey.currentState.validate()) {
                setState(() {
                  _autoValidate = true;
                });
                return;
              }

              _formKey.currentState.save();

              try {
                ProgressHUD.show(context, '正在保存...');
                await vm.doUpdateName(_newName);
                Navigator.of(context).pop();
              } catch (e) {
                _scaffoldKey.currentState.hideCurrentSnackBar();
                final snackBar = SnackBar(content: Text(e.message));
                _scaffoldKey.currentState.showSnackBar(snackBar);
              } finally {
                ProgressHUD.dismiss();
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ListSection(null);
            }

            return Material(
              color: Colors.white,
              child: ListTile(
                title: TextFormField(
                  autofocus: true,
                  initialValue: _newName ?? vm.user.name,
                  textInputAction: TextInputAction.next,
                  decoration: new InputDecoration(
                    hintText: '请输入你的姓名',
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                  ),
                  // validator: Validator.name,
                  onSaved: (value) {
                    setState(() {
                      _newName = value;
                    });
                  },
                ),
              ),
            );
          },
        ),
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
  final Function doUpdateName;

  _ViewModel({
    this.user,
    this.doUpdateName
  });

  static _ViewModel fromStore(Store<AppState> store) {
    final auth = store.state.auth;
    return _ViewModel(
      user: auth.user,
      doUpdateName: (String name) {
        // UpdateProfileAction action = new UpdateProfileAction(
        //   name: name,
        // );
        // store.dispatch(action);
        // return action.completer.future;
      }
    );
  }
}
