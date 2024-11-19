import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 216, 255, 222),
      child: const Center(
        child: SpinKitChasingDots(
          color: Color.fromARGB(255, 79, 169, 65),
          size: 50.0,
        ),
      ),
    );
  }
}
