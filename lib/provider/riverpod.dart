import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hubia/model/db/ia_model.dart';

final maxCourses_rp = StateProvider((ref) => 879);
final isFirstBuild_rp = StateProvider((ref) => true);
final contadorFinalizado_rp = StateProvider((ref) => false);
final isButtonVisible_rp = StateProvider((ref) => false);
final buttonEnabled_rp = StateProvider((ref) => false);

final categoryProvider = StateProvider<List<IA>>((ref) {
  // Aquí puedes inicializar la lista de instancias de la clase IA
  return [
    IA(
      imageUrl:
          'https://blogger.googleusercontent.com/img/a/AVvXsEhOpT_OmxLhZioODImkOWI8C-TG7FrGZg8Dp79kYHi1U6Q4wetN_iPPymGrKijdaAm2emPRmc_4Ah-R2D218hMLHXQP94qTT8xqEvZAAUpQbu2y0uzUrmN0al0BZgZVtJV-b0T-xa_nljQ99v0EEzlMvSwGpWjPYcQaR3IreBYdU_bgdz3vm4k_uD2d',
    ),
    IA(
      imageUrl:
          'https://blogger.googleusercontent.com/img/a/AVvXsEhOpT_OmxLhZioODImkOWI8C-TG7FrGZg8Dp79kYHi1U6Q4wetN_iPPymGrKijdaAm2emPRmc_4Ah-R2D218hMLHXQP94qTT8xqEvZAAUpQbu2y0uzUrmN0al0BZgZVtJV-b0T-xa_nljQ99v0EEzlMvSwGpWjPYcQaR3IreBYdU_bgdz3vm4k_uD2d',
    ),
    // Agrega más instancias de IA según sea necesario
  ];
});
