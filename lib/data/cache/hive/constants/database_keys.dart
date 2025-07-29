// ignore_for_file: constant_identifier_names

enum DatabaseKeys {
  TOKEN('token'),
  EVENTS_MAIN('eventsmain'),
  STRING_FCM_TOKEN('fcmtoken');

  final String value;
  const DatabaseKeys(this.value);
}
