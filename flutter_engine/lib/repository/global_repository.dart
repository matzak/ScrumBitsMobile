import 'package:amazon_cognito_identity_dart_2/cognito.dart';

class GlobalRepository {
  static CognitoUser? cognitoUser;
  static CognitoUserSession? cognitoSession;
  static final userPool =
      CognitoUserPool('us-east-1_bJC22HcZN', '65hu2jmadltuhh5lmdmvcecann');
  static List<CognitoUserAttribute>? attributes;
  static String? email;
  static String? password;

  static String? getPhoneNumber() {
    return attributes
        ?.firstWhere((element) => element.name == "phone_number")
        .value;
  }

  static void setPhoneNumber(String? phoneNumber) {
    if (phoneNumber == null) {
      return;
    }
    attributes?.firstWhere((element) => element.name == "phone_number").value =
        phoneNumber;
  }

  static Future<bool> login(String? email, String? password) async {
    cognitoUser = CognitoUser(email, GlobalRepository.userPool);
    final authDetails = AuthenticationDetails(
      username: email,
      password: password,
    );
    GlobalRepository.cognitoSession =
        await GlobalRepository.cognitoUser!.authenticateUser(authDetails);

    if (GlobalRepository.cognitoSession != null) {
      GlobalRepository.attributes =
          await GlobalRepository.cognitoUser!.getUserAttributes();
    }
    return true;
  }
}
