import 'dart:math';

class Square {
  double lenght;

  Square(this.lenght);
}

class Circle {
  double radius;

  Circle(this.radius);
}

class AreaCalculator {
  List<dynamic> shapes;

  AreaCalculator(this.shapes);

  /*  num sum() {
    List<num> area = List<num>();
    for (var shape in shapes) {
      if (shape is Square) {
        area.add(pow(shape.lenght, 2));
      } else if (shape is Circle) {
        var res = pi * pow(shape.radius, 2);
        area.add(res);
      }
      return area.reduce((x, y) => x + y);
    }
  } */
}

class SumCalcOutputter {
  var shapes = [Circle(1), Square(3)];
  var areas = AreaCalculator;
}
