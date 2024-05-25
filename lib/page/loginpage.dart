import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project3/const/color.dart';
import 'package:project3/page/Forgetpassword.dart';
import 'package:project3/page/Home.dart';
import 'package:project3/page/Signup.dart';

class loginpage extends StatefulWidget {

const  loginpage( {super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  String email="",password="";
  final _formloginkey = GlobalKey<FormState>();

  FocusNode focusnode1 = FocusNode();
  FocusNode focusnode2 = FocusNode();

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  Loginuser()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
      Text("LoginIn Successfully"),backgroundColor: Colors.green,));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
    }on FirebaseAuthException catch(e){
      if(e.code=="wrong-password"){
        return "Enter valid Password";
      }else if(e.code == "user-not-found"){
        return "Account Not Exist";
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusnode1.addListener(() { });
    setState(() {

    });

    focusnode2.addListener(() {
      setState(() {
        
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      body: SafeArea(child:
        SingleChildScrollView(child:
          Form(key: _formloginkey,
            child: Column(children: [
              SizedBox(height: 20,),
              image(),
              SizedBox(height: 40,),
              textfield(emailcontroller, 'Email', focusnode1, Icons.email,"Please Enter your Email"),
              SizedBox(height: 10,),
              textfield(passwordcontroller, 'Password', focusnode2, Icons.password, "Please Enter your Password"),
              SizedBox(height: 8,),
              account(),
              SizedBox(height: 20,),
              Loginbutton(),
              SizedBox(height: 15,),
              TextButton(onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgetpassword()));
              }, child: Text("Forget Password"))





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
            image: DecorationImage(image: AssetImage("asset/images/loginpage.png"),fit: BoxFit.cover)
        ),),
    );
  }

  Widget textfield( TextEditingController _controller, String typename,
      FocusNode _focusnode, IconData _icondata ,String valmsg){

    return Padding(padding: EdgeInsets.symmetric(horizontal: 15),
    child: Container(decoration: BoxDecoration(
      color: Colors.white,borderRadius: BorderRadius.circular(15),),
    child: TextFormField(
      validator: (value){
        if(value == null){
          return valmsg;
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
        children: [Text("Dont's have a Account ?",style:
        TextStyle(fontSize: 14,color: Colors.black87),),
          SizedBox(width: 5,),
          InkWell(onTap:(){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
          },
              child: Text("SignUp",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: custom_green),))
        ],),
    );
  }

  Widget Loginbutton(){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(onTap: (){
        if(_formloginkey.currentState!.validate()){
          setState(() {
            email = emailcontroller.text;
            password = passwordcontroller.text;
          });
          Loginuser();
        }
      },
        child: Container(width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(color: custom_green,
              borderRadius: BorderRadius.circular(15)),child:
          Center(child: Text("Login In",style: TextStyle(color: Colors.white,fontSize: 17),)),
        ),
      ),
    );
  }



}
