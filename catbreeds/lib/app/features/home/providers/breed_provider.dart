import 'dart:async';

import 'package:catbreeds/app/features/shared/models/service_exception.dart';
import 'package:catbreeds/app/features/shared/plugins/formx/formx.dart';
import 'package:catbreeds/app/features/shared/widgets/snackbar.dart';
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
  Timer? _debounceTimer;

  getBreeds({bool isFilter = false}) async {
    try {
      if (!isFilter) Loader.show();
      final List<BreedResponse> response = await BreedService.getBreeds();

      // Filtra las razas si hay un valor de búsqueda
      final List<BreedResponse> filteredBreeds = state.searchValue.value.isEmpty
          ? response
          : response
              .where((breed) => breed.name
                  .toLowerCase()
                  .contains(state.searchValue.value.toLowerCase()))
              .toList();

      state = state.copyWith(
        breeds: filteredBreeds,
      );
    } on ServiceException catch (e) {
      SnackbarService.show(e.message);
    } on Exception catch (e) {
      SnackbarService.show(
          'Hubo un error inesperado. Por favor, intenta nuevamente. error: $e');
    } finally {
      if (!isFilter) Loader.dissmiss();
    }
  }

  selectBreed(BreedResponse breed) {
    state = state.copyWith(
      selectedBreed: breed,
    );
  }

  changeSearchValue(FormxInput<String> searchValue) async {
    if (searchValue.value != state.searchValue.value) {
      state = state.copyWith(
        searchValue: searchValue,
      );
      if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
      _debounceTimer = Timer(
        const Duration(milliseconds: 100),
        () async {
          if (searchValue != state.searchValue) return;

          // Llamar a getBreeds con el flag isFilter
          await getBreeds(isFilter: true);
        },
      );
    }
  }
}

class BreedState {
  final FormxInput<String> searchValue;
  final List<BreedResponse> breeds;
  final BreedResponse? selectedBreed;
  BreedState({
    this.searchValue = const FormxInput(value: ''),
    this.breeds = const [],
    this.selectedBreed,
  });

  BreedState copyWith({
    FormxInput<String>? searchValue,
    List<BreedResponse>? breeds,
    BreedResponse? selectedBreed,
  }) {
    return BreedState(
      searchValue: searchValue ?? this.searchValue,
      breeds: breeds ?? this.breeds,
      selectedBreed: selectedBreed ?? this.selectedBreed,
    );
  }
}
