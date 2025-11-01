import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildPortfolioSection(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      children: [
        Text(
          'Our Work',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width > 600 ? 40 : 32,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        const SizedBox(height: 30),
        Container(
          width: 120,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.blue.shade700,
            borderRadius: BorderRadius.circular(2.5),
          ),
        ),
        const SizedBox(height: 40),
        MediaQuery.of(context).size.width > 900
            ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildPortfolioItem(
                'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
                'Corporate Plated Meals'),
            buildPortfolioItem(
                'https://images.unsplash.com/photo-1600891964594-f61ba0e24090?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
                'Meal Prep for Offices'),
            buildPortfolioItem(
                'https://images.unsplash.com/photo-1600891964591-f61ba0e24091?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
                'Custom Catering Menus'),
          ],
        )
            : Column(
          children: [
            buildPortfolioItem(
                'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
                'Corporate Plated Meals'),
            const SizedBox(height: 20),
            buildPortfolioItem(
                'https://images.unsplash.com/photo-1600891964594-f61ba0e24090?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
                'Meal Prep for Offices'),
            const SizedBox(height: 20),
            buildPortfolioItem(
                'https://images.unsplash.com/photo-1600891964591-f61ba0e24091?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
                'Custom Catering Menus'),
          ],
        ),
      ],
    ),
  );
}

Widget buildPortfolioItem(String imageUrl, String title) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 200,
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: Colors.grey.shade200,
                  child: const Center(child: Text('Image failed to load')),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.grey.shade800,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}
