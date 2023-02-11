part of 'main_bloc.dart';

@immutable
class MainState extends Equatable {
  final bool scrumbitsActivated;

  const MainState({this.scrumbitsActivated = false});

  @override
  List<Object?> get props => [scrumbitsActivated];

  MainState copyState({bool? scrumbitsActivated}) {
    return MainState(
        scrumbitsActivated: scrumbitsActivated ?? this.scrumbitsActivated);
  }
}
