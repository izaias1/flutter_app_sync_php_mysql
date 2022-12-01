import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:offline/contactinfomodel.dart';
import 'package:offline/controller.dart';
import 'package:offline/syncronize.dart';

import 'databasehelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqfliteDatabaseHelper.instance.db;
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  //..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sync Sqflite to Mysql',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Timer _timer;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController gender = TextEditingController();

  late List list;
  bool loading = true;

  get id => null;

  Future userList() async {
    list = await Controller().fetchData();
    setState(() {
      loading = false;
    });
    // print(list);
  }

  Future syncToMysql() async {
    await SyncronizationData().fetchAllInfo().then(
      (userList) async {
        print(userList);
        EasyLoading.show(status: 'Dont close app. we are sync...');
        await SyncronizationData().saveToMysqlWith(userList);
        EasyLoading.showSuccess('Successfully save to mysql');
      },
    );
  }

  Future isInteret() async {
    await SyncronizationData.isInternet().then((connection) {
      if (connection) {
        // print("Internet conectada");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Você está sem internet")));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    userList();
    isInteret();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sync Sqflite to Mysql"),
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh_sharp),
              onPressed: () async {
                await SyncronizationData.isInternet().then((connection) {
                  if (connection) {
                    syncToMysql();
                    // print("Conectado na internet");
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Você está sem Internet")));
                  }
                });
              })
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: name,
              decoration: const InputDecoration(hintText: 'Nome'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: email,
              decoration: const InputDecoration(hintText: 'E-mail'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: gender,
              decoration: const InputDecoration(hintText: 'Genero'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                ContactinfoModel contactinfoModel = ContactinfoModel(
                  id: id,
                  userId: 1,
                  name: name.text,
                  email: email.text,
                  gender: gender.text,
                  createdAt: DateTime.now().toString(),
                );
                await Controller().addData(contactinfoModel).then(
                  (value) {
                    if (value > 0) {
                      print("Success");
                      userList();
                    } else {
                      print("faild");
                    }
                  },
                );
              },
              child: const Text("Salvar"),
            ),
          ),
          loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: list.length == null ? 0 : list.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(list[index]['id'].toString()),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(list[index]['name']),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(list[index]['email']),
                            Text(list[index]['gender']),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
