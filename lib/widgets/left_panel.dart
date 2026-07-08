import 'package:flutter/material.dart';

class LeftPanel extends StatelessWidget {
  const LeftPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.72), // dark overlay
        ),
        child: Padding(
          padding: const EdgeInsets.all(50),      
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Logo
                  Image.asset(
                    "assets/images/qpx_logo.jpeg",
                    width: 220,
                  ),

                  SizedBox(height: 30),

                  // Heading
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(text: "Create.\n", style: TextStyle(color: Colors.white)),
                        TextSpan(text: "Experience.\n", style: TextStyle(color: Colors.white)),
                        TextSpan(text: "Augment.", style: TextStyle(color: Colors.orange)),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // ADD THIS HERE
                  Text(
                    "QPX AR Studio empowers you to build\n"
                    "immersive AR experiences with ease.",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 22,
                      height: 1.6,
                    ),
                  ),
            ],
          ), 
        ),
      ),
    );
  }
}
