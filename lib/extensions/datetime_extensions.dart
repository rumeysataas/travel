extension DateTimeExtensions on DateTime {

  //Extensionlar ile kısayollar oluşturabiliriz
  // Burada sadece datetime nesnesinin altından ulaşabileceğimiz bir extension oluşturduk
  String get getPublishTime => "${this.day}/${this.month}/${this.year}";
}
