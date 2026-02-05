import 'package:nezha_ui/model/nzorm.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NZDatabase {
  static NZDatabase get instance => NZDatabase.init();

  NZDatabase._();
  NZDatabase.init() : this._();

  Future<void> create({
    required String databaseName,
    required List<NZORMEngine> tables,
    int? version = 1,
  }) async {
    assert(!databaseName.contains('.db'), '数据库名称不应包含 .db 扩展名，我们已经为您处理了');

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, '$databaseName.db');

    await openDatabase(
      path,
      version: version,
      onCreate: (db, version) async {
        for (var table in tables) {
          await createTable(db: db, table: table);
        }
      },
    );
  }

  Future<void> createTable({
    required Database db,
    required NZORMEngine table,
  }) async {
    final buffer = StringBuffer();

    buffer.write('CREATE TABLE IF NOT EXISTS ${table.tableName} (');
    buffer.write('id INTEGER PRIMARY KEY AUTOINCREMENT, ');
  }
}
