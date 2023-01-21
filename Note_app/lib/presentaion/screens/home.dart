import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/logic/cubit/app_cubit.dart';

import '../../models/note.dart';
import 'notes/add_note.dart';
import 'sign_in.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference notesref = FirebaseFirestore.instance.collection('notes');

  FirebaseAuth userref = FirebaseAuth.instance;
  String? id;
  @override
  void initState() {
    id = userref.currentUser?.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await BlocProvider.of<AppCubit>(context).signOut();
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return SignIn();
                }));
              },
              icon: Icon(Icons.exit_to_app_outlined))
        ],
        backgroundColor: Colors.deepOrangeAccent,
        title: Text('My Notes'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AddNotes();
          }));
        },
      ),

    );
  }
}
