import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_button/timer_button.dart';
import 'package:wrl_home_qurantine_bloc/layout/wrl_app/test/test_layout.dart';
import 'package:wrl_home_qurantine_bloc/layout/wrl_app/wifi_layout/cubit/scanning_cubit.dart';
import 'package:wrl_home_qurantine_bloc/shared/components/components.dart';

class ScanningLayout extends StatefulWidget {
  const ScanningLayout({Key key}) : super(key: key);

  @override
  _ScanningLayoutState createState() => _ScanningLayoutState();
}

class _ScanningLayoutState extends State<ScanningLayout> {
  // @override
  // void dispose() {
  //   ScanningCubit.get(context).bssids;
  //   ScanningCubit.get(context).capBssids;
  //   ScanningCubit.get(context).capKurt;
  //   ScanningCubit.get(context).capLevels;
  //   ScanningCubit.get(context).capMean;
  //   ScanningCubit.get(context).capMedian;
  //   ScanningCubit.get(context).capSTD;
  //   ScanningCubit.get(context).capSkew;
  //   ScanningCubit.get(context).capturesCount;
  //   ScanningCubit.get(context).connectedBSSID;
  //   ScanningCubit.get(context).connectedSSID;
  //   ScanningCubit.get(context).devicesList;
  //   ScanningCubit.get(context).done;
  //   ScanningCubit.get(context).isInside;
  //   ScanningCubit.get(context).levels;
  //   ScanningCubit.get(context).mSignature;
  //   ScanningCubit.get(context).minAccessFounded;
  //   ScanningCubit.get(context).myModel;
  //   ScanningCubit.get(context).sigKurt;
  //   ScanningCubit.get(context).sigMean;
  //   ScanningCubit.get(context).sigMedian;
  //   ScanningCubit.get(context).sigSTD;
  //   ScanningCubit.get(context).sigSkew;
  //   ScanningCubit.get(context).sigVar;
  //   ScanningCubit.get(context).uniqeBSSIDLevelsMap;
  //   ScanningCubit.get(context).uniqueBSSIDSList;
  //   ScanningCubit.get(context).uniqueLevelsList;
  //   ScanningCubit.get(context).wifiNetwork;

  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScanningCubit(),
      child: BlocConsumer<ScanningCubit, ScanningStates>(
        listener: (context, state) {
          if (state is ScanningDoneState) {
            navigateAndFinish(context, const TestLayout());
          }
        },
        builder: (context, state) {
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          var scanningCubit = ScanningCubit.get(context);

          return Scaffold(
            backgroundColor: const Color.fromRGBO(247, 248, 250, 1),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              // ignore: deprecated_member_use
              brightness: Brightness.light,
              elevation: 0.0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: height / 16),
                      const Text(
                        'Scan Home',
                        style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: width / 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '1. Flow throughout your home rooms',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              '2. At each room,press the following "scan" button',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              '3. After you finish scanning  your home, press \n \t \t"finish" button',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height / 8,
                      ),
                      SizedBox(
                        height: 40,
                        width: width - 100,
                        child: TimerButton(
                          label: 'CAPTURE',
                          onPressed: () async {
                            scanningCubit.scanWifi();
                            scanningCubit.checkAvailablity();
                          },
                          timeOutInSeconds: 2,
                          buttonType: ButtonType.ElevatedButton,
                          color: Colors.indigo[900],
                          disabledColor: Colors.indigo[300],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 40,
                        width: width - 100,
                        child: ElevatedButton(
                          onPressed: scanningCubit.capturesCount >= 5
                              ? () {
                                  scanningCubit.checkAvailablity();
                                  if (!scanningCubit.minAccessFounded) {
                                    scanningCubit.doneFunc(context);
                                  } else {
                                    showToast(
                                        text: 'Please Scan more rooms',
                                        state: ToastStates.ERROR);
                                  }
                                }
                              : null,
                          child: const Text(
                            'DONE',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.indigo[900],
                          ),
                        ),
                      ),
                      // ElevatedButton(onPressed: () {
                      //   controller.checkRepeated();
                      // }, child: const Text('R')),
                      SizedBox(
                        height: height / 8,
                      ),
                      Container(
                        height: 80,
                        width: width - 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Row(children: [
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Scanned Rooms',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              Text(
                                '${scanningCubit.capturesCount}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                          const VerticalDivider(
                            color: Colors.black,
                            width: 10.0,
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'Be Ready for the Next Scan after',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '20 seconds',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )),
                        ]),
                      ),
                      // Row(
                      //   children: [],
                      // ),
                      // ListView.builder(
                      //   itemBuilder: (builder, index) {
                      //     if (appController.wifiNetwork.isNotEmpty) {
                      //       return Container(
                      //         color: Colors.blueAccent,
                      //         child: ListTile(
                      //           title: Column(
                      //             children: [
                      //               Text(appController.wifiNetwork[index].ssid),
                      //               Text(appController.wifiNetwork[index].bssid),
                      //               Text(appController.wifiNetwork[index].level
                      //                   .toString()),
                      //             ],
                      //           ),
                      //         ),
                      //       );
                      //     } else {
                      //       return const Center(
                      //         child: Text('No wifi found'),
                      //       );
                      //     }
                      //   },
                      //   itemCount: appController.wifiNetwork.length,
                      //   shrinkWrap: true,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
