import 'package:test/test.dart';

void main() {
  test('First test', () {
    var string = 'foo,bar,baz';
    expect(string.split(','), equals(['foo', 'bar', 'baz']));
  });
}
