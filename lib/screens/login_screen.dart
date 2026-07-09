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
          clipBehavior: Clip.antiAlias, 
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.orange,width: 1.2,),
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