part of 'personal_data_bloc.dart';

@immutable
abstract class PersonalDataEvent {}

class ButtonPressed extends PersonalDataEvent {}

class InitBloc extends PersonalDataEvent {}

class UpdateName extends PersonalDataEvent {
  final String name;

  UpdateName({required this.name});
}

class UpdatePhone extends PersonalDataEvent {
  final String phone;

  UpdatePhone({required this.phone});
}

class UpdateTechnologies extends PersonalDataEvent {
  final String technologies;

  UpdateTechnologies({required this.technologies});
}

class UpdateExperience extends PersonalDataEvent {
  final int experience;

  UpdateExperience({required this.experience});
}
