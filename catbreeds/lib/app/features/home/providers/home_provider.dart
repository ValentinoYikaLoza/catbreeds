import 'package:catbreeds/app/features/shared/widgets/loader.dart';
import 'package:catbreeds/app/features/shared/widgets/snackbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:catbreeds/app/features/home/models/catbreed_model.dart';
import 'package:catbreeds/app/features/home/services/home_service.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(ref);
});

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier(this.ref) : super(HomeState());
  final Ref ref;

  getBreeds() async {
    try {
      Loader.show('Loading breeds');
      final List<CatbreedResponse> response = await HomeService.getData();

      state = state.copyWith(
        breeds: response,
      );
    } on Exception {
      SnackbarService.show('Hubo un error al obtener las provincias');
    } finally {
      Loader.dissmiss();
    }
  }
}

class HomeState {
  final List<CatbreedResponse> breeds;
  HomeState({
    this.breeds = const [],
  });

  HomeState copyWith({
    List<CatbreedResponse>? breeds,
  }) {
    return HomeState(
      breeds: breeds ?? this.breeds,
    );
  }
}
