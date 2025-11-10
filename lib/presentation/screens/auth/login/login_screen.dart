import 'package:chat_hive/core/custom_assets/custom_icons/custom_icons.dart';
import 'package:chat_hive/service/auth_service.dart';
import 'package:chat_hive/presentation/widgets/my_button.dart';
import 'package:chat_hive/presentation/widgets/my_text_formfield.dart';
import 'package:chat_hive/utils/static_string/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final void Function()? onTap;

  LoginScreen({super.key, this.onTap});

  // ============= login method ===========
  void login(BuildContext context) async {
    // auth service
    final authService = AuthService();

    // try login
    try {
      await authService.signInwithEmailPassword(
        _emailController.text,
        _passController.text,
      );
    }
    // catch error
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(e.toString())),
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

            //========= welcom back messsage =========
            Text(
              StaticStrings.welcomeback,
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

            //============= login Button =================
            MyButton(text: "Login", onTap: () => login(context)),

            const SizedBox(height: 25.0),

            // =========== register now ==================
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StaticStrings.donthaveanyaccount,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                TextButton(
                  onPressed: onTap,
                  child: Text(
                    StaticStrings.registernow,
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
