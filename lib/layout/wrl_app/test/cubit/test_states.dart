part of 'test_cubit.dart';

@immutable
abstract class TestStates {}

class TestInitial extends TestStates {}

class TestChangeWifiState extends TestStates {}

class TestCheckRepeatedState extends TestStates {}

class TestIsInsideChangeState extends TestStates {}

class InitForeGroundState extends TestStates {}

class StartForeGroundState extends TestStates {}

class RestartForeGroundState extends TestStates {}

class LoginSuccessState extends TestStates {
  // final UserModel loginModel;

  // LoginSuccessState(this.loginModel);
}

class LoginErrorState extends TestStates {
  final String error;

  LoginErrorState(this.error);
}

class UpdateSuccessState extends TestStates {}
