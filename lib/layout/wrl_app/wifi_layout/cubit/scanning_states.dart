part of 'scanning_cubit.dart';

@immutable
abstract class ScanningStates {}

class ScanningInitial extends ScanningStates {}

class ScanningCountChangeState extends ScanningStates {}

class ScanningDoneState extends ScanningStates {}
