import 'package:flutter/material.dart';
import 'constants.dart';

class RegisterCustomerModel extends ChangeNotifier{

  List<CustomerDetails> _customerDetailsList = new List();

  List<CustomerDetails> get customerDetailsList => _customerDetailsList;
  int get numberOfCustomers => _customerDetailsList.length;


  void addCustomer(CustomerDetails details){
    _customerDetailsList.add(details);print(
    _customerDetailsList.map((s){
      return s.full_name;
    }));
    notifyListeners();
  }
  
  void removeCustomer(int index){
    _customerDetailsList.removeAt(index);
    notifyListeners();
  }
}
