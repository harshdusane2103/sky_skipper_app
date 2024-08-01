
import 'package:flutter/cupertino.dart';

import 'package:sky_skipper_app/API/api.dart';
import 'package:sky_skipper_app/Modal/Modal.dart';
// import 'package:shared_preferences/shared_preferences.dart';



class HomeProvider extends ChangeNotifier {
  List weather =[];
WeatherModal? weatherModal;
  String search = "Surat";
  int selectedIndex = 0;

  void Searchweather(String search) {
   this.search  = search;
    notifyListeners();
  }

  void SelectedImage(int index) {
    selectedIndex = index;
    notifyListeners();
  }



Future<WeatherModal?> fromMap(String search) async {
  Map<String, dynamic> data = await ApiHelper.apihelper.fetchApiData(search: search);
    weatherModal = WeatherModal.fromJson(data);
    return weatherModal;
  }

  Future<void> AddToFav(String name,double temp_c,String text)
  async {
    String data="$name $temp_c $text";
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    weather.add(data);
    // preferences.setStringList('weather',(data));



  }
  getFavouriteWeather()
  async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // weather=preferences.getStringList('weather') ??<String>[];
    notifyListeners();
  }
  HomeProvider()
  {
    getFavouriteWeather();
  }
}


// Future<void> setwallpapre(String url) async {
//   String result;
//   bool goToHome = false;
//   try {
//     result = await AsyncWallpaper.setWallpaper(
//       url: url,
//       wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
//       goToHome: goToHome,
//       toastDetails: ToastDetails.success(),
//       errorToastDetails: ToastDetails.error(),
//     )
//         ? 'Wallpaper set'
//         : 'Failed to set wallpaper.';
//   } on PlatformException {
//     result = 'Failed to set wallpaper.';
//   }
// }
