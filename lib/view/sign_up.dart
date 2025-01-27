import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskapp/routes/pages.dart';
import 'package:taskapp/utils/color_palette.dart';
import 'package:taskapp/utils/images.dart';
import 'package:taskapp/view_model.dart/controllers/auth_con.dart';
import 'package:taskapp/view_model.dart/servcies/vlidation_services/validation.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final signUpController = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
    signUpController.nameController.value.clear();
    signUpController.passwordController.value.clear();
    signUpController.confirmpasswordController.value.clear();
    signUpController.emailController.value.clear();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.08),
                Image.asset(
                  AppAssets.logo,
                  width: 100,
                ),
                SizedBox(height: constraints.maxHeight * 0.08),
                Text(
                  "Sign Up",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Full Name
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          return ValidationService.validateNull(value);
                        },
                        cursorColor: kWhiteColor,
                        controller: signUpController.nameController.value,
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
                          hintText: 'Full Name',
                          filled: true,
                          hintStyle: TextStyle(color: kWhiteColor),
                          fillColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0 * 1.5, vertical: 16.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      // Email
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          return ValidationService.validateEmail(value);
                        },
                        cursorColor: kWhiteColor,
                        controller: signUpController.emailController.value,
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
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          return ValidationService.validatePassword(value);
                        },
                        cursorColor: kWhiteColor,
                        controller: signUpController.passwordController.value,
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
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      // Confirm Password
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          return ValidationService.validateConfirmPassword(
                              signUpController
                                  .confirmpasswordController.value.text,
                              signUpController.passwordController.value.text);
                        },
                        cursorColor: kWhiteColor,
                        controller:
                            signUpController.confirmpasswordController.value,
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
                          hintText: 'Confirm Password',
                          filled: true,
                          hintStyle: TextStyle(color: kWhiteColor),
                          fillColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0 * 1.5, vertical: 16.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Sign Up Button
                      Obx(
                        () => Padding(
                          padding: EdgeInsets.only(
                              top: size.height * .03, left: 32, right: 32),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                signUpController.signUp();
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
                              signUpController.isLoading.value
                                  ? "Loading..."
                                  : "Sign Up",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),

                      // Already Have an Account
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Pages.signin);
                        },
                        child: Text.rich(
                          const TextSpan(
                            style: TextStyle(color: Colors.white, fontSize: 14),
                            text: "Don’t have an account ?   ",
                            children: [
                              TextSpan(
                                text: "Sign In",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationStyle: TextDecorationStyle.wavy,
                                    color: kWhiteColor,
                                    decorationColor: kWhiteColor),
                              ),
                            ],
                          ),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
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
        }),
      ),
    );
  }
}
