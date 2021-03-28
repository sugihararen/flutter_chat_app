import 'package:flutter/material.dart';
import 'package:flutter_chat_app/dialog/error_dialog.dart';
import 'package:flutter_chat_app/models/auth/sign_in_model.dart';
import 'package:flutter_chat_app/shared/validator.dart';
import 'package:flutter_chat_app/widget/button/primary_button.dart';
import 'package:flutter_chat_app/widget/loading/overlay_loading.dart';
import 'package:flutter_chat_app/widget/text_field/primary_text_form_field.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  Future<void> onPressed(BuildContext context, SignInModel signInModel) async {
    if (signInModel.formKey.currentState.validate()) {
      final response = await signInModel.signIn(context);
      if (response != null) {
        await showDialog(
          context: context,
          builder: (BuildContext context) => ErrorDialog(response),
        );
      } else {
        Navigator.of(context).pushReplacementNamed('/chat_rooms');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInModel>(
      create: (_) => SignInModel(),
      child: Consumer<SignInModel>(
        builder: (BuildContext context, SignInModel signInModel, Widget child) {
          return Stack(
            children: <Widget>[
              Scaffold(
                appBar: AppBar(
                  title: Text('SIGN IN'),
                ),
                body: Form(
                  key: signInModel.formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        PrimaryTextFormField(
                          textEditingController:
                              signInModel.emailEditingController,
                          hintText: 'Email',
                          autofocus: true,
                          validator: (String value) => Validator.email(value),
                        ),
                        SizedBox(height: 24),
                        PrimaryTextFormField(
                          textEditingController:
                              signInModel.passwordEditingController,
                          hintText: 'Password',
                          obscureText: true,
                          validator: (String value) => Validator.empty(value),
                        ),
                        SizedBox(height: 16),
                        InkWell(
                          onTap: () => Navigator.pushNamed(context, '/sign_up'),
                          child: Text(
                            'SGIN UP',
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        PrimaryButton(
                          text: 'SGIN IN',
                          onPressed: () => onPressed(context, signInModel),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              OverlayLoading(signInModel.isLoading)
            ],
          );
        },
      ),
    );
  }
}
