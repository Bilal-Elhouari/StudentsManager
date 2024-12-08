import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String studentName,studentId,studentModule;
  late String studentNote;

  getStudentName(name){
    this.studentName=name;
  }
  getStudentId(id){
    this.studentId=id;
  }

  getStudentModule(module){
    this.studentModule=module;
  }

  getStudentNote(note){
    this.studentNote=note;
  }

 void createData(){
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyStudent").
    doc(studentName);

    Map<String, dynamic> student= {
      "studentName": studentName,
      "studentId": studentId,
      "studentModule": studentModule,
      "studentNote": studentNote,
    };
    documentReference.set(student).whenComplete ((){
      print("$studentName created");
    });
  }

 void readData() {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyStudent").
    doc(studentName);

    documentReference.get().then((datasnapshot)
    {
      print(datasnapshot["studentName"]);
      print(datasnapshot["studentId"]);
      print(datasnapshot["studentModule"]);
      print(datasnapshot["studentNote"]);
    });
  }

  updateData(){
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyStudent").
    doc(studentName);

    Map<String, dynamic> student= {
      "studentName": studentName,
      "studentId": studentId,
      "studentModule": studentModule,
      "studentNote": studentNote,
    };
    documentReference.set(student).whenComplete ((){
      print("$studentName updated");
    });
  }


  deleteData(){
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyStudent").
    doc(studentName);
    
    documentReference.delete().whenComplete((){
      print("$studentName deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text("Page de Gestion"),
          backgroundColor: Colors.indigo,
          centerTitle: true,
          elevation: 4,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle_outlined),
              onPressed: ()
              {
              },
            ),
          ],
        ),


        body:Column(
       children: [
//nom
         Padding(
           padding:  EdgeInsets.all(10),
           child: TextFormField(
             decoration: const InputDecoration(
               labelText: "Nom",
               fillColor: Colors.white,
               focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white,
                width: 1)),
             ),
             onChanged: (String name)
             {
               getStudentName(name);
             },
           ),
         ),
         //id
         Padding(
           padding: const EdgeInsets.all(10),
           child: TextFormField(
             decoration: const InputDecoration(
               labelText: "ID ELEVE",
               fillColor: Colors.white,
               focusedBorder: OutlineInputBorder(
                   borderSide: BorderSide(color: Colors.white,
                       width: 1)),
             ),
             onChanged: (String id){
               getStudentId(id);
             },
           ),
         ),
         Padding(
           padding: const EdgeInsets.all(10),
           child: TextFormField(
             decoration: const InputDecoration(
               labelText: "Module",
               fillColor: Colors.white,
               focusedBorder: OutlineInputBorder(
                   borderSide: BorderSide(color: Colors.white,
                       width: 1)),
             ),
             onChanged: (String Module){
               getStudentModule(Module);
             },
           ),
         ),
         Padding(
           padding: const EdgeInsets.all(10),
           child: TextFormField(
             decoration: const InputDecoration(
               labelText: "Note",
               fillColor: Colors.white,
               focusedBorder: OutlineInputBorder(
                   borderSide: BorderSide(color: Colors.white,
                       width: 1)),
             ),
             onChanged: (String Note){
               getStudentNote(Note);
             },
           ),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: <Widget>[
             ElevatedButton(
               onPressed:()
               {
                createData();
               },
               style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.green,
                   padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5)
               ),
               child: const Text(
                 "Create",
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 20,
                 ),
               ),
             ),

             ElevatedButton(
               onPressed:()
               {
                 readData();
               },
               style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.deepPurple,
                   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5)
               ),
               child: const Text(
                 "Read",
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 20,
                 ),
               ),
             ),

             ElevatedButton(
               onPressed:()
               {
                 updateData();
               },
               style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.amber,
                   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5)
               ),
               child: const Text(
                 "Update",
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 20,
                 ),
               ),
             ),

             ElevatedButton(
               onPressed:()
               {
                  deleteData();
               },
               style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.red,
                   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5)
               ),
               child: const Text(
                 "Delete",
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 20,
                 ),
               ),
             ),
           ],
         ),


//////////////////////////////////////////////////////////////
    Padding(
    padding: EdgeInsets.all(10),
    child: Card(
    elevation: 5,
    child: Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
    child: Column(
    children: [
    const Row(
    textDirection: TextDirection.ltr,
    children: <Widget>[
    Expanded(
    child: Text(
    "Name",
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
    ),
    ),
    Expanded(
    child: Text(
    "ID",
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
    ),
    ),
    Expanded(
    child: Text(
    "Module",
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
    ),
    ),
    Expanded(
    child: Text(
    "Note",
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
    ),
    ),
    ],
    ),
    StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection("MyStudent").snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return CircularProgressIndicator();
    } else if (snapshot.hasError) {
    return Text("Erreur : ${snapshot.error}");
    } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
    return Text("Aucune donnée disponible.");
    } else {
    return ListView.builder(
    shrinkWrap: true,
    itemCount: snapshot.data!.docs.length,
    itemBuilder: (context, index) {
    DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    return Card(
    margin: EdgeInsets.all(5),
    elevation: 2,
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
    textDirection: TextDirection.ltr,
    children: <Widget>[
    Expanded(child: Text(data["studentName"] ?? "", style: TextStyle(fontSize: 18))),
    Expanded(child: Text(data["studentId"] ?? "", style: TextStyle(fontSize: 18))),
    Expanded(child: Text(data["studentModule"] ?? "", style: TextStyle(fontSize: 18))),
    Expanded(child: Text(data["studentNote"] ?? "", style: TextStyle(fontSize: 18))),
    ],
    ),
    ),
    );
    },
    );
    }
    },
    ),
    ]
    )
    )
    )
    )
    ],
    )
    );

////////////////////

  }
}
