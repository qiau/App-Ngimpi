import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ngimpi/dashboard.dart';
import 'package:ngimpi/databases/note_database.dart';
import 'package:ngimpi/models/note_model.dart';

// ignore: must_be_immutable
class AddnoteScreen extends StatefulWidget {
  int? noteId;
  String? noteTitle;
  String? noteDesc;
  String? noteDate;
  bool? update;

  AddnoteScreen(
      {this.noteId, this.noteTitle, this.noteDesc, this.noteDate, this.update}
  );

  @override
  State<AddnoteScreen> createState() => _AddnoteScreenState();
}

class _AddnoteScreenState extends State<AddnoteScreen> {
  NoteDatabase? noteDatabase;
  late Future<List<NoteModel>> dataList;

  final _fromKey = GlobalKey<FormState>();

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
    final titleController = TextEditingController(text: widget.noteTitle);
    final descController = TextEditingController(text: widget.noteDesc);
    String appTitle;
    if(widget.update == true){
      appTitle = 'Mengubah Catatan';
    } else {
      appTitle = 'Tambah Catatan';
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          appTitle,
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _fromKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Masukkan judul mimpimu',
                            border: OutlineInputBorder()),
                        keyboardType: TextInputType.multiline,
                        controller: titleController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Masukkan judulnya ya..';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Ceritakan semuanya di sini',
                            border: OutlineInputBorder()),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 5,
                        controller: descController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Isinya jangan lupa..';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Material(
                      color: Color(0xffEDF4FF),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            titleController.clear();
                            descController.clear();
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          height: 55,
                          width: 120,
                          child: Text(
                            'Ulang',
                            style: TextStyle(
                              color: Color(0xff31457E),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Color(0xff31457E),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          if (_fromKey.currentState!.validate()) {
                            if(widget.update == true){
                              noteDatabase!.update(NoteModel(
                                id: widget.noteId,
                                title: titleController.text, 
                                desc: descController.text, 
                                date: widget.noteDate,
                              ));
                            }else{
                              noteDatabase!.insert(NoteModel(
                                title: titleController.text, 
                                desc: descController.text, 
                                date: DateFormat('yMd').add_jm().format(DateTime.now()).toString()
                              ));
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard()));
                            titleController.clear();
                            descController.clear();
                            print("berhasil!");
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          height: 55,
                          width: 120,
                          
                          child: Text(
                            'Simpan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
