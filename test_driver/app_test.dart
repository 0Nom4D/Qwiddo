import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  //nos éléments
  final text_connect = find.text('Connect to Redditech');
  final text_description = find.text("Redditech\nRedditech is an application you can use such as the Reddit app with limited features.");
  final button = find.byTooltip('Connection');

  //créer un driver
  late FlutterDriver flutterDriver;
  
  //le mettre en place
  setUpAll(() async {
    flutterDriver = await FlutterDriver.connect();
    await flutterDriver.waitUntilFirstFrameRasterized();
  });

  //le supprime
  tearDownAll(() async {
    flutterDriver.close();
  });

  //tests
  test('se connecter à Redditech', () async {
    await flutterDriver.tap(button);
  });
}