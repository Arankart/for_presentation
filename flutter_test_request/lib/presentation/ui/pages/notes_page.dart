import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final GlobalKey<FormState> formsKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        ElevatedButton(
            onPressed: () async {
              addDataButton(context);
            },
            child: Text("Добавить заметку")),
        SizedBox(
          height: 12,
        ),
        Divider(),
        Flexible(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    FutureBuilder(
                      future:
                          FirebaseFirestore.instance.collection('note').get(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("Пока ещё нет ни одной заметки"),
                          );
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                        snapshot.data!.docs[index]['title']),
                                    subtitle: Text(snapshot.data!.docs[index]
                                        ['description']),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void addDataButton(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 360,
          child: Container(
            padding: EdgeInsets.all(12),
            color: Colors.grey.shade100,
            child: Form(
              key: formsKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Название',
                      labelStyle: TextStyle(color: Colors.grey.shade400),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Поле не должно быть пустым';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Текст',
                      labelStyle: TextStyle(color: Colors.grey.shade400),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Поле не должно быть пустым';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Вернуться назад"),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber)),
                        onPressed: () {
                          final formValidate =
                              formsKey.currentState!.validate();
                          if (formValidate) {
                            final Map<String, String> note_data = {
                              'title': titleController.text,
                              'description': descriptionController.text,
                            };
                            db.collection('note').add(note_data);
                            Navigator.pop(context);
                            titleController.text = '';
                            descriptionController.text = '';
                            setState(() {});
                          }
                        },
                        child: Text("Добавить заметку",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
