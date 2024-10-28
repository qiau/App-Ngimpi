import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ngimpi/databases/note_database.dart';
import 'package:ngimpi/models/note_model.dart';
import 'package:ngimpi/screens/addnote_screen.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  NoteDatabase? noteDatabase;
  late Future<List<NoteModel>> dataList;

  @override
  void initState() {
    super.initState();
    noteDatabase = NoteDatabase();
    loadData();
  }

  loadData() async {
    dataList = noteDatabase!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: dataList,
            builder: (context, AsyncSnapshot<List<NoteModel>> snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.data!.length == 0) {
                return Center(
                  child: Image.asset(
                    'assets/images/kosong.png',
                    height: 214,
                    width: 167,
                  ),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    int noteId = snapshot.data![index].id!.toInt();
                    String noteTitle = snapshot.data![index].title.toString();
                    String noteDesc = snapshot.data![index].desc.toString();
                    String noteDate = snapshot.data![index].date.toString();
                    return Dismissible(
                      key: ValueKey<int>(noteId),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.redAccent,
                        child: Icon(Icons.delete, color: Colors.white),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                      ),
                      onDismissed: (DismissDirection direction) {
                        setState(() {
                          noteDatabase!.delete(noteId);
                          dataList = noteDatabase!.getDataList();
                          snapshot.data!.remove(snapshot.data![index]);
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 5, horizontal: 16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffF6F9FF),
                              Color(0xffEDF4FF),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.all(10),
                              title: Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  noteTitle,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              subtitle: Text(
                                noteDesc,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 0.8,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    noteDate,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddnoteScreen(
                                              noteId: noteId,
                                              noteTitle: noteTitle,
                                              noteDesc: noteDesc,
                                              noteDate: noteDate,
                                              update: true,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.edit_note_rounded,
                                        color: Colors.blue[900],
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          )),
        ],
      ),
    );
  }
}
