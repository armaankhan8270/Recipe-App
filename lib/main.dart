import 'package:flutter/material.dart';
import 'package:recipe/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      home: const Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
    );
  }
}




            // children: [
            //   buildProductItemSmaller(
            //     img[0], // Replace with your image path
            //     'HomeMade Pizza',
            //     height,
            //     width,
            //   ),
            //   buildProductItemSmaller(
            //     img[1],
            //     'HomeMade Pizza',
            //     height,
            //     width,
            //   ),
            //   buildProductItemSmaller(
            //     img[2],
            //     'HomeMade Pizza',
            //     height,
            //     width,
            //   ),
            //   buildProductItemSmaller(
            //     img[3],
            //     'HomeMade Pizza',
            //     height,
            //     width,
            //   ),
            //   buildProductItemSmaller(
            //     img[5],
            //     'HomeMade Pizza',
            //     height,
            //     width,
            //   ),
            //   buildProductItemSmaller(
            //     img[6],
            //     'HomeMade Pizza',
            //     height,
            //     width,
            //   ),
            //   buildProductItemSmaller(
            //     img[7],
            //     'HomeMade Pizza',
            //     height,
            //     width,
            //   ),

            //   buildProductItemSmaller(
            //     img[8],
            //     'HomeMade Pizza',
            //     height,
            //     width,
            //   ),

            //   // Add more product items here if needed
            // ]
