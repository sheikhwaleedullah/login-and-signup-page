import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/signup.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool val = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  login() async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text,
            password: passController.text,
          )
          .then((value) => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginView())))
          .catchError(
            (error) =>
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              shape: RoundedRectangleBorder(),
              backgroundColor: Color.fromARGB(255, 14, 49, 70),
              content: Text(
                "Wrong Password or email",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 150,
            width: 200,
            child: Image.asset("assets/splash.PNG"),
          ),
          const Text(
            "Login to your Account",
            style: TextStyle(fontSize: 20),
          ),
          const Text(""),
          SizedBox(
            width: 300,
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.mail),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Colors.grey)),
            ),
          ),
          const Text(""),
          SizedBox(
            width: 300,
            child: TextField(
              obscureText: true,
              controller: passController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: const Icon(Icons.remove_red_eye),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.grey)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 170.0),
            child: Row(
              children: [
                Checkbox(
                    activeColor: Colors.blue,
                    shape: const RoundedRectangleBorder(),
                    value: val,
                    onChanged: ((value) {
                      setState(() {
                        val = value!;
                      });
                    })),
                const Text(""),
                const Text("Remember me")
              ],
            ),
          ),
          SizedBox(
              width: 300,
              child: ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text(
                    "SIGN IN",
                    style: TextStyle(color: Colors.white),
                  ))),
          ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Forget Password",
                style: TextStyle(fontSize: 15, color: Colors.blueAccent),
              )),
          const Text(
            "or continue with",
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 160.0),
            child: Row(
              children: [
                SizedBox(
                    width: 50,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Icon(Icons.facebook))),
                SizedBox(
                    width: 50,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.mail_outlined,
                          color: Colors.red,
                        ))),
                SizedBox(
                    width: 50,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.apple,
                          color: Colors.black,
                        ))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 150.0),
            child: Row(
              children: [
                const Text("Dont have an account"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpView()),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
