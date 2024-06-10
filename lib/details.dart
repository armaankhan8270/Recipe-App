import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeDetailCard extends StatelessWidget {
  final Map<String, dynamic> recipeData;

  const RecipeDetailCard({super.key, required this.recipeData});

  @override
  Widget build(BuildContext context) {
    final String label = recipeData['label'] ?? 'Recipe Name';
    final String image = recipeData['image'] ?? '';
    final List<String> ingredientLines =
        List<String>.from(recipeData['ingredientLines'] ?? []);
    final double totalTime = recipeData['totalTime'] ?? 0;
    final List<String> dietLabels =
        List<String>.from(recipeData['dietLabels'] ?? []);
    final List<String> healthLabels =
        List<String>.from(recipeData['healthLabels'] ?? []);
    final List<Map<String, dynamic>> digest =
        List<Map<String, dynamic>>.from(recipeData['digest'] ?? []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recipe Details',
          style: GoogleFonts.poppins(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    height: 200.0,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 3,
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    label,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Ingredients:',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: ingredientLines.length,
                itemBuilder: (BuildContext context, int index) {
                  return SingleChildScrollView(
                    child: Card(
                      elevation: 3,
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text((index + 1).toString()),
                          ),
                          title: Text(
                            ingredientLines[index],
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 4,
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    'Total Time: $totalTime minutes',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 4,
                color: Colors.white,
                child: Text(
                  'Diet Labels: ${dietLabels.join(", ")}',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 4,
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Health Labels: ${healthLabels.join(", ")}',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Nutritional Information:',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: digest.length,
                  itemBuilder: (BuildContext context, int index) {
                    final nutrient = digest[index];
                    return Card(
                      elevation: 4,
                      color: Colors.white,
                      child: ListTile(
                        title: Text(
                          '${nutrient['label']}: ${nutrient['total']} ${nutrient['unit']}',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
