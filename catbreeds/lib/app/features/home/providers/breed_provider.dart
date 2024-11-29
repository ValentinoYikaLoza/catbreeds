import 'package:catbreeds/app/features/shared/models/service_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:catbreeds/app/features/home/models/breed_model.dart';
import 'package:catbreeds/app/features/home/services/breed_service.dart';
import 'package:catbreeds/app/features/shared/widgets/loader.dart';

final breedProvider = StateNotifierProvider<BreedNotifier, BreedState>((ref) {
  return BreedNotifier(ref);
});

class BreedNotifier extends StateNotifier<BreedState> {
  BreedNotifier(this.ref) : super(BreedState());
  final Ref ref;

  getBreeds() async {
    try {
      Loader.show();
      final List<BreedResponse> response = await BreedService.getBreeds();

      state = state.copyWith(
        breeds: response,
      );
    } on Exception {
      throw ServiceException('Error', 'Hubo un error al obtener las razas');
    } finally {
      Loader.dissmiss();
    }
  }

  selectBreed(BreedResponse breed) {
    state = state.copyWith(
      selectedBreed: breed,
    );
  }
}

class BreedState {
  final List<BreedResponse> breeds;
  final BreedResponse? selectedBreed;
  BreedState({
    this.breeds = const [],
    this.selectedBreed,
  });

  BreedState copyWith({
    List<BreedResponse>? breeds,
    BreedResponse? selectedBreed,
  }) {
    return BreedState(
      breeds: breeds ?? this.breeds,
      selectedBreed: selectedBreed ?? this.selectedBreed,
    );
  }
}
