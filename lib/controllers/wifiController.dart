// ignore_for_file: file_names, unused_element, unused_local_variable

import 'dart:async';

import 'package:get/get.dart';
import 'package:wifi_scan/wifi_scan.dart';

class Wificontroller extends GetxController {
  WiFiScan wifiScan = WiFiScan.instance;

  Future startScan() async {
    // check platform support and necessary requirements
    final can = await wifiScan.canStartScan(askPermissions: true);
    switch (can) {
      case CanStartScan.yes:
        // start full scan async-ly
        final isScanning = await wifiScan.startScan();
        //...
        break;
      // ... handle other cases of CanStartScan values
      case CanStartScan.notSupported:
      // TODO: Handle this case.
      case CanStartScan.noLocationPermissionRequired:
      // TODO: Handle this case.
      case CanStartScan.noLocationPermissionDenied:
      // TODO: Handle this case.
      case CanStartScan.noLocationPermissionUpgradeAccuracy:
      // TODO: Handle this case.
      case CanStartScan.noLocationServiceDisabled:
      // TODO: Handle this case.
      case CanStartScan.failed:
      // TODO: Handle this case.
    }
  }

  Future getScannedResults() async {
    // check platform support and necessary requirements
    final can = await wifiScan.canGetScannedResults(askPermissions: true);
    switch (can) {
      case CanGetScannedResults.yes:
        // get scanned results
        final accessPoints = await wifiScan.getScannedResults();
        // ...
        break;
      // ... handle other cases of CanGetScannedResults values
      case CanGetScannedResults.notSupported:
      // TODO: Handle this case.
      case CanGetScannedResults.noLocationPermissionRequired:
      // TODO: Handle this case.
      case CanGetScannedResults.noLocationPermissionDenied:
      // TODO: Handle this case.
      case CanGetScannedResults.noLocationPermissionUpgradeAccuracy:
      // TODO: Handle this case.
      case CanGetScannedResults.noLocationServiceDisabled:
      // TODO: Handle this case.
    }
  }

// initialize accessPoints and subscription
  List<WiFiAccessPoint> accessPoints = [];
  StreamSubscription<List<WiFiAccessPoint>>? subscription;

  Future startListeningToScannedResults() async {
    // check platform support and necessary requirements
    final can = await wifiScan.canGetScannedResults(askPermissions: true);
    switch (can) {
      case CanGetScannedResults.yes:
        // listen to onScannedResultsAvailable stream
        subscription = wifiScan.onScannedResultsAvailable.listen((results) {
          accessPoints = results;
          update(); // Update the UI
        });
        // ...
        break;
      // ... handle other cases of CanGetScannedResults values
      case CanGetScannedResults.notSupported:
      // TODO: Handle this case.
      case CanGetScannedResults.noLocationPermissionRequired:
      // TODO: Handle this case.
      case CanGetScannedResults.noLocationPermissionDenied:
      // TODO: Handle this case.
      case CanGetScannedResults.noLocationPermissionUpgradeAccuracy:
      // TODO: Handle this case.
      case CanGetScannedResults.noLocationServiceDisabled:
      // TODO: Handle this case.
    }
  }

  final _wifiScan = WiFiScan.instance;
  Stream<List<WiFiAccessPoint>> get scannedResults => _wifiScan.onScannedResultsAvailable;

// make sure to cancel subscription after you are done
  @override
  dispose() {
    super.dispose();
    subscription?.cancel();
  }
}
