import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe/details.dart';
import 'dart:convert';

import 'package:recipe/images.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Map<String, dynamic> parsedResponse = {};
  late Map<String, dynamic> recipe = {};
  TextEditingController searchController = TextEditingController();

  Future<Map<String, dynamic>> getRecipes(String query) async {
    // Replace with your API key and app ID
    const apikey = '938d7b62614bbc2dc4287da1fafa52fd';
    const appid = '80043f68';
    final endpoint =
        'https://api.edamam.com/search?q=$query&app_id=$appid&app_key=$apikey';

    final response = await http.get(
      Uri.parse(endpoint),
    );

    if (response.statusCode == 200) {
      parsedResponse = json.decode(response.body);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: getRecipes(searchController.text.trim().isNotEmpty
            ? searchController.text.trim()
            : "biryani"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return SingleChildScrollView(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  // color: Colors.blue,
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    buildHeaderText(parsedResponse['q']),
                    const SizedBox(height: 20),
                    buildSearchBar(),
                    const SizedBox(height: 20),
                    buildProductRowSmaller(120, 100),
                    const SizedBox(
                      height: 30,
                    ),
                    // buildHeaderText("Recommended"),
                    buildProductRow(300, 400),
                    const Card(
                      color: Colors.blue,
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildHeaderText(String text) {
    return AppBar(
      toolbarHeight: 72,
      backgroundColor: Colors.white,
      elevation: 4,
      title: Row(
        children: <Widget>[
          // Custom Icon (Using flutter_icons library)
          Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  'https://i.pinimg.com/564x/57/b1/43/57b143e0a8d231e5bf45626f87fe709c.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Recipe App',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
          onPressed: () {
            // Handle the button press here
          },
        ),
      ],
    );
  }

  Widget buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextField(
        style: const TextStyle(color: Colors.black),
        onSubmitted: (a) {
          if (searchController.text.trim().isNotEmpty) {
            setState(() {
              getRecipes(searchController.text.trim());
            });
          } else {
            getRecipes("chicken");
          }
        },
        controller: searchController,
        decoration: InputDecoration(
          hintText: "What are you looking for",
          hintStyle: const TextStyle(color: Colors.black, fontSize: 18),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: const Icon(
            Icons.search,
            color: Colors.blue,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget buildProductRowSmaller(double height, double width) {
    return SingleChildScrollView(
      // scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              buildProductItemSmaller(
                img[0], // Replace with your image path
                'Pizza',
                height,
                width,
              ),
              buildProductItemSmaller(
                img[1],
                'French Fries',
                height,
                width,
              ),
              buildProductItemSmaller(
                img[2],
                'frenky',
                height,
                width,
              ),
              buildProductItemSmaller(
                img[3],
                'Burger',
                height,
                width,
              ),
              buildProductItemSmaller(
                img[5],
                'HomeMade Pizza',
                height,
                width,
              ),
              buildProductItemSmaller(
                img[6],
                'HomeMade Pizza',
                height,
                width,
              ),
              buildProductItemSmaller(
                img[7],
                'HomeMade Pizza',
                height,
                width,
              ),

              buildProductItemSmaller(
                img[8],
                'HomeMade Pizza',
                height,
                width,
              ),

              // Add more product items here if needed
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductRow(double height, double width) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 00),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: parsedResponse['hits'].map<Widget>((hit) {
              final recipe = hit['recipe'];
              final recipeLabel = recipe['label'];
              final detail = recipe["shareAs"];
              final imageUrl = recipe['image'];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailCard(
                        recipeData: recipe,
                      ),
                    ),
                  );
                },
                child: buildProductItem(
                  imageUrl,
                  recipeLabel,
                  height,
                  width,
                  'Medium Gradient',
                  '20 mins',
                  detail,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget buildProductItemSmaller(
      String imagePath, String title, double height, double width) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProductItem(
    String imageUrl,
    String title,
    double height,
    double width,
    String gradientRequirement,
    String timeRequired,
    String detail,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            // Background image
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),

            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                ),
              ),
            ),

            // Recipe details
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Gradient Requirement',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              gradientRequirement,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Time Required',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              timeRequired,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
