import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project3/page/Home.dart';
import 'package:project3/page/loginpage.dart';

import '../const/color.dart';

class Signup extends StatefulWidget {
 const  Signup( {super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  String email="",password="",name="";

  final _formkey = GlobalKey<FormState>();

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final namecontroller = TextEditingController();

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();

  Signup() async {
    if(passwordcontroller.text != "" && emailcontroller.text != "" && namecontroller.text != ""){
      try{
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Register Sucessfully"),
       backgroundColor: Colors.green,));
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
  }on FirebaseAuthException catch (e){
        if(e.code == "weak-password"){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
          Text("Your Password is too Weak"),backgroundColor: Colors.red,),);
        }else if (e.code == "email-already-in-use"){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
          Text("Account Already Exist"),backgroundColor: Colors.red,));
        }
      }
  }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode1.addListener(() { setState(() {

    });});
    focusNode2.addListener(() {setState(() {

    });});
    focusNode3.addListener(() {setState(() {

    });});
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: backgroundColors,
      body: SafeArea(child:
      SingleChildScrollView(child:
      Form(
        key: _formkey,
        child: Column(children: [
          SizedBox(height: 20,),
          image(),
          SizedBox(height: 40,),
          textfield(namecontroller, 'Name', focusNode1, Icons.email,"Please Enter Your Name"),
          SizedBox(height: 10,),
          textfield(emailcontroller, 'Email', focusNode2, Icons.password,  "Please Enter your Email"),
          SizedBox(height: 10,),
          textfield(passwordcontroller, ' Password', focusNode3, Icons.password, "Please Enter Your Password"),
          SizedBox(height: 8,),
          account(),
          SizedBox(height: 20,),
          Signupbutton(),
          SizedBox(height: 20,),

          Image.asset("asset/google.png",height: 35,)

        ],),
      ),),),
    );
  }

  Widget image(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("asset/images/signuppage.png"),fit: BoxFit.cover)
        ),),
    );
  }

  Widget textfield( TextEditingController _controller, String typename,
      FocusNode _focusnode, IconData _icondata , String msg){

    return Padding(padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(decoration: BoxDecoration(
        color: Colors.white,borderRadius: BorderRadius.circular(15),),
        child: TextFormField(
          validator: (value){
            if(value == null|| value.isEmpty){
              return msg;
            }return null;
          },
          controller: _controller,
          focusNode: _focusnode,
          style: TextStyle(color: Colors.black,fontSize: 18),
          decoration: InputDecoration(
              prefixIcon: Icon(_icondata,color: _focusnode.hasFocus?custom_green:Color(0xffc5c5c5),
              ),contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              hintText: typename,
              enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Color(0xffc5c5c5),
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: custom_green,
                  width: 2.0,
                ),
              )
          ),
        ),),);
  }

  Widget account (){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.end,
        children: [Text("Already have a Account?",style:
        TextStyle(fontSize: 14,color: Colors.black87),),
          SizedBox(width: 5,),
          InkWell(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>loginpage()));
          },
              child: Text("LoginIn",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: custom_green),))
        ],),
    );
  }

  Widget Signupbutton(){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(onTap: (){
        if(_formkey.currentState!.validate()){
          setState(() {
            email = emailcontroller.text;
            password = passwordcontroller.text;
            name = namecontroller.text;
          });
          Signup();
        }
      },
        child: Container(width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(color: custom_green,
              borderRadius: BorderRadius.circular(15)),child:
          Center(child: Text("SignUp",style: TextStyle(color: Colors.white,fontSize: 17),)),
        ),
      ),
    );
  }



}
