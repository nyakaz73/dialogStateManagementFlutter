# dialogStateManagementFlutter - using Providers and ChangeNotifiers
Flutter State Management can be somehow difficult to understand for a beginner and somewhat tiresome to learn as you will have so many options to archive the same thing. In this project i am going to show you how you can easily manage your states using Providers and ChangeNotifiers in flutter. I will be using a pop-up Dialog(modal) to manage my states

# Problem to be solved:
Say you want to have a simple customer registration page and inside this page you have a floating action button thats when pressed it pops up a modal / Dialog that allows you to capture fields like name, surname email address etc. Then when you press add button/ save on you Dialog you want your dialog to disapear and then update a listview on your page showing the registered customers pretty simple right!!.

If you have worked with flutter dialogs before you probalbly would have noticed that if you have say a form on that dialog and you want to save the states of your fields on that dialog you would see that the states of those fields are not updated on your parent class/widget to which the dialog is being called from, which is pretty wierd!!.
Not to worry if you are using flutter dialogs for computations that envolves states being changed you probably need to do some state managment handling in your code. Flutter dialogs are treated as indepedent builds so you would imagine that Dialog widget to have its own class or buildContext if you will.

To solve this problem im going to use Provider class

1. Firstly you need to wrap your main.dart with a provider this allows you to register the models or notifier class which we would want to listen to changes from
example:
Widget build(BuildContext context) {

    return ChangeNotifierProvider<RegisterCustomerModel>(
      builder: (context) => RegisterCustomerModel(),
      child:  MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: LandingPage(),
      ),
    );
    
  }
  
2. Secondly you need a model that is going to extend a ChangeNotifier Class

This is going to act as an obbervable class to monitor for changes which would have happened in that specific class. 
example:
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
}
  
The notifyListeners method is going to be responsible for letting widgets which are uptop the state stack know if a change in state has occurred in this class effecting changes on our UI(in this case our customers Page).

3. Thirdly to listen to changes which would have been triggered by our notifyListeners() method you need a Consumer Widget at our UI level to register those changes on your UI.The consumer widget will rebuild you UI
Consumer<RegisterCustomerModel>(
    
    builder:(context,consumerModel,child)=>consumerModel.customerDetailsList !=null?Text(consumerModel.numberOfCustomers.toString(),
       style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25.0, color:              Colors.green),):null,
 )
 
 End-------------------------------------------
 
 Happy Fluttering!!!!






