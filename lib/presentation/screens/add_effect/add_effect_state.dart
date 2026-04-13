import 'package:equatable/equatable.dart';

class AddEffectState extends Equatable {
  const AddEffectState({
    this.selectedCategory = 'all',
    this.selectedEffect = 'Normal',
  });

  final String selectedCategory;
  final String selectedEffect;

  @override
  List<Object?> get props => [selectedCategory, selectedEffect];
}
