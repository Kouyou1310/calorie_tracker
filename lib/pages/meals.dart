import 'package:flutter/material.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {

  List<Meals> mealList = [
    Meals(name: 'doener(chicken)', calorie: 179, fat: 8, protein: 9, carbs: 5),
    Meals(name: 'pizza salami', calorie: 270, fat: 13, protein: 9, carbs: 28),
    Meals(name: 'schnitzel and fries', calorie: 220, fat: 45, protein: 45, carbs: 113),
    Meals(name: 'oat flakes', calorie: 168, fat: 4.5, protein: 10.4, carbs: 20.9),
    Meals(name: 'Pasta Aglio e Olio', calorie: 276, fat: 10, protein: 7.5, carbs: 39),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: mealList.length,
          itemBuilder:(context, int index) {
            return Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(200, 167, 195, 209),
                border: Border.all(
                  color: const Color.fromARGB(200, 167, 195, 209),
                  width: 3.0
                ),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(4, 6),
                  blurRadius: 10,
                  spreadRadius: 2,
                )]
              ),
              child: Text(mealList[index].name, style: TextStyle(fontSize: 26.0)),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16.0),
        ),
    );
  }
}

class Meals {
  String name;
  int calorie;
  double fat;
  double protein;
  double carbs;

  Meals({
    required this.name,
    required this.calorie,
    required this.fat,
    required this.protein,
    required this.carbs,
  });
}

