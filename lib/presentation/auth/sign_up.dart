import 'package:fit_fusion/bloc/authBloc/auth_bloc.dart';
import 'package:fit_fusion/data/models/user_model.dart';
import 'package:fit_fusion/data/repository/user_repo.dart';
import 'package:fit_fusion/presentation/auth/sign_in.dart';
import 'package:fit_fusion/presentation/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _numberController = TextEditingController();
  final _heightController = TextEditingController();
  final _weigthController = TextEditingController();

  String _selectedSex = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is Registered) {
            await UserRepository().saveAudioPref(true);
          }
          if (state is Authenticated) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (Route<dynamic> route) => false);
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _numberController,
                    maxLength: 10,
                    decoration: const InputDecoration(labelText: 'number'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _ageController,
                    maxLength: 2,
                    decoration: const InputDecoration(labelText: 'age'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your age';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _heightController,
                    decoration: const InputDecoration(
                        labelText: 'height', hintText: 'in cms'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your height';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _weigthController,
                    decoration: const InputDecoration(
                        labelText: 'weight', hintText: 'in kg'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your weight';
                      }
                      return null;
                    },
                  ),
                  DropdownButton(
                    value: _selectedSex,
                    items: const [
                      DropdownMenuItem(
                        value: 'Male',
                        child: Text('Male'),
                      ),
                      DropdownMenuItem(
                        value: 'Female',
                        child: Text('Female'),
                      ),
                    ],
                    onChanged: (val) {
                      setState(() {
                        _selectedSex = val!;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        UserModel user = UserModel(
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            number: _numberController.text.trim(),
                            age: int.parse(_numberController.text.trim()),
                            height: double.parse(_heightController.text.trim()),
                            weight: double.parse(_weigthController.text.trim()),
                            sex: _selectedSex);

                        BlocProvider.of<AuthBloc>(context)
                            .add(RegisterEvent(user: user));
                        // Save user details to storage (e.g., SharedPreferences)
                      }
                    },
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SingInPage()));
                      },
                      child: const Center(
                          child: Text('Already signed in? Login In')))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
