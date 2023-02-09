part of 'personal_data_bloc.dart';

@immutable
class PersonalDataState extends Equatable {
  final String? name;
  final String? phone;
  final String? email;
  final int? experience;

  final bool? activeAccount;

  const PersonalDataState(
      {this.name, this.phone, this.email, this.experience, this.activeAccount});

  @override
  List<Object?> get props => [name, phone, email, experience, activeAccount];

  PersonalDataState copyState(
      {String? name,
      String? phone,
      String? email,
      int? experience,
      bool? activeAccount}) {
    return PersonalDataState(
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        experience: experience ?? this.experience,
        activeAccount: activeAccount ?? this.activeAccount);
  }
}
