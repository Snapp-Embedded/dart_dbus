import 'package:dbus/dbus.dart';

Future<void> main() async {
  final client = DBusClient.session();
  final object = DBusRemoteObject(client,
      name: 'de.snapp.CoSensorService', path: DBusObjectPath('/Sensor'));

  final response = await object.callMethod(
      'de.snapp.SensorInterface', 'GetSensorValue', [],
      replySignature: DBusSignature('as'));

  /// convert DBusArray to List
  final result = List.from(response.values[0].asStringArray());

  print('temp: ${result[0]}');
  print('hum: ${result[1]}');
  print('co2: ${result[2]}');

  await client.close();
}
