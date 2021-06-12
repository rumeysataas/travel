extension StringExtensions on String {
  String get capitalize => this[0].toUpperCase() + this.substring(1);
  String get avatarValue {
    String value = this;
    List splitted = value.split(' ');
    if (splitted.length == 1) {
      return value[0].toUpperCase();
    } else {
      return (splitted[0][0] as String).toUpperCase() +
          (splitted[1][0] as String).toUpperCase();
    }
  }
}
