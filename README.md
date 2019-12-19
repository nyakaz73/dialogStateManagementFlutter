# dialogStateManagementFlutter - using Providers and ChangeNotifiers
Flutter State Management can be somehow difficult to understand for a beginner and somewhat tiresome to learn as it has so many options to achieve the same thing. In this project i am going to show you how you can easily manage your states using Providers and ChangeNotifiers in flutter. I will be using a pop-up Dialog(modal) to manage my states.

## Problem to be solved:
Say you want to have a simple customer registration page and inside this page you have a floating action button that when pressed it pops up a modal / Dialog that allows you to capture fields like name, surname email address etc. Then when you press add/save button you want your Dialog to disapear and then update a listview on your page showing the registered customers pretty simple right!!.
![Screenshot from 2019-12-18 17-08-58](https://user-images.githubusercontent.com/10974454/71097763-37f9b700-21b9-11ea-97bf-fd048da90845.png)![Screenshot from 2019-12-18 17-06-08](https://user-images.githubusercontent.com/10974454/71097558-d20d2f80-21b8-11ea-9fcd-17930e269e24.png)

If you have worked with flutter Dialogs before you probably would have noticed that if you have say a form on a dialog and you want to save the states of your fields on that dialog, you would see that the states of those fields are not updated on your parent class/widget to which the dialog is being called from, which is pretty wierd!!.
Not to worry if you are using flutter dialogs for computations that involves states being changed you probably need to do some state managment handling in your code. Flutter dialogs are treated as indepedent builds so you would imagine that Dialog widget to have its own class or buildContext if you will.

### Solution
To solve this problem im going to use Provider class

1. Firstly you need to wrap your main.dart with a provider, this allows you to register the models or notifier class.
example:
```
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
  ```
  
2. Secondly you need a model that is going to extend a ChangeNotifier Class

This is going to act as an observable class to monitor for changes in that specific class. 
example:
```
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
```
  
The notifyListeners method is going to be responsible for letting widgetsknow if a change in state has occurred.Thus effecting changes on our UI(in this case our customers Page List).

3. Thirdly to listen to changes triggered by our notifyListeners() method you need a Consumer Widget at our UI level to register those changes.The consumer widget will rebuild your UI.
```
Consumer<RegisterCustomerModel>( 
    builder:(context,consumerModel,child)=>consumerModel.customerDetailsList !=null?                                             Text(consumerModel.numberOfCustomers.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25.0,                 color:Colors.green),):null,
)
 ```
 
 End-------------------------------------------
 
 Happy Fluttering!!!!






