import 'package:flutter/material.dart';
import 'package:todo_hive/data/repository/remote/auth/social_sign_in/google_sign_in_api.dart';
import 'package:todo_hive/presentation/view/widget/common/button/custom_elevated_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  static const String routeName = "signIn";
  static const String routeURL = "/signIn";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomElevatedButton(
          onPressed: () async {
            googleSignIn();
          },
          text: 'Google SignIn',
        ),
      ),
    );
  }

  Future googleSignIn() async {
    try {
      var user = await GoogleSignInApi.login();
      if (user != null) {
        debugPrint('googleSignIn');
        debugPrint(user.displayName);
        debugPrint(user.email);
        debugPrint(user.id);
        debugPrint(user.serverAuthCode);
        debugPrint(user.photoUrl);
      }
    } catch (e) {
      debugPrint('googleSignIn error : ${e.toString()}');
    }
  }
}
