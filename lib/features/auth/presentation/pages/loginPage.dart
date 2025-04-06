import 'package:eyego_assignment/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:eyego_assignment/features/auth/presentation/cubit/auth_states.dart';
import 'package:eyego_assignment/features/auth/presentation/pages/signUpPage.dart';
import 'package:eyego_assignment/features/auth/presentation/widgets/customTextField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        await context
            .read<AuthCubit>()
            .signIn(_emailController.text, _passwordController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Done Signed In"),
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
        title: Text('data'),
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
          padding: EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 15,
              children: [
                Text(
                  "Welcome To EyeGo",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                CustomTextField(
                    hintText: 'Email', controller: _emailController),
                CustomTextField(
                  hintText: 'Password',
                  controller: _passwordController,
                  isPassword: true,
                ),
                ElevatedButton(
                  onPressed: () {
                    _signIn();
                  },
                  child: Text("Login"),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: "Don't Have An Account? \t"),
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Signuppage(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
