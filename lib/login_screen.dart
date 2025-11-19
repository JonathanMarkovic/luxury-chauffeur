import 'package:flutter/material.dart';
import 'package:luxury_chauffeur/app_colors.dart';
import 'package:luxury_chauffeur/main.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                  child: Padding(
                    padding: EdgeInsets.all(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Login', style: TextStyle(fontSize: 24)),
                        SizedBox(height: 20,),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Login', style: TextStyle(fontSize: 18),),
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(AppColors.darkBackground),
                              foregroundColor: WidgetStateProperty.all(AppColors.lightBackground),
                              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                              fixedSize: WidgetStateProperty.all(Size(120, 30))
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RegisterScreen())
                              );
                            },
                            child: Text("Don't Have an Account?")
                        ),
                      ],
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Registration', style: TextStyle(fontSize: 24)),
                      SizedBox(height: 20,),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: 'First Name'),
                      ),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: 'Last Name'),
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: 'Phone Number'),
                      ),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                      ),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(labelText: 'Confirm Password'),
                        obscureText: true,
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Register', style: TextStyle(fontSize: 18),),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(AppColors.darkBackground),
                          foregroundColor: WidgetStateProperty.all(AppColors.lightBackground),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                          fixedSize: WidgetStateProperty.all(Size(120, 30))
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen())
                          );
                        },
                        child: Text("Already Have an Account?")
                      ),
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

