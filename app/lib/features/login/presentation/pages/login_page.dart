import 'package:booking_app_mvp_test/core/dialogs/show.dart';
import 'package:booking_app_mvp_test/core/navigation/goto.dart';
import 'package:booking_app_mvp_test/core/storage/session/sesssion.dart';
import 'package:booking_app_mvp_test/core/strings/strings.dart';
import 'package:booking_app_mvp_test/core/validators/validators.dart';
import 'package:booking_app_mvp_test/features/login/domain/usecases/login_usecase.dart';
import 'package:booking_app_mvp_test/features/login/presentation/bloc/login_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isPasswordVisible = false;

  var formKey = GlobalKey<FormState>();
  var autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) async {
        if (state is LoginLoading) {
        } else {
          if (state is LoginLoaded) {
            await SessionManager.setUserID(state.login.id);
            await SessionManager.setUserName(state.login.name);
            await SessionManager.setUserEmail(state.login.email);
            await SessionManager.setLoggedIn(true);
            print(state.login.toString());
            if (context.mounted) {
              context.pushAndRemoveUntil(Routes.home);
            }
          } else if (state is LoginError) {
            context.showErrorSnakeBar(state.message);
          }
        }
      },
      child: FutureBuilder<String?>(
          future: FirebaseMessaging.instance.getToken(),
          builder: (context,snapshot) {
          if(snapshot.hasData && snapshot.data!=null){
            return Scaffold(
              body: SingleChildScrollView(
                padding: EdgeInsets.all(15),
                child: Form(
                  key: formKey,
                  autovalidateMode: autoValidateMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 30),
                      Text(
                        context.strings.welcome_back,
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        context.strings.login_to_your_account,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: FlutterLogo(size: 100),
                      ),
                      TextFormField(
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: context.strings.enter_register_email,
                        ),
                        validator: Validators.isEmail,
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: passwordController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !isPasswordVisible,
                        validator: Validators.isPassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                          labelText: context.strings.enter_password,
                        ),
                      ),
                      SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<LoginBloc>().add(
                                LoginWithEmailEvent(
                                  LoginParams(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    fcm: snapshot.data??""
                                  ),
                                ),
                              );
                            } else {
                              setState(() {
                                autoValidateMode = AutovalidateMode.always;
                              });
                            }
                          },
                          child: Text(context.strings.proceed_to_login),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: context.strings.no_register_yet),
                      TextSpan(
                        text: ' ${context.strings.register_here}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                        recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            context.pushNamed(Routes.register);
                          },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }else{
            return SizedBox();
          }
        }
      ),
    );
  }
}
