import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/shared_prefrences.dart';
import 'package:my_notes/helper/capitalize.dart';
import 'package:my_notes/views/note_view.dart';
import 'package:my_notes/widgets/no_notes_widget.dart';
import 'package:sqflite/sqflite.dart';

import '../widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetOpened = false;
  TextEditingController noteController = TextEditingController();
  List<Map> notes = [];

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        leading: const DrawerButton(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: notes.isEmpty ? const NoNotesWidget() : CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What\'s Up, ${CacheHelper.getString(key: 'firstName')?.capitalize()}!',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Your Notes',
                    style: TextStyle(
                      color: kLightColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            SliverList.separated(
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      height: 60,
                      width: 5,
                      decoration: BoxDecoration(
                        color: kActiveColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onLongPress: () {
                        deleteDatabase(notes[index]['id']).then((value) {
                          getDataFromDatabase(database).then((value) {
                            setState(() {
                              notes = value;
                            });
                          });
                        });
                      },
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NoteView(date: notes[index]['date'], time: notes[index]['time'], note: notes[index]['note'],),));
                      },
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.84,
                        height: 70,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${notes[index]['note']}',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 15,
                );
              },
              itemCount: notes.length,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: kActiveColor,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            isBottomSheetOpened ? Icons.done_rounded : Icons.add_rounded,
            size: 40,
          ),
          onPressed: () {
            setState(() {
              getDataFromDatabase(database).then((value) {
              notes = value;
              });
            });
            if (isBottomSheetOpened) {
              if (formKey.currentState!.validate()) {
                 insertIntoDatabase(note: noteController.text).then((value) {
                  getDataFromDatabase(database).then((value) {
                    setState(() {
                      notes = value;
                    });
                  }).then((value) {
                  setState(() {
                    isBottomSheetOpened = false;
                    noteController.clear();
                    Navigator.pop(context);
                  });
                  });
                });
              }
            } else {
              scaffoldKey.currentState
                  ?.showBottomSheet(
                    (context) => IntrinsicHeight(
                      child: Container(
                        color: kPrimaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText: 'what\'s in your mind?',
                                  ),
                                  keyboardType: TextInputType.text,
                                  controller: noteController,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Note must not be empty';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .closed
                  .then((value) {
                setState(() {
                    getDataFromDatabase(database).then((value) {
                      notes = value;
                    });
                  isBottomSheetOpened = false;
                });
              });
              setState(() {
                isBottomSheetOpened = true;
              });
            }
          }),
    );
  }

  Future<void> createDatabase() async {
    database = await openDatabase('notes.db', version: 3,
        onCreate: (Database db, int version) async {
      //print('database created');
      await db
          .execute(
              'CREATE TABLE notes (id INTEGER PRIMARY KEY, note TEXT, date TEXT, time TEXT)')
          .then((value) => //print('table created')
      null )
          .catchError((e) {
        throw e;
      });
    }, onOpen: (database) async {
      //print('database opened');
      await getDataFromDatabase(database).then((value) {
        setState(() {
          notes=value;
        });
        //print(notes);
      });
    });
  }

  Future<void> insertIntoDatabase({required String note}) async {
    return await database.transaction((txn) async {
       await txn
          .rawInsert(
              'INSERT INTO notes(note, date, time) VALUES("$note", CURRENT_DATE, CURRENT_TIME)')
          .then((value) => value)
          .catchError((e) {
        throw e;
      });
      //print('inserted1: $id1');
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database.rawQuery('SELECT * FROM notes');
  }

  Future<List<Map<String, Object?>>> deleteDatabase(id) async {
    return await database.rawQuery('DELETE FROM notes WHERE id = $id');
  }
}
