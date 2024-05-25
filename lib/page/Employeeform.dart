import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import '../services/database.dart';

class Employeeform extends StatefulWidget {
  const Employeeform({super.key});

  @override
  State<Employeeform> createState() => _EmployeeformState();
}

class _EmployeeformState extends State<Employeeform> {

  final name = TextEditingController();
  final age = TextEditingController();
  final location = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Employee Form",style: TextStyle(color: Colors.orange),)
        ],),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          const  Text("Name", style: TextStyle(color: Colors.black,fontSize: 20),),
              SizedBox(height: 8,),
              Container(
                padding: EdgeInsets.only(left: 10,top: 8),
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.black87)),
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              const  Text("Age", style: TextStyle(color: Colors.black,fontSize: 20),),
              SizedBox(height: 8,),
              Container(
                padding: EdgeInsets.only(left: 10,top: 8),
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.black87)),
                child: TextFormField(
                  controller: age,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              const  Text("Location", style: TextStyle(color: Colors.black,fontSize: 20),),
              SizedBox(height: 8,),
              Container(
                padding: EdgeInsets.only(left: 10,top: 8),
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.black87)),
                child: TextFormField(
                  controller: location,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(onTap: ()  async {
                  String eid = randomAlphaNumeric(10);
                  Map<String, dynamic>employeeinfomap={
                    "Name" : name.text,
                    "Age" : age.text,
                    "Location" : location.text,
                    "id":eid
                  };
                  await Databasemethods().addemployeedetails(employeeinfomap, eid).then((value) =>
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                  Text("Employee Details Added Successfully"),backgroundColor: Colors.green,)));

                  Navigator.pop(context);

                  print("hi");
                },
                  child: Container(width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(18)),
                  child: Center(child: Text("Confirm",style: TextStyle(color: Colors.white,fontSize: 18),)),),
                ),
              )


          ],),
        ),
      ),
    );
  }

}
