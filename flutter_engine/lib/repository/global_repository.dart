import 'package:amazon_cognito_identity_dart_2/cognito.dart';

class GlobalRepository {
  static CognitoUser? cognitoUser;
  static CognitoUserSession? cognitoSession;
  static final userPool =
      CognitoUserPool('us-east-1_bJC22HcZN', '65hu2jmadltuhh5lmdmvcecann');
}
