import 'package:hubia/screens/screens_barril.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:math';

class DatabaseHandlerIA {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'ias_10.db'),
      onCreate: (database, version) async {
        const String createIaTable = ''
            'CREATE TABLE access_ia ('
            ' id INTEGER PRIMARY KEY AUTOINCREMENT,'
            ' name TEXT,'
            ' category TEXT,'
            ' imageUrl TEXT,'
            ' webUrl TEXT,'
            ' description TEXT,'
            ' tutorialUrl TEXT'
            ');';

        await database.execute(createIaTable);

        const String createFavoritesTable = ''
            'CREATE TABLE favorite_ias ('
            ' name TEXT PRIMARY KEY'
            ');';

        await database.execute(createFavoritesTable);

        // video ---
        //video colab GFP-GAN https://colab.research.google.com/drive/1Z6RINOM-wTmXcWuHatgPpJ5nVg39bZkr?usp=sharing
        //video colab GFP-GAN 2 https://colab.research.google.com/drive/1T9ia0rP3lWy2m4tTlHHYLCULvLqZC9If?usp=sharing
        //video colab Codeformer https://colab.research.google.com/drive/1yAMhqxgnp5PLkIuJdYXlYFo90rEAcge0?usp=sharing
        //video colab FPS RIFE https://colab.research.google.com/drive/1a6NnAN_sPBiFMp3HEZgknRbQAulkohkc?usp=drive_link
        //video colab FPS RIFE 2 https://colab.research.google.com/drive/1-Cxa_p8oTiflduqOJMCzSpOLxGzIGhTF

        // audio ---
        //https://podcast.adobe.com/enhance
        //https://studio.moises.ai/
        //

        // texto ---
        // copy.ai https://app.copy.ai/
        // copilot https://copilot.microsoft.com/?form=MY02E6&OCID=MY02E6&culture=es-es&country=es
        // chatgpt https://chat.openai.com/
        // Gemini Bard https://gemini.google.com/app

        //others ---
        //PimEyes

        //images
        // dragGan colab
        // SwinIr online

        //video
        //tecogan

        const String addIA = ''
            'INSERT INTO access_ia(name, category, imageUrl, webUrl, description, tutorialUrl) VALUES '
            //'("Inombre ia","image","image.jpg","weburl", "/n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            //
            //
            '("ClipDrop Image Uncrop IA","image","https://blogger.googleusercontent.com/img/a/AVvXsEgnkzUQCHuBFNO3rR75Gyyt81FvcRNQs-ca1AAWUWajvmNuwPX6xnxEQltI5LkxmrD6QYS1VK4PVN8r2l4GRfSS7KyQHrdT8OlhogSffikOyK5WfHO9HU4vxM93JhFN7gVWnHK2NngSJMnug3s4Q2Fqmo4nJ0YWP4hmATIBWXrq1la-Z7Uxg9ROnz8Q", "https://clipdrop.co/uncrop", "Es una herramienta optimizada para editar la relación de aspecto de imágenes. Está basada en un modelo fundamental creado por Stability AI. Los usuarios pueden cargar imágenes y seleccionar una nueva relación de aspecto. La herramienta generará la imagen con la nueva proporción, permitiéndote ajustar las dimensiones y expandir el lienzo visual. Si tienes una imagen recortada o imperfecta, Uncrop utiliza tecnología de outpainting para reconstruir y extender la imagen, como si fuera mágico./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("DragGan-Inversion IA","image","https://blogger.googleusercontent.com/img/a/AVvXsEgabiP35k863OlOZ_iVLVlAmDLNRLIHd_TEBLeqOilcfnTEERKlQuvdyeN8uIN5bIfagDRISCV2jsV16ulWdgxGnoyUnR1memgY7C-brXjD-6d502hs2SmKYLrApS0R_U1yxf4jVPX7gbqccQseLWw3a2zOFMDGQ-ksHGA1bdSGvAkU1fY7XGos-ENB", "https://huggingface.co/spaces/Amrrs/DragGan-Inversion", "Te  permite manipular imágenes generadas por redes generativas antagónicas (GAN). Al aplicar la inversión GAN a una imagen real y mapearla de nuevo al espacio latente de StyleGAN, DragGan te empodera con capacidades avanzadas de manipulación de imágenes. Puedes ajustar la pose, el cabello, la forma y la expresión de las imágenes, lo que resulta especialmente útil para fotógrafos, diseñadores y creadores de contenido. Además, su enfoque en la interactividad y la precisión lo convierte en una herramienta valiosa para explorar y experimentar con tus imágenes./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://www.youtube.com/watch?v=zTqtZl8ALJ8"),'
            '("CodeFormer Image IA","image","https://blogger.googleusercontent.com/img/a/AVvXsEhOpT_OmxLhZioODImkOWI8C-TG7FrGZg8Dp79kYHi1U6Q4wetN_iPPymGrKijdaAm2emPRmc_4Ah-R2D218hMLHXQP94qTT8xqEvZAAUpQbu2y0uzUrmN0al0BZgZVtJV-b0T-xa_nljQ99v0EEzlMvSwGpWjPYcQaR3IreBYdU_bgdz3vm4k_uD2d", "https://huggingface.co/spaces/sczhou/CodeFormer", "Restaura y mejora características faciales en imágenes. Su utilidad radica en recuperar detalles sutiles y mejorar la calidad visual de fotos, especialmente útil para fotógrafos, diseñadores y creadores de contenido ./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("IllusionDiffusion IA","image","https://blogger.googleusercontent.com/img/a/AVvXsEgBT2-D8Q-2p2B1w5mZjwTwMp5OtJLKb4g-cML9GAYBHZ1QXP5HIGnYenOrrRiJonueoFrKknHxdeYnbxejAA5Kf7v4G8L7j-pk4Y7MD5wq4RxlE_KIFTapi_DSWHfBqSUUtgGHHphUB78ph4TaSRl7-VKqpYY3eQbRgangJd6AaduT1kj-AvqLyFLU", "https://huggingface.co/spaces/AP123/IllusionDiffusion", "Permite a los usuarios explorar una colección impresionante de aplicaciones de ML desarrolladas por la comunidad. En particular, IllusionDiffusion se destaca al transformar imágenes en ilusiones ópticas, brindando una nueva vida a las obras digitales y ofreciendo una experiencia creativa única./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("ifan-defocus-deblur IA","image","https://blogger.googleusercontent.com/img/a/AVvXsEhbulHI9XYP6mD8Xs_SJzcmVNLlM2hhm1bnunK4Pifyx_KgbDUcrBc0-wfLNokGmYtiYazN4kB8s6-1_vYSrFGQ8HG3lg-J6oxYWsxVFISg0L2RLyXb8lq1y7Z-Kx74N_Au9B8Igc6MiuBwc49FRVcabUPjM_Nkk5wCKS80XpEn2mC7MFv3Fr4OwwpK", "https://replicate.com/codeslake/ifan-defocus-deblur", "Aborda el desafío de la restauración y mejora de imágenes desenfocadas. Su enfoque innovador permite manejar el desenfoque espacialmente variable y de gran tamaño. IFAN predice filtros de desenfoque a nivel de píxel, que se aplican a las características desenfocadas de una imagen de entrada para generar características nítidas. Es especialmente útil para fotógrafos, diseñadores y creadores de contenido que desean mejorar la calidad visual de sus imágenes./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("NafNet IA","image","https://blogger.googleusercontent.com/img/a/AVvXsEhSkIN6UZNOdB9MEaAPyEqvsc0UDn4FwiKRq5kiGyIEVHgox2jIV22eLlX4KBrquZpMUYteD1uFo8yD9r9vYTGqDuTWZkQ5koKluZq653cbSj-TRukRnrllSLcjlMYTFDzPLbwcHDemtru6pnqfnRR-HEy8OnjRlN4XAGuBBiRb4pqSyskVSOvYRdlX", "https://replicate.com/megvii-research/nafnet", "Aborda el desafío de la restauración y mejora de imágenes desenfocadas. Su enfoque innovador permite manejar el desenfoque espacialmente variable y de gran tamaño. NAFNet predice filtros de desenfoque a nivel de píxel, que se aplican a las características desenfocadas de una imagen de entrada para generar características nítidas. Es especialmente útil para fotógrafos, diseñadores y creadores de contenido que desean mejorar la calidad visual de sus imágenes./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://youtu.be/ijFPxRUQKMQ"),'
            '("BigColor IA","image","https://blogger.googleusercontent.com/img/a/AVvXsEg6w8Xxfrc05kAeKhVDHaa-uuDcoR6hywKP1h_2tU-Yk1Tz09bXUMMyUEUMd4tSquHl6g0310jrSLcoRrTzIQTHVr7vDrYd6G3eOkobFO66PugB5NBZBhAkSIJHxl94UZdkPVnOgFUZb_U_TBMW9RTDt6IQBWgMT_2zh85GNFqJtJNo22MCcc0VedhR", "https://replicate.com/cjwbw/bigcolor", "Aborda el desafío de la restauración y mejora de imágenes desenfocadas. Su enfoque innovador permite manejar el desenfoque espacialmente variable y de gran tamaño. BigColor predice filtros de desenfoque a nivel de píxel, que se aplican a las características desenfocadas de una imagen de entrada para generar características nítidas. Es especialmente útil para fotógrafos, diseñadores y creadores de contenido que desean mejorar la calidad visual de sus imágenes./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://www.youtube.com/watch?v=TEJIzVrO9xE"),'
            '("Colab CodeFormer Image IA","image","https://blogger.googleusercontent.com/img/a/AVvXsEgwHQ4av4O3IYI_Pn-rY6vDr-LFEeejXb9TIlIk6RUDJXDcVZ8B26tUdxWlwQDT6UzYO3f_7Q4umZN6I-bki69NiqNTbe5lKNlkx2kYZ3ve8mfWafEn-F0ojeb-bjdLmKzvzb9X5b9LnZ1VZkoA489wPjl6mjOY2zH_7FlQoIPLTnYJXto8uIwbvRuk", "https://colab.research.google.com/drive/1qhkSMVMDQa_IgnBOAuQzEkJCNke_6u5v?usp=drive_link", "Para colab. Especializada en la restauración y mejora de imágenes desenfocadas, también puede utilizarse desde Google Colab. El equipo de TICnoticos ha desarrollado el código necesario para implementar esta funcionalidad en Colab, lo que facilita su acceso y uso para la comunidad. Si deseas mejorar la calidad visual de tus fotos desenfocadas, CodeFormer en Google Colab es una excelente opción para explorar y experimentar con esta tecnología ./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://youtu.be/GDnfPeFkC6U"),'
            '("SwinIr IA","image","https://blogger.googleusercontent.com/img/a/AVvXsEhjOCUnWaySBho-JE4KOoWROlhSZI8uI_6yP6260p1P5jsw36EB2OgatTUnNk9HOUQev_44Kl2b67azMZxNGcX_OT-A6xaxqzxnhgjOSndTAZVpVBIwpCHjTs0ntHoM0KVD3zTr9job6G4BU98rsSCve6Oxg9iZiSfjwpn49rwatwbLN3sxPt7JF48Z","https://replicate.com/jingyunliang/swinir", "Especializada en la restauración y mejora de imágenes desenfocadas. Su enfoque innovador permite manejar el desenfoque espacialmente variable y de gran tamaño. Al predecir filtros de desenfoque a nivel de píxel, SwinIR transforma imágenes borrosas en imágenes nítidas, lo que resulta especialmente útil para fotógrafos, diseñadores y creadores de contenido. /n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://youtu.be/XI_taul2wcs"),'
            '("Inombre ia1","image","image.jpg","weburl", "/n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("Inombre ia2","image","image.jpg","weburl", "/n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            //
            '("nombre ia1","video","urlimage", "urlweb", "/n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("nombre ia2","video","urlimage", "urlweb", "/n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("Colab CodeFormer Video ia","video","urlimage", "urlweb", "/n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            //
            '("nombre ia3","text","urlimage", "urlweb", "/n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("nombre ia4","text","urlimage", "urlweb", "/n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("nombre ia5","text","urlimage", "urlweb", "/n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            //
            '("nombre ia6","audio","urlimage", "urlweb", "/n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("nombre ia7","audio","urlimage", "urlweb", "/n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("nombre ia8","audio","urlimage", "urlweb", "/n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            //
            '("PimEyes","other","https://blogger.googleusercontent.com/img/a/AVvXsEg-ckzVyJUaEHpKMYgPhb6mFE7qiuhLkiC3_aRzaMs_WXDgBBBqklew06G_JOrwUKd9OgC5bWZcmjkVcraXGWTWvgb3rnuRdjDhBKwHrIC2XEgJELeyeHfqKdq5BC2iYc6KV6pRXBjnZ04UMD9i130jpGq5-zjgXir81cekfZRcgjs0px8OR_jR_CMl", "https://pimeyes.com/en", "PimEyes es un motor de búsqueda en línea que recorre Internet para encontrar imágenes que contengan rostros dados. Utiliza tecnologías de búsqueda por reconocimiento facial para realizar una búsqueda inversa de imágenes. Al subir una foto, puedes descubrir dónde se publican tus imágenes, proteger tu privacidad y reclamar derechos de imagen. Es una herramienta valiosa para fotógrafos, diseñadores y creadores de contenido que desean mejorar la calidad visual de sus fotos desenfocadas/n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://youtu.be/3sSa8Rv5Mbo"),'
            '("nombre ia9","other","urlimage", "urlweb", "/n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("nombre ia99","other","urlimage", "urlweb", "/n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"'
            ');';
        await database.execute(addIA);
      },
      version: 1,
    );
  }

  Future<List<IA>> getIAByCategory(String? category) async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.rawQuery(
        'SELECT * FROM access_ia WHERE category LIKE ?', ['%$category%']);
    return queryResult.map((e) => IA.fromMap(e)).toList();
  }

  /* 
    //PARA IMPLEMENTAR EL METODO getIAsByCategory()
    List<IA> IADeArtes = await getIAsByCategory('Artes');
    List<IA> IADeCocina = await getIAsByCategory('Cocina y alimentos');
    List<IA> IAAgropecuarios = await getIAsByCategory('Agropecuario'); 
  
  */

  Future<IA?> getRandomIa(String category) async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.rawQuery(
        'SELECT * FROM access_ia WHERE category like ?', ['%$category%']);

    if (queryResult.isEmpty) {
      return null;
    }

    final int randomIndex = Random().nextInt(queryResult.length);
    return IA.fromMap(queryResult[randomIndex]);
  }

  Future<int> getTotalIasInCategory(String category) async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM access_ia WHERE category like ?',
        ['%$category%']);

    return queryResult[0]['count'] ?? 0;
  }

  //CRUD IA's Favorite:

  Future<void> addIAtoFavorites(String nameIa) async {
    final db = await initializeDB();
    await db.insert(
      'favorite_ias',
      {'ia_name': nameIa},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<IA>> getFavoriteIAs() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.rawQuery(
      'SELECT * FROM access_ia WHERE ia_name IN (SELECT ia_name FROM favorite_ias)',
    );
    return queryResult.map((e) => IA.fromMap(e)).toList();
  }

  Future<void> removeIAFromFavorites(String nameIa) async {
    final db = await initializeDB();
    await db.delete(
      'favorite_ias',
      where: 'ia_name = ?',
      whereArgs: [nameIa],
    );
  }

  Future<void> deleteOldDatabases() async {
    for (int i = 1; i < 2; i++) {
      String dbName = 'ias_$i.db';
      await deleteDatabase(dbName);
    }
  }
}
