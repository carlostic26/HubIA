import 'package:hubia/screens/screens_barril.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:math';

class DatabaseHandlerIA {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'ias_16.db'),
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
        //tecogan

        // audio ---

        // texto ---

        //images
        // dragGan colab
        // SwinIr online

        const String addIA = ''
            'INSERT INTO access_ia(name, category, imageUrl, webUrl, description, tutorialUrl) VALUES '
            //'("nombre ia9","other","urlimage", "urlweb", "/n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            //
            //
            '("ClipDrop Image Uncrop IA","image","https://blogger.googleusercontent.com/img/a/AVvXsEgnkzUQCHuBFNO3rR75Gyyt81FvcRNQs-ca1AAWUWajvmNuwPX6xnxEQltI5LkxmrD6QYS1VK4PVN8r2l4GRfSS7KyQHrdT8OlhogSffikOyK5WfHO9HU4vxM93JhFN7gVWnHK2NngSJMnug3s4Q2Fqmo4nJ0YWP4hmATIBWXrq1la-Z7Uxg9ROnz8Q", "https://clipdrop.co/uncrop", "Es una herramienta optimizada para editar la relación de aspecto de imágenes. Está basada en un modelo fundamental creado por Stability AI. Los usuarios pueden cargar imágenes y seleccionar una nueva relación de aspecto. La herramienta generará la imagen con la nueva proporción, permitiéndote ajustar las dimensiones y expandir el lienzo visual. Si tienes una imagen recortada o imperfecta, Uncrop utiliza tecnología de outpainting para reconstruir y extender la imagen, como si fuera mágico./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://youtu.be/V9Ucyq8c00Y"),'
            '("DragGan-Inversion IA","image","https://blogger.googleusercontent.com/img/a/AVvXsEgabiP35k863OlOZ_iVLVlAmDLNRLIHd_TEBLeqOilcfnTEERKlQuvdyeN8uIN5bIfagDRISCV2jsV16ulWdgxGnoyUnR1memgY7C-brXjD-6d502hs2SmKYLrApS0R_U1yxf4jVPX7gbqccQseLWw3a2zOFMDGQ-ksHGA1bdSGvAkU1fY7XGos-ENB", "https://huggingface.co/spaces/Amrrs/DragGan-Inversion", "Te  permite manipular imágenes generadas por redes generativas antagónicas (GAN). Al aplicar la inversión GAN a una imagen real y mapearla de nuevo al espacio latente de StyleGAN, DragGan te empodera con capacidades avanzadas de manipulación de imágenes. Puedes ajustar la pose, el cabello, la forma y la expresión de las imágenes, lo que resulta especialmente útil para fotógrafos, diseñadores y creadores de contenido. Además, su enfoque en la interactividad y la precisión lo convierte en una herramienta valiosa para explorar y experimentar con tus imágenes./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://www.youtube.com/watch?v=zTqtZl8ALJ8"),'
            '("CodeFormer Image IA Online","image","https://blogger.googleusercontent.com/img/a/AVvXsEhOpT_OmxLhZioODImkOWI8C-TG7FrGZg8Dp79kYHi1U6Q4wetN_iPPymGrKijdaAm2emPRmc_4Ah-R2D218hMLHXQP94qTT8xqEvZAAUpQbu2y0uzUrmN0al0BZgZVtJV-b0T-xa_nljQ99v0EEzlMvSwGpWjPYcQaR3IreBYdU_bgdz3vm4k_uD2d", "https://huggingface.co/spaces/sczhou/CodeFormer", "Restaura y mejora características faciales en imágenes. Su utilidad radica en recuperar detalles sutiles y mejorar la calidad visual de fotos, especialmente útil para fotógrafos, diseñadores y creadores de contenido ./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://www.youtube.com/watch?v=2H6T6H9aFaM"),'
            '("PimEyes","image","https://blogger.googleusercontent.com/img/a/AVvXsEg-ckzVyJUaEHpKMYgPhb6mFE7qiuhLkiC3_aRzaMs_WXDgBBBqklew06G_JOrwUKd9OgC5bWZcmjkVcraXGWTWvgb3rnuRdjDhBKwHrIC2XEgJELeyeHfqKdq5BC2iYc6KV6pRXBjnZ04UMD9i130jpGq5-zjgXir81cekfZRcgjs0px8OR_jR_CMl", "https://pimeyes.com/en", "Es un motor de búsqueda en línea que recorre Internet para encontrar imágenes que contengan rostros dados. Utiliza tecnologías de búsqueda por reconocimiento facial para realizar una búsqueda inversa de imágenes. Al subir una foto, puedes descubrir dónde se publican tus imágenes, proteger tu privacidad y reclamar derechos de imagen. Es una herramienta valiosa para fotógrafos, diseñadores y creadores de contenido que desean mejorar la calidad visual de sus fotos desenfocadas/n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://youtu.be/3sSa8Rv5Mbo"),'
            '("IllusionDiffusion IA","image","https://blogger.googleusercontent.com/img/a/AVvXsEgBT2-D8Q-2p2B1w5mZjwTwMp5OtJLKb4g-cML9GAYBHZ1QXP5HIGnYenOrrRiJonueoFrKknHxdeYnbxejAA5Kf7v4G8L7j-pk4Y7MD5wq4RxlE_KIFTapi_DSWHfBqSUUtgGHHphUB78ph4TaSRl7-VKqpYY3eQbRgangJd6AaduT1kj-AvqLyFLU", "https://huggingface.co/spaces/AP123/IllusionDiffusion", "Permite a los usuarios explorar una colección impresionante de aplicaciones de ML desarrolladas por la comunidad. En particular, IllusionDiffusion se destaca al transformar imágenes en ilusiones ópticas, brindando una nueva vida a las obras digitales y ofreciendo una experiencia creativa única./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://youtu.be/ksrRmDU6KVc"),'
            '("ifan-defocus-deblur IA","image","https://blogger.googleusercontent.com/img/a/AVvXsEhbulHI9XYP6mD8Xs_SJzcmVNLlM2hhm1bnunK4Pifyx_KgbDUcrBc0-wfLNokGmYtiYazN4kB8s6-1_vYSrFGQ8HG3lg-J6oxYWsxVFISg0L2RLyXb8lq1y7Z-Kx74N_Au9B8Igc6MiuBwc49FRVcabUPjM_Nkk5wCKS80XpEn2mC7MFv3Fr4OwwpK", "https://replicate.com/codeslake/ifan-defocus-deblur", "Aborda el desafío de la restauración y mejora de imágenes desenfocadas. Su enfoque innovador permite manejar el desenfoque espacialmente variable y de gran tamaño. IFAN predice filtros de desenfoque a nivel de píxel, que se aplican a las características desenfocadas de una imagen de entrada para generar características nítidas. Es especialmente útil para fotógrafos, diseñadores y creadores de contenido que desean mejorar la calidad visual de sus imágenes./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://youtu.be/Ed_VNV-X3-E"),'
            '("NafNet IA","image","https://blogger.googleusercontent.com/img/a/AVvXsEhSkIN6UZNOdB9MEaAPyEqvsc0UDn4FwiKRq5kiGyIEVHgox2jIV22eLlX4KBrquZpMUYteD1uFo8yD9r9vYTGqDuTWZkQ5koKluZq653cbSj-TRukRnrllSLcjlMYTFDzPLbwcHDemtru6pnqfnRR-HEy8OnjRlN4XAGuBBiRb4pqSyskVSOvYRdlX", "https://replicate.com/megvii-research/nafnet", "Aborda el desafío de la restauración y mejora de imágenes desenfocadas. Su enfoque innovador permite manejar el desenfoque espacialmente variable y de gran tamaño. NAFNet predice filtros de desenfoque a nivel de píxel, que se aplican a las características desenfocadas de una imagen de entrada para generar características nítidas. Es especialmente útil para fotógrafos, diseñadores y creadores de contenido que desean mejorar la calidad visual de sus imágenes./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://youtu.be/ijFPxRUQKMQ"),'
            '("BigColor IA","image","https://blogger.googleusercontent.com/img/a/AVvXsEg6w8Xxfrc05kAeKhVDHaa-uuDcoR6hywKP1h_2tU-Yk1Tz09bXUMMyUEUMd4tSquHl6g0310jrSLcoRrTzIQTHVr7vDrYd6G3eOkobFO66PugB5NBZBhAkSIJHxl94UZdkPVnOgFUZb_U_TBMW9RTDt6IQBWgMT_2zh85GNFqJtJNo22MCcc0VedhR", "https://replicate.com/cjwbw/bigcolor", "Aborda el desafío de la restauración y mejora de imágenes desenfocadas. Su enfoque innovador permite manejar el desenfoque espacialmente variable y de gran tamaño. BigColor predice filtros de desenfoque a nivel de píxel, que se aplican a las características desenfocadas de una imagen de entrada para generar características nítidas. Es especialmente útil para fotógrafos, diseñadores y creadores de contenido que desean mejorar la calidad visual de sus imágenes./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://www.youtube.com/watch?v=TEJIzVrO9xE"),'
            '("Colab CodeFormer Image IA","image","https://blogger.googleusercontent.com/img/a/AVvXsEgwHQ4av4O3IYI_Pn-rY6vDr-LFEeejXb9TIlIk6RUDJXDcVZ8B26tUdxWlwQDT6UzYO3f_7Q4umZN6I-bki69NiqNTbe5lKNlkx2kYZ3ve8mfWafEn-F0ojeb-bjdLmKzvzb9X5b9LnZ1VZkoA489wPjl6mjOY2zH_7FlQoIPLTnYJXto8uIwbvRuk", "https://colab.research.google.com/drive/1qhkSMVMDQa_IgnBOAuQzEkJCNke_6u5v?usp=drive_link", "Para colab. Especializada en la restauración y mejora de imágenes desenfocadas, también puede utilizarse desde Google Colab. El equipo de TICnoticos ha desarrollado el código necesario para implementar esta funcionalidad en Colab, lo que facilita su acceso y uso para la comunidad. Si deseas mejorar la calidad visual de tus fotos desenfocadas, CodeFormer en Google Colab es una excelente opción para explorar y experimentar con esta tecnología ./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://youtu.be/GDnfPeFkC6U"),'
            '("SwinIr IA","image","https://blogger.googleusercontent.com/img/a/AVvXsEhjOCUnWaySBho-JE4KOoWROlhSZI8uI_6yP6260p1P5jsw36EB2OgatTUnNk9HOUQev_44Kl2b67azMZxNGcX_OT-A6xaxqzxnhgjOSndTAZVpVBIwpCHjTs0ntHoM0KVD3zTr9job6G4BU98rsSCve6Oxg9iZiSfjwpn49rwatwbLN3sxPt7JF48Z","https://replicate.com/jingyunliang/swinir", "Especializada en la restauración y mejora de imágenes desenfocadas. Su enfoque innovador permite manejar el desenfoque espacialmente variable y de gran tamaño. Al predecir filtros de desenfoque a nivel de píxel, SwinIR transforma imágenes borrosas en imágenes nítidas, lo que resulta especialmente útil para fotógrafos, diseñadores y creadores de contenido. /n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://youtu.be/XI_taul2wcs"),'
            '("Krea AI","image","https://blogger.googleusercontent.com/img/a/AVvXsEhKVj3m94Z9WimjGrbmW8tRsZM1qqaLPu8tkjClWYJ2VkhI7ateLvUAXTgpOtxO_CLzQL0CL2zRZPKHTye9ZK_HPAhEEecy2UWUD-UA1ucR_o7l5t400hNcgGUU-i_UJXvufX4fa8sj2Y_95XmQ3snSBQBhQ7GgCIRgpE0uh4HCqpC-pdRuFeZEHQ7w=w945-h600-p-k-no-nu","https://www.krea.ai/apps/image/enhancer", "permite generar imágenes en tiempo real. A través de esta plataforma, puedes experimentar con la creación de imágenes utilizando técnicas de IA generativa./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("Remini","image","https://blogger.googleusercontent.com/img/a/AVvXsEhbYiFfE7bXTmTY8CzvXpBnvsPjVJRcDGQx4yleyb1w6Ud_dMaX8yec8-FwJkO_-3vZbyAthrvwDiEz7yax4q3fMivCJT4nXpyJ2FPGH318LUpdCZ6Y60EfkCR1CjsVPjLZgifxGeW7Td4l5t-ObujTmExRRF_FwtxFsm1Cc380JS5yKN1GDfY7B_lW=w945-h600-p-k-no-nu","https://app.remini.ai/", "Esta IA mejora fotos y videos. Utiliza técnicas avanzadas para eliminar el desenfoque, restaurar fotos antiguas, reducir el ruido, mejorar rostros, corregir colores y ampliar imágenes. /n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://youtu.be/uk4Vo8FYPFQ"),'
            '("HotPot","image","https://blogger.googleusercontent.com/img/a/AVvXsEizkgChUMk-F-rdpMaXypEps5oaWb-swIENWWi4UukXUcIXukH4IpyE_HUis9GFEWgLO_8F18wRLwyeBlhCf8w8lE-FszBUwJ8fqtShr9u_EghNtt1cGaUuPttY4ofc0FsG5ePBFTaSuzmsHqZpnvdm4k3IiCwXjIpJa_1KlM4Qn9yH6xvQLzuYouSa", "https://hotpot.ai/", "Generador de imágenes, edición de fotos con IA, y creación de gráficos para redes sociales, marketing. Puedes visualizar ideas con el generador de imágenes, reimaginar tu apariencia con retratos generados por IA, y automatizar tareas con herramientas de edición de fotos./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("MyHeritage","image","https://blogger.googleusercontent.com/img/a/AVvXsEirl8zrcvqrazwmrTAQ6gHTmofAQgCPjTZowrCkxXPmvEHZjZ3iGUfXwgzT8x1dirJyU0SVS22kEHxf02RrVAPMXFmI8LLOVFOy7b9aNqeKqUxFSIZNs0kd63FfI5HgbwggZ3ZWjwbgFTRVT89Gl_6_XD5tN4hZ1m3zLZ8VuPGCZtUviWa6UoSSW8J5", "https://www.myheritage.es/ai-time-machine", "Utiliza la Inteligencia Artificial (IA) para ofrecer características innovadoras en el campo de la genealogía y la historia familiar. Una de sus funciones destacadas es la “AI Time Machine”, que crea avatares de IA de una persona tal como pudo haber sido en diferentes períodos de la historia. Puedes subir tus fotos y verte a ti mismo como un faraón egipcio, un caballero medieval, un astronauta y más. Además, MyHeritage ofrece “AI Record Finder” y “AI Biographer”, que transforman la genealogía utilizando la IA para buscar registros históricos y generar biografías de IA. Estas herramientas pueden ser útiles para explorar y entender mejor tu historia familiar./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("Pfpmaker","image","https://blogger.googleusercontent.com/img/a/AVvXsEi3BB7mjf3VVOfa_coj9PBEVUJ2pmIqodvdn-VA9MWhbQYjG1nQAkIs5STWqox6RYlRh2TGJkR65flZJKQXMgB05y3m5zKMhcYh8GW-biS8iSCx7oMcGd38-1NGB1WoVafPbD6s-y1y0n9gndDrCCOK2j2KNenqs8PqD2fvsAAhYlwMx008--qPg5Ge", "https://pfpmaker.com/", "Ofrece un generador gratuito de imágenes de perfil. Puedes subir tus fotos y la IA generará cientos de imágenes de perfil profesionales para mostrar tu mejor versión en línea. Ofrece estilos de retratos de negocios para LinkedIn, CVs y currículums, o estilos creativos para Instagram y mensajería. Además, puedes personalizar cada detalle de tu imagen de perfil con una amplia selección de herramientas, experimentando con IA, filtros, fondos y plantillas para encontrar tu aspecto ideal. No se menciona explícitamente si es necesario registrarse para usar estas herramientas./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("DeepImage","image","https://blogger.googleusercontent.com/img/a/AVvXsEg-2bAlC2vmKndJ4ADbtzZYv_tpY402ykizWiJXM-8AMfzGQGdLsPVUdM6rGLSDwnq3IrFVjIel3QWQdcgZVrv9vCyAXgmxXIkXyyDBbCM3g-_qpjUxprMCu_dZiuK8jJ_OxKxeS6njBLQ1THjccWOCtOpSM2ZVQI8Atbv9wJxRa_JrcuisjnRA9kdv", "https://deep-image.ai/", "Ofrece una serie de herramientas para mejorar y ampliar imágenes. Puedes aumentar la resolución de las imágenes hasta 300 megapíxeles, eliminar artefactos, corregir colores y luz, eliminar el fondo y más. Además, ofrece la posibilidad de generar fondos para fotos de productos para comercio electrónico, marketing y propósitos promocionales. Deep-image.ai utiliza algoritmos de aprendizaje profundo para procesar, analizar y entender las imágenes/n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("BigJpg","image","https://blogger.googleusercontent.com/img/a/AVvXsEhpVBNlLHX5eVhfiyXyf7J9Behu1Qf4QtbveqL6czmOsiRVyxbhbt7KAC4rVbSbVlMr0fC-tHI8Nog9xuyfFoqaXxaH2wnxlb3jtmo5xIhUqh7O9vUEeeYCUvbIAljdHfLLh7OPOgJnbdSYg_CmS1Eqete9bo4RVRvrYrtjHkjensoHfhWIQUHhORj-", "https://bigjpg.com/", "Ofrece una herramienta para ampliar imágenes sin pérdida de calidad. Utiliza las últimas redes neuronales convolucionales profundas para reducir de forma inteligente el ruido y la dentadura en las imágenes, permitiendo que las imágenes se amplíen sin perder calidad. Actualmente, los usuarios gratuitos pueden ampliar imágenes hasta 3000x3000px, 5M; los usuarios de pago pueden ampliar imágenes hasta 50M1. Las imágenes subidas y ampliadas se borrarán automáticamente después de 5 días./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            //
            //
            '("GFP-GAN Colab","video","https://blogger.googleusercontent.com/img/a/AVvXsEjiOtuJO417ZjXifmI3BqEKoxlxLe0BTKyGVUxwTwseQqFvtQZdl54Ig5NQfhBHmE_mAajp2U1zS5nvOhlo1C3oG4DV2TuJ7ym3V5bDK0HCvwsIXcs98fPk_KqkKUIVPUNFmFEngvppEtAbgfEKD2g6HlyY4jwfhA5MPbmtQCVHmwEkXXs2ArPwZj2t", "https://colab.research.google.com/drive/1Z6RINOM-wTmXcWuHatgPpJ5nVg39bZkr?usp=sharing", "Es un proyecto que se puede usar desde Google Colab, que se enfoca en restaurar rostros en el mundo real. Utiliza una red generativa adversarial (GAN) previamente entrenada (como StyleGAN2) para llevar a cabo la restauración facial sin necesidad de información específica sobre la imagen original. \n\nTicnoticos ha desarrollado un cuaderno en Colab que permite a cualquier persona probar GFPGAN, una inteligencia artificial para restaurar rostros en imágenes y videos. Este cuaderno es de acceso gratuito y ofrece una forma sencilla de experimentar con esta tecnología de mejora facial./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://youtu.be/1dqn2_qCR9Y"),'
            '("GFP-GAN 2 Colab","video","https://blogger.googleusercontent.com/img/a/AVvXsEjb2pHYToI-ZV1covB_Jvb0jsG1StOeiOSc5845nHCzgXvCgRD4l9v4ykj-8prT4g1Zj3GXngV5-r7mmTxow2tR6JhSNgDUZcE1emT1A_pBj4kceyN3z2OMaD5HIxuP-9EtrJ2k7Kqee_qOqaCo1E4g0EYabWhJjZF4rkJt09nGkjrMvdr2_oUoyVvB", "https://colab.research.google.com/drive/1T9ia0rP3lWy2m4tTlHHYLCULvLqZC9If?usp=sharing", "Funciona mediante proyecto en Colab online. Utiliza una red generativa adversarial (GAN), como StyleGAN2, para llevar a cabo la restauración facial sin necesidad de información específica sobre la imagen original. GFPGAN es una herramienta poderosa para mejorar la calidad de las imágenes faciales en videos y fotografías./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://youtu.be/AWR50OalMB0"),'
            '("CodeFormer Colab","video","https://blogger.googleusercontent.com/img/a/AVvXsEgaJz89rhwDv_mwnmS85ukwaQZAEggu5oca_RgHPnJA1pxMvvqJkTfdVN2C4jxluolvneA3Rt0QdbpiLsgPi4hovrrapwvDdfDVlU2t0cjk_PWtJ-UkoKyC43scvmgVJnXxSxRuoZJglIcwbwHD-g-D8qQXf2G1g9YFY87S9yYjHbc-J48hcrgn-l3b", "https://colab.research.google.com/drive/1yAMhqxgnp5PLkIuJdYXlYFo90rEAcge0?usp=sharing", "Es un algoritmo robusto de restauración facial diseñado para trabajar con fotos antiguas y rostros generados por IA. Funciona como un modelo Image-to-Image, mejorando la calidad de las imágenes y restaurando detalles en los rostros. Puedes ejecutarlo en Colab para mejorar videos, fotograma por fotograma, y obtener resultados de alta calidad./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://youtu.be/uil_vwAhs1M"),'
            '("FPS RIFE Colab","video","https://blogger.googleusercontent.com/img/a/AVvXsEgYEj6nzS4XkjqvMkFZ6PU9BFo58C2UjSJHb4rRK7Tc1bOxQkEikAnp1b0QIAK8kBwSPBbfugXTdQYr8Pb6TbnHeOswJwhn9neCUcH8FZZvzwHUeV1k0cxCCXuyIIS5X80WMcufueZMI7X8WlCiD33_lcySeKWnVYpOz2xOb4g0fc5-yxM3ApWzWyvk","https://colab.research.google.com/drive/1a6NnAN_sPBiFMp3HEZgknRbQAulkohkc", "Es una técnica que crea fotogramas adicionales entre los fotogramas originales de un video. Esto mejora la fluidez y la calidad visual de los videos, especialmente cuando se convierten a cámara lenta. Puedes probarlo en un cuaderno interactivo alojado en Google Colab que te permite aprovechar el poder del algoritmo RIFE para interpolación de fotogramas en videos. RIFE (Real-Time Intermediate Flow Estimation)./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://youtu.be/crwLKp_yW6U"),'
            '("FPS RIFE 2","video","https://blogger.googleusercontent.com/img/a/AVvXsEif8rPGNAHePqrpOSg6b_O6srfZ0r1aWsRp4dx4_qqi0pSz-GopeMwXYMDU1Y1nP7mwEtZxflqrRP9vvERB153cNBNhm4-lo-o18XhsTwqakHCNRh6V15GqXlZ9gOvx22LZp5rpk_mTCtkIhDRtMyYfRtSHtiq_yjjHdZErwMtyJzaDxDcJXMkvJc_W","https://colab.research.google.com/drive/1-Cxa_p8oTiflduqOJMCzSpOLxGzIGhTF", "Puedes cargar tus videos en Colab, configurar los parámetros de interpolación (como el factor de interpolación) y ejecutar el cuaderno. RIFE generará los fotogramas interpolados para ti. FPS RIFE Colab es una herramienta útil para mejorar la calidad de tus videos, ya sea para crear cámara lenta suave o simplemente para mejorar la apariencia visual./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://youtu.be/hXPyOllEIhc"),'
            '("Synthesia","video","https://blogger.googleusercontent.com/img/a/AVvXsEiFU4ODpzVDPOrxs-rAEI6m3uRNDjy65CS2jyNKI3gcfcvY6j7YLIRLRwCO_edNlDAjhOvp8dCWsui3ofTUZaOK9VBD7T_b5EkWinzAknD--_n4JASomwODBRBA-54zxvlkBtTI3mKdIm9bgBHUVsxDXdU-pGsCZHC0j1u5jmbj6FlWnl2Ugml3RRxR", "https://www.synthesia.io/free-ai-video-demo", "Esta herramienta te permite crear vídeos generados por IA en 120 idiomas diferentes. Es útil para producir contenido audiovisual de manera rápida y sencilla./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("PixVerse","video","https://blogger.googleusercontent.com/img/a/AVvXsEhSVD8teWxm5tH5-sOmpwf9zyE72aSQGohNzgXrhcHZG-3UH5hTwzR2euaJMHg3zXp7kPbxB3WYyiL3J0pk7I22htp_9EDsJFlo6dBsm7O6Off4swxWBI7NqfT6Y-0FyV5y3g2qVOdiUA6jcd37tEkioX632y9Yu7ttkdtv2c_P3dKD--EvrUBA5pVH", "https://app.pixverse.ai/creative/list", "Creación de videos impulsada por inteligencia artificial. Permite generar impresionantes videos a partir de indicaciones de texto. Actualmente, la herramienta utiliza su propia interfaz web. Después de registrarte en la plataforma, puedes ir a la sección de generación y usar la opción de crear para generar tus clips. Al crear tu indicación de video, también puedes seleccionar el estilo del video entre realista y anime, así como otros ajustes como la relación de aspecto y la indicación negativa (si es necesario)./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            //
            //
            '("Copy.ai","text","https://blogger.googleusercontent.com/img/a/AVvXsEgSYTnEwCS3izvhBSamwumhLN8Ie42lag24en-ST0M6dacYIBF6noxL_Oe4Ppohzp2vjtZK_jLmNsX22DLUGIy_J9d1VpzgC1PNeHVh-BhIvaxo7s3FMtbxeF3nOqTRQoecAvkvBr5ixMQkVHqN2_pCrVIToR9Nf7C3saRwQVLpcsEweGDAf4RQyYX4", "https://www.copy.ai/tools", "Es una plataforma innovadora que utiliza inteligencia artificial para impulsar la creación de contenido. Con una red neuronal avanzada, la plataforma aprende de ejemplos de texto de alta calidad y patrones, resultando en algoritmos capaces de generar textos atractivos y altamente efectivos1. Ofrece una variedad de herramientas de escritura de IA que facilitan la creación de contenido para diferentes plataformas y propósitos. Ya sea que necesites un pie de foto para Instagram, un correo de marketing, una descripción de producto, una entrada de blog o un texto de ventas, puedes utilizar las generadoras de escritura de IA gratuitas de Copy.ai para obtener resultados en segundos./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("Copilot","text","https://blogger.googleusercontent.com/img/a/AVvXsEhJqTfkZe4Nzi8CX-KSUdwDVQ_u9HcpN6wICd8-ZMMuj84O3gM9rOlfO-B_tABzcg1RUjYRTsSpuQs3Lk9gK91BO9tjKiiwwnxPgJAvAc-JHJni57BWfBrF06Mg1gbl9s3kBX67zB7GhJDHURbQGGRJzmtKELFQAUiV2OYeoc8Qwqt9YQ6TO5efWiM9", "https://copilot.microsoft.com/", "Es un asistente de inteligencia artificial (IA) que ofrece soluciones innovadoras en la nube de Microsoft. Su objetivo es mejorar la productividad, creatividad y accesibilidad de datos mientras garantiza características de seguridad y privacidad empresarial. Puedes experimentar Microsoft Copilot en Microsoft Edge o Chrome en Windows y Mac OS. /n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("ChatGPT","text","https://blogger.googleusercontent.com/img/a/AVvXsEjNjrA5VZo22spD589VxGv0JsmO6sl6BUFtRSBuSg_BIVL6F1mhvDbOZGoNxxAnKXVGutR1EUXwj6qBzLpeAmAOpkRmRdx-9w8FNnDruEp0IjMZYIoLrUi-wA4kei_sFhKvyWdK0ZP85boJUh9EgeUmI_pQUIBbuovhdQFtZK_FklWQ1z7cRx5jmcy-", "https://chat.openai.com/", "Desarrollado por OpenAI, es un sistema de chat basado en el modelo de lenguaje GPT-3.5. Con más de 175 millones de parámetros, es capaz de realizar tareas relacionadas con el lenguaje, como traducción y generación de texto. Puedes interactuar con él en formato de conversación vía texto y aprovechar sus capacidades de respuesta basadas en contexto y conversaciones previas. /n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://youtu.be/5e_u0mbecQ4"),'
            '("Gemini (Bard)","text","https://blogger.googleusercontent.com/img/a/AVvXsEhII2Pi43r0IFWCJwEeXf0nyFoJnYWR1fw3jZVyHNe8pJ0zxTTN1dqPN01S3FbGGE2XzHwKqwIMmcxFc41MGCEqk7kJ3a4GOiL4J-T1IWGD8UI-sXwVB4qBDnxi6f09UvGI8zXq8zhGufd-fgmVmNui8tXf1WV3C7L7wKLTFkT_mrcDbfYymCQ6lPTq", "https://gemini.google.com/app", "Anteriormente conocido como Bard, es una plataforma impulsada por inteligencia artificial (IA) de Google. Ofrece herramientas para escritura, planificación, aprendizaje y másGemini Pro y Gemini Ultra son sus modelos avanzados, diseñados para mejorar la experiencia de los usuarios en tareas creativas y productivas./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("Cleverbot","text","https://blogger.googleusercontent.com/img/a/AVvXsEh-smGbxMNZb67xU-dxDQ0a-aERJaVdNH3__kNb_gg4E4vqj42hg4tU6Rd2AGNmNuXJY89PuCYc7RC7N_cfX2IqhTEm2DnPuvjigGHCxIpv3-5as60z-Gd304X2rZ6WwjIVhVgyec_DP332XyAIA3MNT-rwyszEO9ZCv1MV0sEXVYUg-U7kO_7gt63N", "https://www.cleverbot.com/", "Es un sitio web y una aplicación que te permite chatear con una IA que afirma tener cierta inteligencia real. /n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("Akinator","text","https://blogger.googleusercontent.com/img/a/AVvXsEj807hn3oZu1p3riY1wKTJNOVyJijiyZsEhG5vCvwj_5ARsRLhSoL86g1xpR9aNlGYyc7rWGsbAs11lYBKWEE_lk8a5MAkkeGERZM_wwhMI50l6Ae2ZRaR4jTtl2r2vVCWqol_i7Aq9fEvErk_l3x1_2xeE_9W77pODJjHzQsxoQIvNBK_3tNFN04fa", "https://es.akinator.com/", "Es como un genio lector de mentes. Piensa en un personaje real o ficticio, responde algunas preguntas y Akinator intentará adivinar quién es. Es una forma divertida de interactuar con la IA./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("Namelix","text","https://blogger.googleusercontent.com/img/a/AVvXsEgVzC8Gi8ituahYOKj0MYLTe4W-Wr41r8eLhlOgdX9QCYKE_oCWzHTpb6wTW076ypgBqjrhhxUKaGxsQ8GGJXkzcPHszJBe8e9bAuBNRCZqvrpIPeJ0aiSdX997sWYyzmG2LhYrE_vWfSynmiF1_YkFOS-dw61FrgNd36G0T6ez6wCTBv3aCwHeTHqN", "https://namelix.com/", "Genera nombres de empresas cortos, pegadizos y de marca. Puedes filtrar los resultados por palabras clave, extensión de dominio y longitud, y guardar tus nombres favoritos para uso futuro. Namelix utiliza un potente modelo de lenguaje AI para generar nombres. Además de generar nombres, puedes explorar otras herramientas similares para la validación y construcción de sitios web./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("Notion","text","https://blogger.googleusercontent.com/img/a/AVvXsEgUrDDqFDubbicdD25Y509ig1nAxTPenK9eBCAMyTqmpH8xBFGDDdTwCf-jZX-y1spi0S-cu7Gqenxp1vGrxuV5m2KazbjQxusA-bnXAHeS2gLD_g7S7DvAZ5X2MwpeG3HsNGukrnlpndUiwMvdXDNPw7eQgLMO8jeCdY4Ne0-pQwJ_Inlgjci7_LLY", "https://www.notion.so/", "Herramienta de asistencia basada en inteligencia artificial que se integra en varios productos de Notion, como documentos y hojas de cálculo. Utiliza el mismo modelo de lenguaje GPT-3 que ChatGPT para automatizar tareas y proporcionar información./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("Grammarly","text","https://blogger.googleusercontent.com/img/a/AVvXsEjmOUhKbMWMACIR_TWGDggOz8wqDcPVRvSVsIalklm2YOooCSE-ddh8_HLReGREN-04r-gyp7htD9AIW30ZFx3nmxreKP23BKaPgJyfO8R2-lIdhcXYo2Uq4dppBQIKkADt6oLb0ElMH3DReodp27A8eVdZ-WXUKOlXM9sMqMvrdQXpxLBYUKKQMOVJ", "https://www.grammarly.com/", "Grammarly es una herramienta de asistencia de escritura basada en la nube que utiliza inteligencia artificial para mejorar la calidad de la escritura. Proporciona sugerencias en tiempo real para corregir errores de ortografía, gramática y puntuación, y mejora la claridad, el compromiso y la entrega en los textos en inglés. Detecta el plagio y sugiere reemplazos para los errores identificados. La herramienta es utilizada por más de 30 millones de personas y 70,000 equipos todos los días para mejorar la corrección, claridad, compromiso y entrega de su escritura./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            //
            //
            '("Adobe Podcast","audio","https://blogger.googleusercontent.com/img/a/AVvXsEjCVYS-OBzoQeTsseFScAhuI3wNcrYbFEzgjFG8e40Amz1_1FDdMI-Llfn_jR2PYRoabnEB1pe3bQygzjhLOEveOpRszH2Lbzf2jpOHGWWYiWeG0ljDE3GW2bQxKV3ZbgU3duVFG7T6i01ruc-O8LgqFlVoGIbm1MfGNN9DjQImogBnoySql9geMLUS", "https://podcast.adobe.com/enhance", "Es un producto de Adobe, de uso gratuito y online. Implementa diversas herramientas de IA para mejorar la calidad de tus grabaciones de voz y podcasts. Con funciones potenciadas por IA, puedes eliminar ruido y eco de las grabaciones, ajustar la configuración del micrófono y editar el audio como si fuera un documento de texto. Además, Adobe Podcast ofrece transcripciones precisas y música libre de regalías para tus producciones. Puedes acceder a esta herramienta en línea, lo que la hace conveniente y accesible para creadores de contenido en plataformas como Spotify, Apple Podcasts, YouTube o SoundCloud./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://youtu.be/PebfEH-eA7E"),'
            '("Moises AI","audio","https://blogger.googleusercontent.com/img/a/AVvXsEjTJNhnR2dU_jY_j54XPWQt_S_OzWcETteDkv5xMErhPyTW4J5evOC73XZHItCgv7rQusCtEr3fQJ588VxqIhWr_k58XSa8oieX3sUEXfIwocU-6xE13qQEQDazbDMYJOrwASXyOIWlsh4SaTZZqgwLGe82vJW9YIbNwzjfhrIrMgdf0qPgSMwySexw", "https://studio.moises.ai/", "Permite practicar, eliminar, aislar y ajustar cualquier canción utilizando inteligencia artificial (IA). Puedes tocar junto a tus artistas favoritos, modificar la velocidad, el tono y el metrónomo, y descubrir los acordes y las tonalidades en cualquier canción123. Además, Moises ofrece una experiencia completa para músicos, desde separar voces e instrumentos hasta personalizar tus pistas y remezclar canciones con la potencia de la IA. /n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "https://youtu.be/PebfEH-eA7E"),'
            '("Kits AI","audio","https://blogger.googleusercontent.com/img/a/AVvXsEj6OSkrF4de4tBEy6SRazkfrKu-kj3ZgJIXU9MQM1nJKQH2DLFLhh8ykn3wRIKb-0wVKwDJJUtWaq7GUFLvGflPRbeLyoX7Y5emnHKxoDyeMZclx7oXPWvis_Q_-hDyrZ19dYRVLEHvc0XS8kt7ZTOfV-OuuuxLn6gIkDhV_KTC3IrgABhG0c4ziX9j", "https://app.kits.ai/community-voices", "Es una plataforma de herramientas musicales con inteligencia artificial (IA). Ofrece funciones como voces perfectas en casa, clonación de voces y acceso a modelos de voz con licencia oficial. Ideal para músicos y productores que buscan mejorar su música utilizando la IA . /n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("Mubert","audio","https://blogger.googleusercontent.com/img/a/AVvXsEgqFIpLfVeefqDCPudw3_8UBS_SDIQG-jM5tqhtjA1Mx9X0tAQBhjdIBhKIyekgGOlbuzRsOh7q8qUsbqXZn-ieJJoUvmy7fdbeQD24Plg1wJFJCgpTSseZzuahAuxIjXdEQp0HVhh_mp5MO0Bwg7t_8Vhu2yz8GiDCbfufAPnj0iqEe-PyfePTFYKb", "https://mubert.com/render", "Es una plataforma avanzada impulsada por IA que permite a los usuarios acceder instantáneamente a música de alta calidad. Ofrece una extensa biblioteca de música generada por IA, revolucionando la forma en que se crea, comparte y experimenta la música en varias plataformas digitales./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("Lalal","audio","https://blogger.googleusercontent.com/img/a/AVvXsEh8JA-NLe8NE4MKtL8EEEjJe7EsJcV3ALyOgIfUpMQmXntDajVtTcHRgjj7JQBKpOeDzfvR3luA9i_v1z9Af5CZT-zqVUaiudT-McsGFyN0kwPl9LVEAB3tSHm3mRckHsZYibIgxUY9pFmfQ1R_5sObK2ZdTEZeZo7oNV6zIEqrmD8KU3raEQOlyvQa", "https://lalal.ai/", "Se especializa en la división de alta calidad de stems. Utiliza tecnología avanzada de IA para facilitar la separación de componentes de audio como voces, pistas instrumentales, baterías, bajos y más, sin comprometer la calidad de la pista original./n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            //
            //
            '("nombre ia9","other","urlimage", "urlweb", "/n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"),'
            '("nombre ia99","other","urlimage", "urlweb", "/n/nEsta herramienta de IA ha sido recopilada por la app HubIA. Esperamos la disfrutes y regreses para conocer las demás IAs que tenemos para ti.", "url_tutorial"'
            ');';
        await database.execute(addIA);
      },
      version: 1,
    );
  }

  Future<List<IA>> getImgByCategory(String category) async {
    final db = await initializeDB();
    final result = await db.query(
      'access_ia',
      where: 'category = ?',
      whereArgs: [category],
    );

    var list = result.map((e) => IA.fromMap(e)).toList();
    list.shuffle(Random());
    return list;
  }

  Future<List<IA>> getIAByCategory(String? category) async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.rawQuery(
        'SELECT * FROM access_ia WHERE category LIKE ?', ['%$category%']);
    return queryResult.map((e) => IA.fromMap(e)).toList();
  }

  Future<List<IA>> getIAByPalabraClave(String? palabraClave) async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.rawQuery(
        'SELECT * FROM access_ia WHERE name LIKE ?', ['%$palabraClave%']);
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
      {'name': nameIa},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<IA>> getFavoriteIAs() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.rawQuery(
      'SELECT * FROM access_ia WHERE name IN (SELECT name FROM favorite_ias)',
    );
    return queryResult.map((e) => IA.fromMap(e)).toList();
  }

  Future<void> removeIAFromFavorites(String nameIa) async {
    final db = await initializeDB();
    await db.delete(
      'favorite_ias',
      where: 'name = ?',
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
