import 'package:deepar_flutter/deepar_flutter.dart';
import 'package:flutter/material.dart';

class ARScreen extends StatefulWidget {
  const ARScreen({super.key});

  @override
  State<ARScreen> createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  final deepArController = DeepArController();

  Future<void> _initialController() async {
    await deepArController.initialize(
        androidLicenseKey:
            'f305df4f09294395cc3bd643461efe288b6f1dfad2e9d4e7cfd92420c6e7af888830f735309108df',
        iosLicenseKey: '');

    await deepArController.switchEffectWithSlot(
      slot: 'cap',
      path: 'assets/effects/test.deepar',
    );
  }

  Widget buildCameraPreview() => SizedBox(
        height: MediaQuery.of(context).size.height * 0.82,
        child: Transform.scale(
          scale: 1.5,
          child: DeepArPreview(deepArController),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initialController(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildCameraPreview(),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
