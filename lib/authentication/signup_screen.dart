import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:teachers/pages/home_page.dart';
import 'package:teachers/widgets/loading_dialog.dart';

import '../methods/common_methods.dart';
import 'login_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
{
  TextEditingController userNameTextEditingController=TextEditingController();
  TextEditingController materialNameTextEditingController=TextEditingController();
  TextEditingController emailTextEditingController=TextEditingController();
  TextEditingController passwordTextEditingController=TextEditingController();
  CommonMethods cMethods = CommonMethods();

  checkIfNetworkIsAvailable()
  {
    cMethods.checkConnectivity(context);

    signUpFormValidation();
  }

  signUpFormValidation()
  {
    if(userNameTextEditingController.text.trim().length < 3 )
    {
      cMethods.displaySnackBar("your name musst be atleast 4 or more characters.", context);
    }

    else  if(passwordTextEditingController.text.trim().length < 10 )
    {
      cMethods.displaySnackBar("yours password must be atleast 11 or more characteres", context);
    }
    else
    {
      registerNewUser();
    }
  }

  registerNewUser() async
  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => LoadingDialog(messageText: "Registeriong your account..."),
    );
    final User? userFirebase = (
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    ).catchError((errorMsg)
    {
      cMethods.displaySnackBar(errorMsg.toString(), context);
    })
    ).user;
    if(!context.mounted) return;
    Navigator.pop(context);

    DatabaseReference usersRef= FirebaseDatabase.instance.ref().child("users").child(userFirebase!.uid);
    Map userDataMap=
        {
          "name":userNameTextEditingController.text.trim(),
          "email":emailTextEditingController.text.trim(),
          "material":materialNameTextEditingController.text.trim(),
          "id":userFirebase.uid,
          "blockStatus": "no",
        };
    usersRef.set(userDataMap);
    Navigator.push(context, MaterialPageRoute(builder:(c)=>HomePage()));
  }



  @override
  Widget build(BuildContext context)
  {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
          child: Column(
            children: [

              Image.asset(
                "assets/images/signup.png",
                width: 300,
                height: 350,
                fit: BoxFit.cover,
              ),
              const Text(
                "Create a User\'s Account",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

            //text fields
             Padding(
              padding:EdgeInsets.all(22),
              child: Column(
                children: [
                  TextField(
                    controller: userNameTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: "User Name",
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      hintText: "User Name",
                    ),
                    style:const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  TextField(
                    controller: materialNameTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: "The material name",
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      hintText: "The material",
                    ),
                    style:const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  TextField(
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "User Email",
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      hintText: "User Email",
                    ),
                    style:const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),

                  TextField(
                    controller: passwordTextEditingController,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: "User password",
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      hintText: "User password",
                    ),
                    style:const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 22,),
                  ElevatedButton(
                    onPressed:()
                    {
                      checkIfNetworkIsAvailable();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        padding: EdgeInsets.symmetric(horizontal: 50,vertical: 20)
                    ),
                    child: const Text(
                        "Sign Up"
                    ),
                  ),
                ],
              ),
            ),
              TextButton(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>LoginScreen()));
                },
                child: const Text(
                  "Already have an Account? Login Here",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:20,
                  ),

                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
