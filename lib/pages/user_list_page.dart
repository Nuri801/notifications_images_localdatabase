import 'package:fast_campus_app/model/inputform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

bool isDarkMode = false;

class _UserListPageState extends State<UserListPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  late Box _darkMode;
  late Box<InputForm> _inputFormBox;

  @override
  void initState() {
    _darkMode = Hive.box('darkModeBox');
    _inputFormBox = Hive.box<InputForm>('inputFormBox');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          CupertinoSwitch(
            value: isDarkMode,
            onChanged: (val) {
              setState(() {
                isDarkMode = val;
                _darkMode.put('darkMode', val);
              });
            },
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Column(
        children: [
          Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text('name'),
                ),
              ),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('age'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _inputFormBox.add(
                    InputForm(
                      name: nameController.text,
                      age: int.parse(ageController.text),
                    ),
                  );
                },
                child: const Text('add'),
              )
            ],
          ),
          const Divider(),
          ValueListenableBuilder(
            valueListenable: Hive.box<InputForm>("inPutFormBox").listenable(),
            builder: (context, Box<InputForm> inPutFormBox, widget) {
              final users = _inputFormBox.values.toList();
              return Expanded(
                child: users.isEmpty
                    ? const Text('empty')
                    : ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            title: Text(users[i].name),
                            subtitle: Text(users[i].age.toString()),
                            // trailing: MaterialButton(
                            //   onPressed: () {
                            //     final inputForm = users[i];
                            //     inPutFormBox.delete(inputForm.key);
                            //   },
                            //   child: const Icon(
                            //     Icons.cancel_sharp,
                            //     color: Colors.red,
                            //     size: 25,
                            //   ),
                            // ),
                          );
                        },
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
