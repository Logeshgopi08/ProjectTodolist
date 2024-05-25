import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project3/page/Employeeform.dart';
import 'package:project3/services/database.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final name = TextEditingController();
  final age = TextEditingController();
  final location = TextEditingController();

  Stream ? Employeestream;

  getonthedata()async{
    Employeestream = await Databasemethods().getemployeedetail();
    setState(() {

    });
  }
  @override
  void initState() {
    getonthedata();
    super.initState();
  }

  Widget allemployeedetail(){
    return StreamBuilder(stream: Employeestream, builder: (context ,AsyncSnapshot snapshot){
      return snapshot.hasData ? ListView.builder(itemCount: snapshot.data.docs.length,
          itemBuilder:(context,index){
    DocumentSnapshot ds = snapshot.data.docs[index];
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(18),
        child: Container(width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 10,right: 15,top: 10,bottom: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(18),
          ),child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Name :"+ds["Name"],style: TextStyle(color: Colors.blue,fontSize: 18),),
                  Spacer(),
                  InkWell(onTap: (){
                    name.text= ds["Name"];
                    age.text = ds["Age"];
                    location.text = ds["Location"];
                    Editemployeedetail(ds["id"]);
                  },
                      child: Icon(Icons.edit,color: Colors.orange,size: 25,)),
                  SizedBox(width: 5,),
                  InkWell(onTap: () async{
                await Databasemethods().deleteinfo(ds["id"]);
                  },
                      child: Icon(Icons.delete,color: Colors.orange,size: 25,))
                ],
              ),
              Text("Age:"+ds["Age"],style: TextStyle(color: Colors.orange,fontSize: 18),),
              Text("Location :"+ds["Location"],style: TextStyle(color: Colors.blue,fontSize: 18),),


            ],),),
      ),
    );
      }):Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.black,
        title: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Home",style: TextStyle(color: Colors.orange),)
          ],),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Employeeform()));
      },
      child: Icon(Icons.add),),
      body: Container(margin: EdgeInsets.only(top: 10),
        child: Column(children: [
          Expanded(child: allemployeedetail())
        ],),),
    );
  }

  Future Editemployeedetail(String id)=>showDialog(context: context, builder: (context)=>AlertDialog(
    content: Container(child: Column(children: [
      Row(children: [
        InkWell(onTap: (){Navigator.pop(context);},
            child: Icon(Icons.cancel)),
        Text("Edit Detail",style: TextStyle(color: Colors.orange))
      ],),
      Text("Name", style: TextStyle(color: Colors.black,fontSize: 20),),
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
      SizedBox(height: 20,),
      ElevatedButton(onPressed: ()async{
        Map<String , dynamic> updateinfo ={
          "Name" :name.text,
          "Age":age.text,
          "Location ": location.text,
          "id":id
        };
        await Databasemethods().updateemployeedetail(id, updateinfo);
        Navigator.pop(context);
      }, child: Text("Update"))

    ],),),
  ));
}
