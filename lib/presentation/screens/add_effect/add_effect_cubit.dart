import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_effect_state.dart';

class AddEffectCubit extends Cubit<AddEffectState> {
  AddEffectCubit() : super(const AddEffectState());

  void filterByCategory(String category) => emit(AddEffectState(
        selectedCategory: category,
        selectedEffect: state.selectedEffect,
      ));

  void selectEffect(String effect) => emit(AddEffectState(
        selectedCategory: state.selectedCategory,
        selectedEffect: effect,
      ));
}
