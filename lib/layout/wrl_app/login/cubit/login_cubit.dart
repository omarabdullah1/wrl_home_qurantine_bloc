// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrl_home_qurantine_bloc/layout/wrl_app/login/cubit/login_states.dart';
import 'package:wrl_home_qurantine_bloc/models/user/user_model.dart';
import 'package:wrl_home_qurantine_bloc/shared/network/end_points.dart';
import 'package:wrl_home_qurantine_bloc/shared/network/remote/dio_helper.dart';

class HomeQuarantineLoginCubit extends Cubit<HomeQuarantineLoginStates> {
  HomeQuarantineLoginCubit() : super(HomeQuarantineLoginInitialState());

  static HomeQuarantineLoginCubit get(context) => BlocProvider.of(context);

  UserModel loginModel;

  void userLogin({
    @required String username,
    @required String password,
  }) {
    emit(HomeQuarantineLoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data: {
        'username': username,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      loginModel = UserModel.fromJson(value.data);
      emit(HomeQuarantineLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(HomeQuarantineLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(HomeQuarantineChangePasswordVisibilityState());
  }
}
