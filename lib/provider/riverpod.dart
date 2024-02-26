import '../screens/screens_barril.dart';

final maxIas_rp = StateProvider((ref) => 879); //numero de ias
final isFirstBuild_rp = StateProvider((ref) => true);
final contadorFinalizado_rp = StateProvider((ref) => false);
final isButtonVisible_rp = StateProvider((ref) => false);
final buttonEnabled_rp = StateProvider((ref) => false);

final selecCatProvider = StateProvider<String?>((ref) => null);
final selectedIAProvider = StateProvider<IA?>((ref) => null);
final likeProvider = StateProvider<bool>((ref) => false);
final loadingProvider = StateProvider<bool>((ref) => true);

final dBhandler = DatabaseHandlerIA();

final getCategoryIaProvider = FutureProvider<List<IA>>((ref) async {
  await dBhandler.initializeDB();

  final selectedCategory = ref.watch(
      selecCatProvider); // Esto observa el Provider de categoría seleccionada

  if (selectedCategory != null) {
    final List<IA> listIA = await dBhandler.getIAByCategory(selectedCategory);
    return listIA;
  } else {
    return [];
  }
});

final isIAFavoritedProvider =
    FutureProvider.autoDispose.family<bool, String>((ref, iaName) async {
  final dbHandler = DatabaseHandlerIA();
  await dbHandler.initializeDB();
  final favoriteIAs = await dbHandler.getFavoriteIAs();
  return favoriteIAs.any((ia) => ia.name == iaName);
});

// image ---
//https://huggingface.co/spaces/Amrrs/DragGan-Inversion
//https://clipdrop.co/uncrop
//https://huggingface.co/spaces/sczhou/CodeFormer
//https://huggingface.co/spaces/AP123/IllusionDiffusion
//https://replicate.com/codeslake/ifan-defocus-deblur
// https://replicate.com/megvii-research/nafnet
//https://replicate.com/cjwbw/bigcolor
//https://pimeyes.com/en
//image colab codeformer https://colab.research.google.com/drive/1qhkSMVMDQa_IgnBOAuQzEkJCNke_6u5v?usp=sharing

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

//others ---
// gemini https://deepmind.google/technologies/gemini/#introduction

final imagesCategoryProvider = FutureProvider<List<IA>>((ref) async {
  return await dBhandler.getImgByCategory('image');
});

final videoCategoryProvider = FutureProvider<List<IA>>((ref) async {
  return await dBhandler.getImgByCategory('video');
});

final audioCategoryProvider = FutureProvider<List<IA>>((ref) async {
  return await dBhandler.getImgByCategory('audio');
});

final textCategoryProvider = FutureProvider<List<IA>>((ref) async {
  return await dBhandler.getImgByCategory('text');
});

final othersCategoryProvider = FutureProvider<List<IA>>((ref) async {
  return await dBhandler.getImgByCategory('other');
});



/* final imagesCategoryProvider = StateProvider<List<IA>>((ref) {
  return [
    IA(
      imageUrl:
          'https://blogger.googleusercontent.com/img/a/AVvXsEhOpT_OmxLhZioODImkOWI8C-TG7FrGZg8Dp79kYHi1U6Q4wetN_iPPymGrKijdaAm2emPRmc_4Ah-R2D218hMLHXQP94qTT8xqEvZAAUpQbu2y0uzUrmN0al0BZgZVtJV-b0T-xa_nljQ99v0EEzlMvSwGpWjPYcQaR3IreBYdU_bgdz3vm4k_uD2d',
    ),
    IA(
      imageUrl:
          'https://blogger.googleusercontent.com/img/a/AVvXsEiW382Psf9GNd1ZrFUO_BEfx4AzMkR3mSgsQ2NLwS5n33HdDMoWFNV9fxIthSUDkh0NiEB1bAsVKbYC3XmUKO3w5PpjasgxblaOdl7F6aO_21rf1NMbtmS0cJiAjObt9dZjinKLI_WAv11KsAIlBJZ82cX9C6caFg7LgE2fl0VJKygggPv5XnuNdnBf',
    ),
    IA(
      imageUrl:
          'https://blogger.googleusercontent.com/img/a/AVvXsEjs1fpUue0OJokzRz5170wGcRVkVEi2roRw7VhOf55nd4wFYiiVSmSIzWYPJxr3GaJ27Fql8Cy3VxoI9VuhmwMbE33IJPXz_RUlJ7b66YPwNYhgbjspX-gcrjIpkXZDHhjmNeloO1UQ-BcN6annMDXNMoU0hq0saGa3nWPRzVYSHJPaRcYLU0JGTggd',
    ),
    IA(
      imageUrl:
          'https://blogger.googleusercontent.com/img/a/AVvXsEgabiP35k863OlOZ_iVLVlAmDLNRLIHd_TEBLeqOilcfnTEERKlQuvdyeN8uIN5bIfagDRISCV2jsV16ulWdgxGnoyUnR1memgY7C-brXjD-6d502hs2SmKYLrApS0R_U1yxf4jVPX7gbqccQseLWw3a2zOFMDGQ-ksHGA1bdSGvAkU1fY7XGos-ENB',
    ),
    IA(
      imageUrl:
          'https://blogger.googleusercontent.com/img/a/AVvXsEjklIbDjQED5Y8btES4bUy4DVWV0wwOpsdfNDbFAFAiJExKMDiZbhJcu71E4VYKBS-3Vrg9x6rQ6F1uHmnuDU4G8zmBLi311WLxLTLbvp95iuvnk0QMPd-OdwL-2njPlpuI3D60AWtR8eMy6pO7H63iY_rJMU2PcPlZTz-CDPM_9-t4QIX5hkLeisA0',
    ),
    IA(
      imageUrl:
          'https://blogger.googleusercontent.com/img/a/AVvXsEisdx11tydLsbRkdvzvK8707xRnHHVajJauCCSlbxWMs7QwEKsAYOx8quKBUtbCiYh3qnGuuia3CBSzWOXIGlx-xTtBuzcnAJXjf86E9WdPNpU150UI5yS4EDc_Wx2mR2jEharmi9RYId9BwmVEe1a2Hn2l6KtoMt0PzJR52OjEw1Q7GLav2dBMkWgM',
    ),
    IA(
      imageUrl:
          'https://blogger.googleusercontent.com/img/a/AVvXsEgnkzUQCHuBFNO3rR75Gyyt81FvcRNQs-ca1AAWUWajvmNuwPX6xnxEQltI5LkxmrD6QYS1VK4PVN8r2l4GRfSS7KyQHrdT8OlhogSffikOyK5WfHO9HU4vxM93JhFN7gVWnHK2NngSJMnug3s4Q2Fqmo4nJ0YWP4hmATIBWXrq1la-Z7Uxg9ROnz8Q',
    ),
    IA(
      imageUrl:
          'https://blogger.googleusercontent.com/img/a/AVvXsEgBT2-D8Q-2p2B1w5mZjwTwMp5OtJLKb4g-cML9GAYBHZ1QXP5HIGnYenOrrRiJonueoFrKknHxdeYnbxejAA5Kf7v4G8L7j-pk4Y7MD5wq4RxlE_KIFTapi_DSWHfBqSUUtgGHHphUB78ph4TaSRl7-VKqpYY3eQbRgangJd6AaduT1kj-AvqLyFLU',
    ),
    IA(
      imageUrl: '',
    ),
    IA(
      imageUrl: '',
    ),
    IA(
      imageUrl: '',
    ),
  ];
});

final videoCategoryProvider = StateProvider<List<IA>>((ref) {
  return [
    IA(
      imageUrl:
          'https://blogger.googleusercontent.com/img/a/AVvXsEhuOWcfNFGgbXPI-saP5VRcbn5uKDu0RauWyiNvQJGkSsERm5FxVSSkwZQlmCMoC3bb1EdFX7S9dK8UjpzIrWo6GOUlU8nNeQY3lnOM7w4VMgLqzYUolJ6NMjiQvEC0yaovb5wrJ9wL02pswkeZDbP65X9xHhHS2QvN20Cd-ZJwPiUNOnOYnn39XzxO',
    ),
    IA(
      imageUrl:
          'https://blogger.googleusercontent.com/img/a/AVvXsEh9WKffKz_cVsgBFhWxVlJ7rF96vabNXfBMqvwWYlwaYMPLuhUbQXsIvKsh06QDqvVwavYy5Zejni3Hstk0f2emEvPFuOAs7JkL9423kvlFi3OLVauBKLWc7X18oxNMEhhGat4yvt83csEsdaDXC48vYvt_0eHu0uQ7G8PeJrLaDirEXwXkSzXbnpm3',
    ),
    IA(
      imageUrl:
          'https://blogger.googleusercontent.com/img/a/AVvXsEhOpT_OmxLhZioODImkOWI8C-TG7FrGZg8Dp79kYHi1U6Q4wetN_iPPymGrKijdaAm2emPRmc_4Ah-R2D218hMLHXQP94qTT8xqEvZAAUpQbu2y0uzUrmN0al0BZgZVtJV-b0T-xa_nljQ99v0EEzlMvSwGpWjPYcQaR3IreBYdU_bgdz3vm4k_uD2d',
    ),
/*     IA(
      imageUrl: '',
    ),
    IA(
      imageUrl: '',
    ),
    IA(
      imageUrl: '',
    ),
    IA(
      imageUrl: '',
    ),
    IA(
      imageUrl: '',
    ), */
  ];
});

final audioCategoryProvider = StateProvider<List<IA>>((ref) {
  return [
    IA(
      imageUrl:
          'https://blogger.googleusercontent.com/img/a/AVvXsEjwbFfVt1nNG7B7hkjWH-cQe16z3BlD0hbZSsxmFrZmj5Za-2sTvVE1r71-m3Qsi6G4rRAaMhlqcjpsR6-ibNhKLDmPJk0XO9zVqBegoaXgFmpuhbW_gCqpK-u0NiSl-ltfIDmT91ilEc4KRj2Hken1Dw8DZzYNEkzcWRLfCRCacsiw-5hp3QWItt4v',
    ),
    IA(
      imageUrl:
          'https://blogger.googleusercontent.com/img/a/AVvXsEhEdFGlcP5E4i-spEHTgK-qVIfW3shFtdFzmOm6R5wM-dYz2ggNf-Dq77KOwjxQ8VIYN6YGnmpE6lIYt_imBzxzwOnHI69AfwkfoVNvA4QQCQXg5quzYCwzp4hm2oDft20GxDo5cUz_kn-6C7WPX_N08jSWMk_oSF5r1beFM-GvJ91jTNMd6rop7XcA',
    ),
    IA(
      imageUrl:
          'https://blogger.googleusercontent.com/img/a/AVvXsEjiQE0JSiql74xcmBrde4OZ4-Twvl4w0fX0pVaQFsJQxNovzr9uPepmbiQj29xT8gHmVR86RRMjws7OSSOJNf9VY0HS5EX8MV6l4_5Z3mAw5gr-SBgj5uT7deMI3B1wuP9Gd21_jCVim46MCSuw70plpzr8lrKiFjOZgd1AI4vufhsJnCZ5dK8nC6sl',
    ),
  ];
});

final textCategoryProvider = StateProvider<List<IA>>((ref) {
  return [
    IA(
      imageUrl:
          'https://blogger.googleusercontent.com/img/a/AVvXsEjXLEY56Msg6MzyzJghuLubgxMw5UlWMu4AFNH30gUvRCx8I9M6FTx38Ba7_UP8vgYdNCiYDo9G8g9POyBrg9bWMEKO6WO49Eo8WLGJi3fdEYckO6bwKV5SV6waKr55NdejAfAgmlg_XXr62Qv4_evL7iEZA4ZP-4vllRanNKAXDmmePWScQ-duhgs0',
    ),
    IA(
      imageUrl:
          'https://blogger.googleusercontent.com/img/a/AVvXsEg6XGh-GY0fxBu9dRkgOFNtoIhxLVEiYP-cgpmMh-M7T9tEx18P7utdVcg_0E6lRN9dTFPClJs2O2dvVowb5DqNWdBUC10ZRzGkBqMaqiatvwigMZJPDT3FPM9CxFCKQ5dgCjmhFK052T6gha7CloRa7NOrm_xdq8LqV8S7EZlEv4_E0rxWOfZQBzG9',
    ),
    IA(
      imageUrl:
          'https://blogger.googleusercontent.com/img/a/AVvXsEiuL-O-i7sA1z74-EXzlKQaqyHTdM1dhD79mQanpTT5qiQrTVJERT9DozYFkdDj8O7WYtfpzMkmfLBLA5fQfhzj-eqQxdtV3sbfNVzqMin5xU9TMmVxJPaDVbNvCz67EyyLb0lm_43x0toLNiENti3o_J6mlk9o80jmyqwxx_aPSDYqB518Si4br3Qi',
    ),
    IA(
        imageUrl:
            'https://blogger.googleusercontent.com/img/a/AVvXsEh3PJqhXzh13FWzEfoy9mm0TxEX78vOI9rpVsADiC0eHGKwi3lrO8LUA4Ze7fTi_UApsA-xWNYgE_trIfVM_RrCoxZLZe5AOqVlTaHvI6v46F53VrIxQ2hZhGSotNurNmsHp8fhSfcLHcbYn6I3ArPfAToLF8pCpxUchA3yGveDbn8MG5GnkpQjSBpG'),
  ];
});

final othersCategoryProvider = StateProvider<List<IA>>((ref) {
  return [
    IA(
      imageUrl:
          'https://blogger.googleusercontent.com/img/a/AVvXsEg-ckzVyJUaEHpKMYgPhb6mFE7qiuhLkiC3_aRzaMs_WXDgBBBqklew06G_JOrwUKd9OgC5bWZcmjkVcraXGWTWvgb3rnuRdjDhBKwHrIC2XEgJELeyeHfqKdq5BC2iYc6KV6pRXBjnZ04UMD9i130jpGq5-zjgXir81cekfZRcgjs0px8OR_jR_CMl',
    ),
    IA(imageUrl: ''),
  ];
});
 */