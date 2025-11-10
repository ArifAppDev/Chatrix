import 'package:chat_hive/core/custom_assets/custom_icons/custom_icons.dart';
import 'package:chat_hive/service/auth_service.dart';
import 'package:chat_hive/presentation/widgets/my_button.dart';
import 'package:chat_hive/presentation/widgets/my_text_formfield.dart';
import 'package:chat_hive/utils/static_string/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final void Function()? onTap;
  RegisterScreen({super.key, this.onTap});

  // ======== register method =========
  void register(BuildContext context) {
    final _auth = AuthService();

    // passwprd match create  user
    if (_passController.text == _confirmPassController.text) {
      try {
        _auth.signUpWithEmailPassword(
          _emailController.text,
          _passController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())),
        );
      }
    }
    // password don't match
    else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text("Password don't match")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //====== logo =========
            SvgPicture.asset(CustomIcons.logo),
            const SizedBox(height: 50),

            Text(
              StaticStrings.createanaccount,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),

            // ========= email text from field ===========
            MyTextFormField(
              hintText: 'Email',
              obSecureText: false,
              controller: _emailController,
            ),
            const SizedBox(height: 10),
            // ========== password text form field ==============
            MyTextFormField(
              hintText: 'Enter your Password',
              obSecureText: true,
              controller: _passController,
            ),

            const SizedBox(height: 30),

            // ========== Confirm password text form field ==============
            MyTextFormField(
              hintText: 'Confirm your Password',
              obSecureText: true,
              controller: _confirmPassController,
            ),

            const SizedBox(height: 25.0),

            //============= login Button =================
            MyButton(text: "Register", onTap: () => register(context)),

            const SizedBox(height: 25.0),

            // =========== register now ==================
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StaticStrings.alreadyhaveanaccount,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                TextButton(
                  onPressed: onTap,
                  child: Text(
                    StaticStrings.login,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
