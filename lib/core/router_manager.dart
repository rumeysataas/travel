import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Uygulamamızda sayfa yönlendirmeleri için kullanacağımız RouteManager sınıfı
class RouteManager {
  static var routeContext;

  static initializeRoute(BuildContext context) {  //ilk sayfamızda bu fonskiyonumuzu çağırıyoruz ve geçerli rota çalışabilir hale geliyor
    routeContext = context;
  }

  static newPage(Widget view) {                   //yeni bir sayfaya yönlendirmek için
    Navigator.of(routeContext)
        .push(MaterialPageRoute(builder: (routeContext) => view));
  }

  static newPageReplacement(Widget view) {         //yeni bir sayfaya yönlendirmek için fakat geri dönüş yok
    Navigator.of(routeContext)
        .pushReplacement(MaterialPageRoute(builder: (routeContext) => view));
  }

  static backPage() {                            //geri dönmek için yani olumsuz sonuçta baştan yapma vs.
    Navigator.of(routeContext).pop();
  }

  static showErrorDialog(String errorText) {          //oluşabilecek hatalarda göstereceğimiz dialog
    showDialog(
        context: routeContext,
        builder: (_) => AlertDialog(
              title: Text('Ups 🙄'),
              content: Text(errorText),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      RouteManager.backPage();
                    },
                    child: Text('Geri Dön'))
              ],
            ));
  }

//Özel İletişim Kutusu
  static showCustomDialog(String text, List<Widget> actions) {
    showDialog(
        context: routeContext,
        builder: (_) => AlertDialog(
            title: Text('Harika 😊'), content: Text(text), actions: actions));
  }

  static showSearchDelagate(SearchDelegate delegate) {    //arama sayfaları için kullanacağımız fonksiyon
    showSearch(context: routeContext, delegate: delegate);
  }
}
