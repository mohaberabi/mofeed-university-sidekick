import '../enums/cuisine.dart';

extension ToCuicine on String {
  Cuisine toCuisine() {
    switch (this) {
      case 'syrian':
        return Cuisine.syrian;
      case 'wraps':
        return Cuisine.wraps;
      case 'waffles':
        return Cuisine.waffles;
      case 'vegan':
        return Cuisine.vegan;
      case 'sushi':
        return Cuisine.sushi;
      case 'streetFood':
        return Cuisine.streetFood;
      case 'sandwiches':
        return Cuisine.sandwiches;
      case 'shawrma':
        return Cuisine.shawrma;
      case 'seyami':
        return Cuisine.seyami;
      case 'salad':
        return Cuisine.salad;
      case 'pastries':
        return Cuisine.pastries;
      case 'pancakes':
        return Cuisine.pancakes;
      case 'noodles':
        return Cuisine.noodles;
      case 'mexican':
        return Cuisine.mexican;

      case 'koshary':
        return Cuisine.koshary;
      case 'juices':
        return Cuisine.juices;
      case 'pizza':
        return Cuisine.pizza;
      case 'italian':
        return Cuisine.italian;
      case 'iceCream':
        return Cuisine.iceCream;
      case 'indian':
        return Cuisine.indian;
      case 'healthy':
        return Cuisine.healthy;
      case 'grills':
        return Cuisine.grills;

      case 'fastFood':
        return Cuisine.fastFood;
      case 'falafel':
        return Cuisine.falafel;
      case 'donuts':
        return Cuisine.donuts;
      case 'egyptian':
        return Cuisine.egyptian;

      case 'desserts':
        return Cuisine.desserts;
      case 'crepes':
        return Cuisine.crepes;
      case 'chinese':
        return Cuisine.chinese;
      case 'chicken':
        return Cuisine.chicken;

      case 'breakfast':
        return Cuisine.breakfast;

      case 'asian':
        return Cuisine.asian;

      case 'bakery':
        return Cuisine.bakery;

      case 'cafe':
        return Cuisine.cafe;
      case 'cakes':
        return Cuisine.cakes;
      default:
        return Cuisine.bakery;
    }
  }
}
