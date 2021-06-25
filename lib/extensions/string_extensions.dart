extension StringExtensions on String {
  //Burada sadece string altından ulaşabileceğimiz extensionlar oluşturduk
  String get capitalize => this[0].toUpperCase() + this.substring(1);  //ilk harf büyük diğer harfler küçük
  String get avatarValue {
    String value = this;
    //avatar için ilk karakter eğer resim yoksa
    List splitted = value.split(' ');
    if (splitted.length == 1) {
      return value[0].toUpperCase();
    } else {
      return (splitted[0][0] as String).toUpperCase() +
          (splitted[1][0] as String).toUpperCase();
    }
  }
}
