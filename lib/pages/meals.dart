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
    Meals(
      name: 'schnitzel and fries',
      calorie: 220,
      fat: 45,
      protein: 45,
      carbs: 113,
    ),
    Meals(
      name: 'oat flakes',
      calorie: 168,
      fat: 4.5,
      protein: 10.4,
      carbs: 20.9,
    ),
    Meals(
      name: 'Pasta Aglio e Olio',
      calorie: 276,
      fat: 10,
      protein: 7.5,
      carbs: 39,
    ),
  ];

  //add meal to existing MealList
  List<Meals> updateList(Meals meal) {
    setState(() {
      mealList.add(meal);
    });
    return mealList;
  }

  List<Meals> removeItem(Meals meal) {
    setState(() {
      mealList.remove(meal);
    });
    return mealList;
  }

  //dismiss Dialog popup
  void _dismissDialog() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: mealList.length,
                itemBuilder: (context, int index) {
                  return Card(
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(mealList[index].name),
                            scrollable: true,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${mealList[index].calorie} Calorie',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '${mealList[index].fat} Fat',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '${mealList[index].protein} Protein',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '${mealList[index].carbs} Carbs',
                                  style: TextStyle(fontSize: 18),
                                ),
                                TextButton(
                                  onPressed: () {
                                    removeItem(mealList[index]);
                                    _dismissDialog();
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: 300,
                        height: 90,
                        child: Text(
                          mealList[index].name,
                          style: const TextStyle(
                            fontSize: 26.0,
                            color: Color.fromARGB(255, 68, 64, 84),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 22.0),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add_circle_outlined, size: 64),
              onPressed: () {
                Meals tempMeal = Meals(
                  name: '',
                  calorie: 0,
                  fat: 0,
                  protein: 0,
                  carbs: 0,
                );

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Add Meal (100g)'),
                    scrollable: true,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Name',
                          ),
                          onChanged: (String value) {
                            tempMeal.name = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Calorie',
                          ),
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          onChanged: (String value) {
                            int? parsedInput = int.tryParse(value);
                            tempMeal.calorie = parsedInput;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Fat',
                          ),
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          onChanged: (String value) {
                            double? parsedInput = double.tryParse(value);
                            tempMeal.fat = parsedInput;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Protein',
                          ),
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          onChanged: (String value) {
                            double? parsedInput = double.tryParse(value);
                            tempMeal.protein = parsedInput;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Carbs',
                          ),
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          onChanged: (String value) {
                            double? parsedInput = double.tryParse(value);
                            tempMeal.carbs = parsedInput;
                          },
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                _dismissDialog();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                if (tempMeal.name.isNotEmpty &&
                                    tempMeal.calorie != 0) {
                                  updateList(tempMeal);
                                  _dismissDialog();
                                } else {
                                  return;
                                }
                              },
                              child: Text('Save'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              color: const Color.fromARGB(255, 47, 36, 58),
            ),
          ],
        ),
      ),
    );
  }
}

class Meals {
  String name;
  int? calorie;
  double? fat;
  double? protein;
  double? carbs;

  Meals({
    required this.name,
    required this.calorie,
    required this.fat,
    required this.protein,
    required this.carbs,
  });
}
