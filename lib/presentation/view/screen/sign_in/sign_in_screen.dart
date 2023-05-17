import 'package:flutter/material.dart';
import 'package:todo_hive/data/repository/remote/auth/social_sign_in/google_sign_in_api.dart';
import 'package:todo_hive/presentation/util/snackbar/snackbar_util.dart';
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
            googleSignIn(context: context);
          },
          text: 'Google SignIn',
        ),
      ),
    );
  }

  Future googleSignIn({ required BuildContext context }) async {
    var user = await GoogleSignInApi.signIn();
    if (user != null) {
      // TODO : Implement sign-up/sign-in features with remote server.
      // TODO : code == 200, Not yet sign-up. Proceed sign-up process.
      // TODO : code == 409, Already sign-up. Just proceed sign-in process directly.
    } else {
      if (context.mounted) showSnackBar(context: context, text: "It went something wrong.\nPlease try again.");
    }
  }
}
