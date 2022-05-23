import 'dart:math';

///Get Random Numbers
List<String> getRandomNumbers(amount) {
  final rng = new Random();
  final characters = new List.generate(amount, (_) => rng.nextInt(300));
  return characters.map((e) => e.toString()).toList();
}
