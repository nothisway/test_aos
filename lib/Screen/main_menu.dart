import 'package:flutter/material.dart';
import 'package:test_flutter_aos/Model/Member.dart';
import 'package:test_flutter_aos/Utils/CRUD.dart';

import 'entry_form.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CRUD dbHelper = CRUD();
  Future<List<Member>> future;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  void updateListView() {
    setState(() {
      future = dbHelper.getMemberList();
    });
  }

  Future<Member> navigateToEntryForm(
      BuildContext context, Member member, bool edit) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(
        member: member,
        edit: edit,
      );
    }));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Member"),
      ),
      body: FutureBuilder<List<Member>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data.length > 0){
              return Column(
                  children: snapshot.data.map((todo) => cardo(todo)).toList());
            } else {
              return body();
            }
          } else {
            return body();
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: FloatingActionButton(
          onPressed: () async {
            var member2 = await navigateToEntryForm(context, null, false);
            if (member2 != null) {
              int result = await dbHelper.insert(member2);
              if (result > 0) {
                updateListView();
              }
            }
          },
          tooltip: 'Increment',
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: Colors.white, width: 3)),
          child: Icon(Icons.add),
        ),
      ),
      //
      bottomSheet: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(5),
          height: 45,
          color: Colors.redAccent,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, // iling comma makes auto-formatting nicer for build methods.
    );
  }

  Widget body() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Belum Ada Data Untuk Ditampilkan',
            ),
          ],
        ),
      ),
    );
  }

  Card cardo(Member member) {
    print("image:  " + member.image.toString());
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: Colors.red,
            backgroundImage: member.image == null
                ? AssetImage(
                    'assets/foto_profil.png',
                  )
                : AssetImage(member.image)),
        title: Text(
          member.name,
        ),
        subtitle: Text(member.phone.toString()),
        trailing: GestureDetector(
          child: Icon(Icons.delete),
          onTap: () async {
            int result = await dbHelper.delete(member);
            if (result > 0) {
              updateListView();
            }
          },
        ),
        onTap: () async {
          var member2 = await navigateToEntryForm(context, member, true);
          if (member2 != null) {
            int result = await dbHelper.update(member2);
            if (result > 0) {
              updateListView();
            }
          }
        },
      ),
    );
  }
}
