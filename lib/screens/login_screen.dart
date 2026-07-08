import 'package:flutter/material.dart';

import '../widgets/left_panel.dart';
import '../widgets/right_panel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Container(
          width: 1450,
          height: 850,

          decoration: BoxDecoration(
            color: const Color(0xff111111),

            borderRadius: BorderRadius.circular(24),

            border: Border.all(
              color: Colors.deepOrange,
            ),
          ),

          child: const Row(
            children: [

              Expanded(
                flex: 11,
                child: LeftPanel(),
              ),

              Expanded(
                flex: 9,
                child: RightPanel(),
              ),

            ],
          ),
        ),
      ),
    );
  }
}