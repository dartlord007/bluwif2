// ignore_for_file: file_names

import 'package:bluwif2/controllers/wifiController.dart';
import 'package:bluwif2/views/homePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wifi_scan/wifi_scan.dart';

class WifiPage extends StatefulWidget {
  const WifiPage({super.key});

  @override
  State<WifiPage> createState() => _WifiPageState();
}

class _WifiPageState extends State<WifiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<Wificontroller>(
          init: Wificontroller(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.blueGrey,
                    child: const Center(
                      child: Text(
                        "Wifi Scanner",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          controller.startScan();
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueGrey,
                            minimumSize: const Size(300, 55),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        child: const Text(
                          "Scan nearby devices ...",
                          style: TextStyle(fontSize: 16),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<List<WiFiAccessPoint>>(
                    stream: controller.scannedResults,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final accessPoint = snapshot.data![index];
                            return ListTile(
                              title: Text(accessPoint.ssid),
                              subtitle: Text('BSSID: ${accessPoint.bssid}'),
                              trailing:
                                  Text('Signal Strength: ${accessPoint.level}'),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(const Homepage());
                    },
                    child: const Text('Go to Bluetooth Scanner'),
                  )
                ],
              ),
            );
          }),
    );
  }
}
