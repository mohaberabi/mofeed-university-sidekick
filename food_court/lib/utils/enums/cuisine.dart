import 'package:mofeed_shared/utils/enums/langauge_enum.dart';

enum Cuisine with CustomEnum {
  breakfast("Breakfasat", "فطار"),
  asian("Asian", "اسيوي"),
  bakery("Bakery", "مخبز"),
  beverages("Beverages", "مشروبات"),
  burgers("Burgers", "برجر"),
  cafe("Cafe", "كافية"),
  cakes("Cakes", "كيك"),
  chicken("Chicken", "فراخ"),
  chinese("Chinese", "صيني"),
  crepes("Crepes", "كريب"),
  desserts("Desserts", "حلويات"),
  egyptian("Egyptian", "مصرى"),
  donuts("Donuts", "دونتس"),
  falafel("Foul & Falafel", "فول و فلافل"),
  fastFood("Fast food", "اكل سريع"),
  grills("Grills", "مشويات"),
  healthy("Healthy", "صحي"),
  indian("Indian", "هندي"),
  iceCream("Ice cream", "ايس كريم"),
  italian("Italian", "ايطالي"),
  pizza("Pizza", "بيتزا"),
  juices("Juices", "عصائر"),
  koshary("Koshary", "كشري"),
  mexican("Mexiacan", "مكسيكي"),
  noodles("Noodles", "نودلز"),
  pancakes("Pan Cakes", "بان كيك"),
  pastries("Pastries", "حلويات"),
  salad("Salad", "سلطة"),
  sandwiches("Sandwiches", "ساندويتشات"),
  seyami("Seyami", "صيامي"),
  shawrma("Shawrma", "شاورما"),
  snacks("Sncaks", "سناكس"),
  streetFood("Street Food", "اكل شارع"),
  sushi("Sushi", "سوشي"),
  vegan("Vegan", "نباتي"),
  waffles("Waffles", "وافل"),
  wraps("Wraps", "راب"),
  syrian("Syrian", "سوري");

  @override
  final String ar;
  @override
  final String en;

  const Cuisine(this.en, this.ar);
}
