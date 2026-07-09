import 'package:flutter/material.dart';

class LeftPanel extends StatelessWidget {
  const LeftPanel({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return SizedBox.expand(
      child: Image.asset(
        "lib/assets/images/mockup.jpeg",
        fit: BoxFit.cover,
      ),
    );
  }
}
=======
    // 1. Wrap with ClipRRect to force children to respect the rounded corners
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        bottomLeft: Radius.circular(30),
      ), // Adjust the radius value here
      child: Container(
         decoration: const BoxDecoration(
          // 2. Add borderRadius to the outer container decoration
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        // child: Container(
        //   decoration: BoxDecoration(
           
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.all(50),      
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         // Logo
        //         Image.asset(
        //           "assets/images/qpx_logo.jpeg",
        //           width: 220,
        //         ),

        //         const SizedBox(height: 30),

        //         // Heading
        //         RichText(
        //           text: const TextSpan(
        //             style: TextStyle(
        //               fontSize: 30,
        //               fontWeight: FontWeight.bold,
        //             ),
        //             children: [
        //               TextSpan(text: "Create. ", style: TextStyle(color: Colors.white)),
        //               TextSpan(text: "Experience. ", style: TextStyle(color: Colors.white)),
        //               TextSpan(text: "Augment. ", style: TextStyle(color: Colors.deepOrange)),
        //             ],
        //           ),
        //         ),

        //         const SizedBox(height: 30),

        //         const Text(
        //           "QPX AR Studio empowers you to build\n"
        //           "immersive AR experiences with ease.",
        //           style: TextStyle(
        //             color: Colors.white70,
        //             fontSize: 22,
        //             height: 1.6,
        //           ),
        //         ),
        //       ], // Added missing closing brackets for the Column
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
>>>>>>> a953b9ab1a6560e28ca91bc4995e30d30e6a5390
