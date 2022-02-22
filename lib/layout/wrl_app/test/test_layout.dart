// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:wrl_home_qurantine_bloc/layout/wrl_app/test/cubit/test_cubit.dart';
import 'package:wrl_home_qurantine_bloc/shared/network/local/cache_helper.dart';

class TestLayout extends StatefulWidget {
  const TestLayout({Key key}) : super(key: key);

  @override
  _TestLayoutState createState() => _TestLayoutState();
}

class _TestLayoutState extends State<TestLayout> {
  @override
  void initState() {
    super.initState();
    TestCubit.get(context).initForegroundTask();
    TestCubit.get(context).startForegroundTask();
    TestCubit.get(context).BT();
    Timer.periodic(const Duration(seconds: 12), (timer) {
      TestCubit.get(context).checkRepeated();
    });
    Timer.periodic(const Duration(seconds: 15), (timer) {
      TestCubit.get(context).userLogin();
      var tok = TestCubit.get(context).loginModel.data.token;
      var id = TestCubit.get(context).loginModel.data.id;
      print(tok);
      print(id);
      TestCubit.get(context).userPut(
          token: tok,
          id: id,
          isInside: TestCubit.get(context).isInside,
          isPaired: TestCubit.get(context).mIsPaired);
    });
    print(TestCubit.get(context).isInside);
    print(TestCubit.get(context).mIsPaired);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestCubit, TestStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var testCubit = TestCubit.get(context);
        return Scaffold(
          backgroundColor: const Color.fromRGBO(247, 248, 250, 1),
          appBar: AppBar(
            leading: null,
            elevation: 0.0,
            backgroundColor: const Color.fromRGBO(247, 248, 250, 1),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Your Status',
                    style: TextStyle(
                      color: Colors.indigo[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                  ),
                  const SizedBox(
                    height: 150.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: 200.0,
                        lineWidth: 8.0,
                        animation: true,
                        percent: 0.8,
                        center: SizedBox(
                          height: 200,
                          width: 200.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${12}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 60.0,
                                  color: Colors.indigo[900],
                                ),
                              ),
                              // const SizedBox(
                              //   width: 15.0,
                              // ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                'Remaining\nQuarantine\nDays',
                                style: TextStyle(
                                  color: Colors.indigo[900],
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.indigo[900],
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(
                        height: 120.0,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          // await controller.doUpdate(context);
                          // testCubit.scanWifi();
                          await testCubit.userLogin();
                          var tok = testCubit.loginModel.data.token;
                          var id = testCubit.loginModel.data.id;
                          // rm = testCubit.loginModel.data.remainingDays;
                          print(tok);
                          print(id);
                          testCubit.userPut(
                              token: tok,
                              id: id,
                              isInside: false,
                              isPaired: testCubit.isInside);
                          // testCubit.userPut();
                        },
                        child: const Text('doUpdate'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Your Home Status',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              color: testCubit.isInside
                                  ? Colors.green
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Center(
                              child: Text(
                                testCubit.isInside ? 'Inside' : 'Outside',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            width: 120.0,
                            height: 30.0,
                          ),
                        ],
                      ),
                      // Text('isInside ${}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
