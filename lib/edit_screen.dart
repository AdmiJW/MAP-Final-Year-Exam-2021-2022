import 'package:flutter/material.dart';

import 'app/index.dart';
import 'models/note.dart';



enum EditScreenMode {
  create,
  edit,
  view,
}


class EditScreenArguments {
  EditScreenMode mode;
  Note? note;

  EditScreenArguments({
    required this.mode,
    this.note,
  });
}




class EditScreen extends StatefulWidget {
  static WidgetBuilder route() => (_) => const EditScreen();

  const EditScreen({Key? key}) : super(key: key);

  @override State<EditScreen> createState() => _EditScreenState();
}



class _EditScreenState extends State<EditScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  EditScreenArguments? args;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final EditScreenArguments? args = ModalRoute.of(context)
      ?.settings
      .arguments as EditScreenArguments?;

    setState(() => this.args = args);
    _titleController.text = args?.note?.title ?? '';
    _descriptionController.text = args?.note?.content ?? '';
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }


  AppBar appBar() {

    final title = 
      args?.mode == EditScreenMode.create ? "Add New Note" :
      args?.mode == EditScreenMode.edit ? "Edit Note" : "View Note";

    final confirmButton = IconButton(
      icon: const Icon(Icons.check_circle, size: 30),
      onPressed: () {}
    );

    final cancelButton = IconButton(
      icon: const Icon(Icons.cancel_sharp, size: 30),
      onPressed: ()=> navigator.pop(),
    );


    return AppBar(
      leading: Container(),
      centerTitle: true,
      title: Text(title),
      actions: [
        if (args?.mode != EditScreenMode.view) confirmButton,
        cancelButton,
      ],
    );
  }


  Widget body() {

    final isEnabled = args?.mode != EditScreenMode.view;


    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            initialValue: null,
            enabled: isEnabled,
            decoration: const InputDecoration(
              hintText: 'Type the title here',
            ),
            onChanged: (value) {},
          ),
          const SizedBox(height: 5),
          Expanded(
            child: TextFormField(
              controller: _descriptionController,
              enabled: isEnabled,
              initialValue: null,
              maxLines: null,
              expands: true,
              decoration: const InputDecoration(
                hintText: 'Type the description',
              ),
              onChanged: (value) {}
            ),
          ),
        ],
      ),
    );
  }
}
