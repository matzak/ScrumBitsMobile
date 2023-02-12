part of 'settings_bloc.dart';

@immutable
class SettingsState extends Equatable {
  final String? currentPassword;
  final String? newPassword;
  final String? reenteredPassword;
  final String? phone;

  final bool? accountRemoved;
  final String? messageString;

  const SettingsState({
    this.currentPassword,
    this.newPassword,
    this.reenteredPassword,
    this.phone,
    this.accountRemoved,
    this.messageString,
  });

  @override
  List<Object?> get props => [
        currentPassword,
        newPassword,
        reenteredPassword,
        phone,
        accountRemoved,
        messageString
      ];

  SettingsState copyState({
    String? currentPassword,
    String? newPassword,
    String? reenteredPassword,
    String? phone,
    bool? accountRemoved,
    String? messageString,
  }) {
    return SettingsState(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      reenteredPassword: reenteredPassword ?? this.reenteredPassword,
      phone: phone ?? this.phone,
      accountRemoved: accountRemoved ?? this.accountRemoved,
      messageString: messageString,
    );
  }
}
