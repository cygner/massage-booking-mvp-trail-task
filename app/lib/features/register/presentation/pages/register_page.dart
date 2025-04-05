import 'package:booking_app_mvp_test/core/dialogs/show.dart';
import 'package:booking_app_mvp_test/core/navigation/goto.dart';
import 'package:booking_app_mvp_test/core/strings/strings.dart';
import 'package:booking_app_mvp_test/features/register/presentation/bloc/register_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/routes.dart';
import '../../../../core/storage/session/sesssion.dart';
import '../../../../core/validators/validators.dart';
import '../../domain/usecases/register_usecase.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isPasswordVisible = false;

  var formKey = GlobalKey<FormState>();
  var autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (BuildContext context, RegisterState state) async {
        if(state is RegisterLoading){

        }else {
          if(state is RegisterLoaded){
            await SessionManager.setUserID(state.register.id);
            await SessionManager.setUserName(state.register.name);
            await SessionManager.setUserEmail(state.register.email);
            await SessionManager.setLoggedIn(true);
            print(state.register.toString());
            if(context.mounted){
              context.pushAndRemoveUntil(Routes.home);
            }
          }else if(state is RegisterError){
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
                        context.strings.register,
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        context.strings.create_your_new_account,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: FlutterLogo(size: 100),
                      ),
                      TextFormField(
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: context.strings.enter_your_name,
                        ),
                        validator: Validators.minimum,
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: context.strings.enter_your_email,
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
                              context.read<RegisterBloc>().add(
                                RegisterWithEmailEvent(
                                  RegisterParams(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      fcmToken: snapshot.data??""
                                  ),
                                ),
                              );
                            } else {
                              setState(() {
                                autoValidateMode = AutovalidateMode.always;
                              });
                            }
                          },
                          child: Text(context.strings.proceed_to_register),
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
                      TextSpan(text: context.strings.already_account),
                      TextSpan(
                        text: ' ${context.strings.login_here}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                        recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            context.pop();
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
