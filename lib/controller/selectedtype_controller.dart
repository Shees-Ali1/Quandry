import 'package:get/get.dart';

class SelectedTypeController extends GetxController{
  RxString selectedType='email'.obs;

  changeSelectedType(String newType){
    selectedType.value=newType;
  }
}