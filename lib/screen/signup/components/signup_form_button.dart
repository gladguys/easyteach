import 'package:aluco/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

import 'signup_form.dart';

class SignupFormButton extends StatelessWidget {
  const SignupFormButton({this.signupForm});

  final SignupForm signupForm;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: const EdgeInsets.symmetric(
        vertical: 14.0,
        horizontal: 48.0,
      ),
      color: Theme.of(context).accentColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        'Criar',
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
      onPressed: () async {
        if (FormUtils.isValid(signupForm.getForm())) {
          print(signupForm.data);
          //await _bloc.tryToSigninUser(userData);
        }
      },
    );
  }
}
