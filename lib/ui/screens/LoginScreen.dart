import 'package:flutter/material.dart';
import '../../auth/app_auth.dart';
import '../../validator/validator.dart';
import '../widgets/custom_elevatedButton.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textFormField.dart';
import 'RegisterScreen.dart';
import 'homeNav.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isVisible = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 33,),
                    CustomText(
                      data: "Welcome back! Glad to see you Again!",
                      fontSize: 34,
                      align: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 70
                    ),
                    CustomTextField(
                      data: "Email",
                      controller: email,
                      validator: AppValidator.validateText,
                      hint: "Enter your Email",
                      prefixIcon: Icon(Icons.mail),
                      keyBoardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        data: "Password",
                        controller: password,
                        keyBoardType: TextInputType.text,
                        obsecurText: isVisible,
                        validator: AppValidator.validateText,
                        hint: "Enter your Password",
                        suffixIcon: InkWell(
                            onTap: () {
                              isVisible = !isVisible;
                              setState(() {});
                            },
                            child: isVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                        prefixIcon: const Icon(
                          Icons.lock,
                        )),
                    const SizedBox(
                      height: 70,
                    ),
                    Align(
                      child: SizedBox(
                        height: 45,
                        width: 385,
                        child: CustomElevatedButton(
                          isLoading: isLoading,
                          backGroundColor: Colors.deepPurple.shade900,
                          text: "Login",
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              await AppAuth.login(
                                  mail: email.text,
                                  pass: password.text,).then((value){
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) => homeNav()), (route) => false);
                              });
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                          borderRadius: 5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 350,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(alignment: Alignment.bottomCenter ,child: CustomText(data: "Don't have an account?", align: TextAlign.center,)),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterScreen()),
                                    (route) => false);
                              },
                              child: CustomText(
                                data: "Register now",
                                fontSize: 16,
                                fontColor: Colors.red,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
