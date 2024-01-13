import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/components/constants/constants.dart';
import 'package:scholar_chat/components/widgets/custom_button.dart';
import 'package:scholar_chat/components/widgets/show_snack_bar.dart';
import 'package:scholar_chat/screens/chat_screen.dart';
import 'package:scholar_chat/screens/register_screen.dart';

import '../components/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  static String LoginScreenID = "Login Screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  String? emailController;

  String? passwordController;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
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
                        "Login",
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
                    obsecureText: true,
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
                        isLoading = true;
                        setState(() {});
                        try {
                          await loginUser();
                          showSnackBar(
                            context,
                            "Success",
                          );
                          Navigator.pushNamed(
                            context,
                            ChatScreen.chatScreenID,
                            arguments: emailController,
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(context, "User is NOT Registered");
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(
                              context,
                              "Wrong Password",
                            );
                          }
                        } catch (e) {
                          print(e);
                        }
                        isLoading = false;
                        setState(() {});
                      }
                      /*else {
                        showSnackBar(context, "There was an error, try later");
                      }*/
                    },
                    title: "Login",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: "Pacifico",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RegisterScreen.RegisterScreenID,
                          );
                        },
                        child: const Text(
                          "Register",
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
      ),
    );
  }

  Future<void> loginUser() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController!,
      password: passwordController!,
    );
    print(credential.user!.email);
  }
}
