import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Signup.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  String email = "";
  TextEditingController emailcontroller = new TextEditingController();

  resetpassword()async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
      Text("Link is sent To your email Address")));
    }on FirebaseAuthException catch(e){
      if(e.code == "user-not-found"){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
        Text("Account Not Exist")));
      }
    }
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Forget Password",style: TextStyle(color: Colors.white,fontSize: 30),),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: InkWell(onTap: (){
          Navigator.pop(context);
        },
            child: Icon(Icons.arrow_back,color: Colors.white,size: 24,)),
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
        children: [
        SizedBox(
        height: 70.0,
    ),
          Container(
           alignment: Alignment.topCenter,
            child: Text(
           "Password Recovery",
              style: TextStyle(
            color: Colors.white,
              fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
                     ),
            SizedBox(
             height: 20,
        ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(width:MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 10,left: 8),
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(18)),
            child: TextFormField(
              controller: emailcontroller,
              // validator: (value){
              //   if(value == null || value.isEmpty ){
              //     return "Please Enter your email";
              //   }return null;
              // },
              decoration: InputDecoration(border: InputBorder.none,hintText: "Email"),
            ),),
          ),
          SizedBox(height: 20,),

          InkWell(
            onTap: (){
             setState(() {
               email = emailcontroller.text;
             });
             resetpassword();
            },
            child: Container(width: MediaQuery.of(context).size.width*0.7,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(18)),
            child: Center(child: Text("Send password")),),
          )



        ]),)
    );
  }
}
