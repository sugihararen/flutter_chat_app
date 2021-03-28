import 'package:flutter/material.dart';
import 'package:flutter_chat_app/dialog/error_dialog.dart';
import 'package:flutter_chat_app/models/auth/sign_up_model.dart';
import 'package:flutter_chat_app/shared/validator.dart';
import 'package:flutter_chat_app/widget/button/primary_button.dart';
import 'package:flutter_chat_app/widget/loading/overlay_loading.dart';
import 'package:flutter_chat_app/widget/text_field/primary_text_form_field.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  Future<void> onPressed(BuildContext context, SignUpModel signUpModel) async {
    if (signUpModel.formKey.currentState.validate()) {
      final response = await signUpModel.signUp(context);
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
    return ChangeNotifierProvider<SignUpModel>(
      create: (_) => SignUpModel(),
      child: Consumer<SignUpModel>(
        builder: (BuildContext context, SignUpModel signUpModel, Widget child) {
          return Stack(
            children: <Widget>[
              Scaffold(
                appBar: AppBar(
                  title: Text('SIGN UP'),
                ),
                body: SingleChildScrollView(
                  child: Form(
                    key: signUpModel.formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          PrimaryTextFormField(
                            textEditingController:
                                signUpModel.nameEditingController,
                            hintText: 'Name',
                            autofocus: true,
                            validator: (String value) => Validator.empty(value),
                          ),
                          SizedBox(height: 24),
                          PrimaryTextFormField(
                            textEditingController:
                                signUpModel.emailEditingController,
                            hintText: 'Email',
                            validator: (String value) => Validator.email(value),
                          ),
                          SizedBox(height: 24),
                          PrimaryTextFormField(
                            textEditingController:
                                signUpModel.passwordEditingController,
                            hintText: 'Password',
                            obscureText: true,
                            validator: (String value) => Validator.empty(value),
                          ),
                          SizedBox(height: 16),
                          PrimaryButton(
                            text: 'SGIN UP',
                            onPressed: () => onPressed(context, signUpModel),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              OverlayLoading(signUpModel.isLoading)
            ],
          );
        },
      ),
    );
  }
}
