extension DateTimeExtensions on DateTime {
  String get getPublishTime => "${this.day}/${this.month}/${this.year}";
}
