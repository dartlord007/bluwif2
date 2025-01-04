// ignore_for_file: file_names, avoid_print

import 'package:bluwif2/views/wifiPage.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:get/get.dart';

class LockViewController extends GetxController {
  final LocalAuthentication _auth = LocalAuthentication();

  bool _isAuthenticated = true;
  bool _isAuthenticating = false;

  bool get isAuthenticated => _isAuthenticated;
  bool get isAuthenticating => _isAuthenticating;

  void toggleAuthentication() {
    if (_isAuthenticated) {
      _isAuthenticated = false;
      update();
    } else {
      authenticate();
    }
  }

  Future<void> authenticate() async {
    _isAuthenticating = true;
    update();

    final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    if (canAuthenticateWithBiometrics) {
      try {
        final bool didAuthenticate = await _auth.authenticate(
          localizedReason: 'Please authenticate to show account balance',
          options: const AuthenticationOptions(
            biometricOnly: false,
          ),
        );

        _isAuthenticated = didAuthenticate;
        _isAuthenticating = false;
        update();
      } catch (e) {
        print(e);
        _isAuthenticating = false;
        update();
      }
    }
  }
}

class LockView extends StatelessWidget {
  final LockViewController controller = Get.put(LockViewController());

  LockView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUi(context),
      floatingActionButton: _authButton(),
    );
  }

  Widget _authButton() {
    return FloatingActionButton(
      onPressed: controller.toggleAuthentication,
      child: Icon(
        controller.isAuthenticated ? Icons.lock : Icons.lock_open,
      ),
    );
  }

  Widget _buildUi(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GetBuilder<LockViewController>(
            builder: (controller) => controller.isAuthenticated
                ? 
                // const Text(
                //     "Wifi Scanner",
                //     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                //   )
                ElevatedButton(
                    onPressed: () {
                      Get.to(const WifiPage());
                    },
                    child: const Text('Go to Wifi Scanner'),
                  )
                : const Text(
                    "Unlock to use Wifi Scanner",
                    style: TextStyle(fontSize: 15,),
                  ),
          ),
          GetBuilder<LockViewController>(
            builder: (controller) => controller.isAuthenticating
                ? const CircularProgressIndicator()
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
