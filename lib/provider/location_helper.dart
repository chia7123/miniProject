import 'package:flutter/foundation.dart';

const GOOGLE_API_KEY = 'AIzaSyDK1MPHDYW8yiRIJEAhrk1IoiP9RB2-4zU';

class LocationHelper{
  static String generateLocationPreviewImage({@required double latitude, @required double longitude}){
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}