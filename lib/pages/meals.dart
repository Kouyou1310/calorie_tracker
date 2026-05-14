import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  List<Meals> mealList = [
    Meals(
      name: 'doener(chicken)', 
      calorie: 179, 
      fat: 8, 
      protein: 9, 
      carbs: 5
    )
  ];

  //add meal to existing MealList
  List<Meals> updateList(Meals meal) {
    setState(() {
      mealList.add(meal);
    });
    return mealList;
  }

  //remove meal from MealList
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

  //sharedpref load
  Future<List<Meals>> getMealList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('meal_keys');

    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      setState(() {
        mealList = jsonList.map((item) => Meals.fromJSON(item)).toList();
      });
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    getMealList();
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
                                  onPressed: () async {
                                    setState(() {
                                      //remove from list
                                      removeItem(mealList[index]);
                                    });
                                    //save changed list
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    String jsonString = jsonEncode(mealList.map((m) => m.toJson()).toList());
                                    await prefs.setString('meal_keys', jsonString);

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
                              onPressed: () async{
                                if (tempMeal.name.isNotEmpty && tempMeal.calorie != 0) {
                                  //save in List
                                  updateList(tempMeal);

                                  //save in SharedPref
                                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                                  String jsonString = jsonEncode(mealList.map((m) => m.toJson()).toList());
                                  await prefs.setString('meal_keys', jsonString);

                                  _dismissDialog();
                                } else {
                                   //error notfication
                                   ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Please add Name and calorie'))
                                   );
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

  //JSON to meal-obj
  factory Meals.fromJSON(Map<String, dynamic> json) => Meals(
    name: json['name'], 
    calorie: json['calorie'], 
    fat: json['fat'], 
    protein: json['protein'], 
    carbs: json['carbs']
  );

  //Meal-obj to JSON
  Map<String, dynamic> toJson() => {
    'name': name,
    'calorie': calorie,
    'fat': fat, 
    'protein': protein,
    'carbs': carbs
  };
}
