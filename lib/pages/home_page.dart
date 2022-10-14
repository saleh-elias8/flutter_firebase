import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/read%20data/get_user_name.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  //document IDs
  List<String> docIDs = [];

  //get docIDs
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .orderBy('first Name',descending: true)
        .where('age',isGreaterThan: 50)
        .get().then(
          (snapshot) => snapshot.docs.forEach(
                  (document) {
                    print(document.reference);
                    docIDs.add(document.reference.id);
                  },
          ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( user.email!,style: TextStyle(fontSize: 16),),
        backgroundColor: Colors.blueGrey,
          actions: [
          GestureDetector(
              onTap: (){
                FirebaseAuth.instance.signOut();
                },
              child: Icon(Icons.logout))
        ],
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: FutureBuilder(
                    future: getDocId(),
                    builder: (context,snapshot){
                    return ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: GetUserName(documentId: docIDs[index]),
                            tileColor: Colors.grey[300],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
