import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_states.dart';
import '../widgets/customTextField.dart';
import 'loginPage.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        await context.read<AuthCubit>().signUp(_emailController.text,
            _passwordController.text, _userNameController.text);

        print("Done Signed Up");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Done Signed Up"),
          ),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: [
                  Text(
                    "SignUp To EyeGo",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  CustomTextField(
                      hintText: "Username", controller: _userNameController),
                  CustomTextField(
                      hintText: "Email", controller: _emailController),
                  CustomTextField(
                    hintText: "Password",
                    controller: _passwordController,
                    isPassword: true,
                    prefixIcon: Icon(Icons.password),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _signUp();
                    },
                    child: Text("Login"),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(text: "Already Have An Account? \t"),
                        TextSpan(
                          text: "Sign In",
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Loginpage(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
