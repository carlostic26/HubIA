import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:math';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'access_ia.db'),
      onCreate: (database, version) async {
        const String sql = ''
            'CREATE TABLE access_ia ('
            ' id INTEGER PRIMARY KEY AUTOINCREMENT,'
            ' ia_name TEXT,'
            ' category TEXT,'
            ' image_url TEXT,'
            ' description TEXT,'
            ' web_url TEXT'
            ');';

        await database.execute(sql);

        const String addIA = ''
            'INSERT INTO access_ia(ia_name, category, image_url, description, web_url) VALUES '
            '('
            '"Introducción a la Inteligencia Artificial",'
            '"images",'
            '"https://example.com/image.jpg",'
            '"Este curso proporciona una introducción básica pero completa a la Inteligencia Artificial.",'
            '"https://example.com/ia_intro"'
            '),'
            '('
            '"Aprendizaje Automático Avanzado",'
            '"Aprendizaje Automático",'
            '"https://example.com/image.jpg",'
            '"Este curso explora técnicas avanzadas de aprendizaje automático y sus aplicaciones.",'
            '"https://example.com/ml_advanced"'
            ');';
        await database.execute(addIA);
      },
      version: 1,
    );
  }
}
