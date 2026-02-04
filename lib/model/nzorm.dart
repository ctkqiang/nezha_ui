abstract class NZORMEngine {
  int? id;

  String get tableName;

  Map<String, Type> get schema;

  Map<String, dynamic> toMap();

  NZORMEngine.fromMap(Map<String, dynamic> map);
}
