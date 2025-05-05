import 'package:get/get.dart';
import 'DBManager.dart';

class MainController extends GetxController{
  DBManager dB = DBManager();
  setDb(){
    dB.initialise();
  }
}