part of 'main_bloc.dart';

@immutable
class MainState extends Equatable {
  final bool scrumbitsActivated;
  final bool processing;

  const MainState({this.scrumbitsActivated = false, this.processing = false});

  @override
  List<Object?> get props => [scrumbitsActivated, processing];

  MainState copyState({bool? scrumbitsActivated, bool? processing}) {
    return MainState(
      scrumbitsActivated: scrumbitsActivated ?? this.scrumbitsActivated,
      processing: processing ?? this.processing,
    );
  }
}
