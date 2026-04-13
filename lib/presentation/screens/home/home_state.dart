import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({this.effects = const ['🤖 Robot', '👹 Monster', '👻 Ghost', '👽 Alien']});

  final List<String> effects;

  @override
  List<Object?> get props => [effects];
}
