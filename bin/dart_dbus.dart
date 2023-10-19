import 'package:dbus/dbus.dart';

Future<void> main() async {
  final client = DBusClient.session();
  final object = DBusRemoteObject(client,
      name: 'com.example.SampleService', path: DBusObjectPath('/SomeObject'));

  final response = await object.callMethod(
      'com.example.SampleInterface', 'GetSensorValue', [],
      replySignature: DBusSignature('as'));

  /// convert DBusArray to List
  final result = List.from(response.values[0].asStringArray());

  final temp = result[0];
  final hum = result[1];
  final pressure = result[2];

  print('temp: $temp');
  print('hum: $hum');
  print('pressure: $pressure');

  await client.close();
}
