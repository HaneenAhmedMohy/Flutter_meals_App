import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routeName = '/mealDetailsScreen';
  final Function toggleFavorites;
  final Function isFavoriteMeal;
  MealDetailsScreen(this.toggleFavorites, this.isFavoriteMeal);
  Widget builderMethodTitle(BuildContext context, String text) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline6,
        ));
  }

  Widget buildListViewContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) {
      return meal.id == mealId;
    });
    return Scaffold(
      appBar: AppBar(title: Text('${selectedMeal.name}')),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: double.infinity,
            height: 300,
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          builderMethodTitle(context, 'Ingredients'),
          buildListViewContainer(ListView.builder(
            itemCount: selectedMeal.ingredients.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: Card(
                  color: Theme.of(context).accentColor,
                  child: Text(selectedMeal.ingredients[index]),
                ),
              );
            },
          )),
          builderMethodTitle(context, 'Steps'),
          buildListViewContainer(ListView.builder(
            itemCount: selectedMeal.steps.length,
            itemBuilder: (ctx, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(child: Text('# ${(index + 1)}')),
                    title: Text(selectedMeal.steps[index]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      thickness: 1,
                      color: Colors.blueGrey,
                    ),
                  )
                ],
              );
            },
          )),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(isFavoriteMeal(mealId) ? Icons.star : Icons.star_border),
          onPressed: () => toggleFavorites(mealId)),
    );
  }
}
