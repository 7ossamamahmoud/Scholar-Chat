import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/components/constants/constants.dart';
import 'package:scholar_chat/components/widgets/custom_button.dart';
import 'package:scholar_chat/components/widgets/show_snack_bar.dart';

import '../components/widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  static String RegisterScreenID = "Register Screen";
  String? emailController;
  String? passwordController;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Scholar App",
          style: TextStyle(
            fontFamily: "Pacifico",
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Image.asset(
                  "assets/images/scholar.png",
                ),
                const Text(
                  "Scholar Chat",
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    color: Colors.white,
                    fontSize: 29,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                customTextFormField(
                  hintText: "Email Address",
                  onChanged: (email) {
                    emailController = email;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                customTextFormField(
                  onChanged: (password) {
                    passwordController = password;
                  },
                  hintText: "Password",
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        await registerUser();
                        showSnackBar(context, "Success");
                        Navigator.pop(context);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(
                              context, "The password provided is too weak.");
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context,
                              "The account already exists for that email.");
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                    /*else {
                      showSnackBar(context, "There was an error, try later");
                    }*/
                  },
                  title: "Register",
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: "Pacifico",
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Pacifico",
                          decoration: TextDecoration.underline,
                          color: Color(
                            0xffC7EDEE,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController!,
      password: passwordController!,
    );
    print(credential.user!.email);
  }
}
