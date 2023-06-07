
import 'package:flutter/material.dart';

import 'app/index.dart';



class HomeScreen extends StatelessWidget {
  static WidgetBuilder route() => (_) => const HomeScreen();
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      floatingActionButton: floatingActionButton(),
      body: ListView.separated(
        itemCount: 4,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.blueGrey,
        ),
        itemBuilder: (context, index) => ListTile(
          title: const Text('Note title'),
          subtitle: const Text('Note content'),
          onTap: () {},
          onLongPress: () {},
          trailing: SizedBox(
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
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  AppBar appBar() {
    return AppBar(
      title: const Text('My Notes'),
      actions: [
        CircleAvatar(
          backgroundColor: Colors.blue.shade200,
          child: const Text(
            '4',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  
  Widget floatingActionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'show-more',
          tooltip: 'Show less. Hide notes content',
          onPressed: () {},
          child: const Icon(Icons.menu)
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
