
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'app/index.dart';
import 'models/note.dart';



class HomeScreen extends StatefulWidget {
  static WidgetBuilder route() => (_) => const HomeScreen();
  const HomeScreen({Key? key}) : super(key: key);
  @override State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {

  List<Note> notes = [];
  int editingToolsIndex = -1;
  bool isLoading = true;
  bool showContent = true;


  void toggleContent() {
    setState(()=> showContent = !showContent);
  }

  
  void toggleEditingTools(int index) {
    int newIndex = index == editingToolsIndex ? -1 : index;
    setState(() => editingToolsIndex = newIndex);
  }





  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) navigator.pushNamed(Routes.login);

      FirebaseFirestore.instance
        .collection('notes')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((snapshot) {
          setState(() {
            isLoading = false;
            notes = snapshot.docs.map((doc) => Note.fromJson(doc.data())).toList();
          });
        });
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(notes.length),
      floatingActionButton: floatingActionButton(),
      body: isLoading ?
        const Center(child: CircularProgressIndicator()) :
        ListView.separated(
          itemCount: notes.length,
          separatorBuilder: (context, index) => const Divider(color: Colors.blueGrey),
          itemBuilder: (context, index) => noteTile(notes[index], index),
        ),
    );
  }



  AppBar appBar(int count) {
    return AppBar(
      title: const Text('My Notes'),
      actions: [
        CircleAvatar(
          backgroundColor: Colors.blue.shade200,
          child: Text(
            count.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget noteTile(Note note, int index) {

    final trailingButtons = SizedBox(
      width: 110.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.blue,
            ),
            onPressed: () {} ,
          ),
        ],
      ),
    );

    return ListTile(
      title: Text(note.title ?? 'Untitled Note'),
      subtitle: showContent ? Text(note.content ?? '') : null,
      trailing: editingToolsIndex == index ? trailingButtons : null,
      onTap: () {},
      onLongPress: ()=> toggleEditingTools(index),
    );
  }

  Widget floatingActionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'show-more',
          tooltip: 'Show less. Hide notes content',
          onPressed: toggleContent,
          child: Icon(
            showContent? Icons.unfold_less : Icons.unfold_more,
          )
        ),
        FloatingActionButton(
          heroTag: 'add-note',
          tooltip: 'Add a new note',
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
