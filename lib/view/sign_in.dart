import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskapp/routes/pages.dart';
import 'package:taskapp/utils/color_palette.dart';

import '../view_model.dart/controllers/auth_con.dart';
import '../view_model.dart/servcies/vlidation_services/validation.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final signinController = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
    signinController.emailController.value.clear();
    signinController.passwordController.value.clear();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.1),
                  Image.asset(
                    'assets/images/app_logo.png',
                    width: 100,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.1),
                  Text(
                    "Sign In",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.white),
                          cursorColor: kWhiteColor,
                          controller: signinController.emailController.value,
                          obscureText: false,
                          decoration: const InputDecoration(
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kWhiteColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kWhiteColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kWhiteColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kWhiteColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            hintText: 'Email',
                            filled: true,
                            hintStyle: TextStyle(color: kWhiteColor),
                            fillColor: Colors.transparent,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0 * 1.5, vertical: 16.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                          validator: (value) {
                            return ValidationService.validateEmail(value);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              return ValidationService.validatePassword(value);
                            },
                            cursorColor: kWhiteColor,
                            controller:
                                signinController.passwordController.value,
                            obscureText: true,
                            decoration: const InputDecoration(
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: kWhiteColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: kWhiteColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: kWhiteColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: kWhiteColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              hintText: 'Password',
                              filled: true,
                              hintStyle: TextStyle(color: kWhiteColor),
                              fillColor: Colors.transparent,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.0 * 1.5, vertical: 16.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => Padding(
                            padding: EdgeInsets.only(
                                top: size.height * .1, left: 32, right: 32),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  signinController.login();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: kWhiteColor,
                                foregroundColor: kPrimaryColor,
                                minimumSize: const Size(double.infinity, 48),
                                shape: const StadiumBorder(),
                              ),
                              child: Text(
                                signinController.isLoading.value
                                    ? "Loading..."
                                    : "Sign in",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Pages.signup);
                          },
                          child: Text.rich(
                            const TextSpan(
                              style: TextStyle(color: Colors.white),
                              text: "Don’t have an account ?   ",
                              children: [
                                TextSpan(
                                  text: "Sign Up",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationStyle: TextDecorationStyle.wavy,
                                      color: kWhiteColor,
                                      decorationColor: kWhiteColor),
                                ),
                              ],
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!
                                      .withOpacity(0.64),
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
