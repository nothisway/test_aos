import 'package:sqflite/sqflite.dart';
import 'package:test_flutter_aos/Model/Member.dart';
import 'package:test_flutter_aos/Utils/DbAccess.dart';

class CRUD{
  static const todoTable = 'member';
  static const id = 'id';
  static const name = 'name';
  static const phone = 'phone';
  static const birthDate = 'birthDate';
  static const image = 'image';
  static const address = 'address';


  DbAccess dbHelper = new DbAccess();
  Future<int> insert(Member todo) async {
    Database db = await dbHelper.initDb();
    int count = await db.insert('member', todo.toMap());
    return count;
  }
  Future<int> update(Member todo) async {
    Database db = await dbHelper.initDb();
    int count = await db.update('member', todo.toMap(),
        where: 'id=?', whereArgs: [todo.id]);
    return count;
  }
  Future<int> delete(Member todo) async {
    Database db = await dbHelper.initDb();
    int count =
    await db.delete('member', where: 'id=?', whereArgs: [todo.id]);
    return count;
  }
  Future<List<Member>> getMemberList() async {
    Database db = await dbHelper.initDb();
    List<Map<String, dynamic>> mapList =
    await db.query('member', orderBy: 'name');
    int count = mapList.length;
    List<Member> memberList = List<Member>();
    for (int i = 0; i < count; i++) {
      memberList.add(Member.fromMap(mapList[i]));
    }
    return memberList;
  }
}