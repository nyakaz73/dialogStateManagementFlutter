import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'models/constants.dart';
import 'models/register_customer.dart';
class LandingPage extends StatefulWidget{
  @override
  State createState()=> LandingPageState();
}

class LandingPageState extends State<LandingPage>{

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Customer Registration",style: TextStyle(fontWeight: FontWeight.w300),),
        backgroundColor: Colors.red.shade400,
      ),
      body: new Column(
        children: <Widget>[
          new Padding(
              padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Total Members:",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 22.0),textAlign: TextAlign.left,),
                ),

                new Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Consumer<RegisterCustomerModel>(
                      builder: (context,consumerModel,child)=>consumerModel.customerDetailsList !=null?Text(
                        consumerModel.numberOfCustomers.toString(),
                        style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25.0, color: Colors.green),):null,
                    )
                )
              ],
            ),
          ),
          Consumer<RegisterCustomerModel>(
              builder: (context,customerModel,child)=>Expanded(
                child: new ListView.builder(
                  itemCount: customerModel.customerDetailsList !=null? customerModel.numberOfCustomers:0,
                    itemBuilder: (BuildContext context, int index){
                      return new Padding(
                          padding: EdgeInsets.only(left: 5.0,right: 5.0),
                        child: Card(
                          elevation: 5.0,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Icon(Icons.person_outline),
                            ),
                            title: Text(customerModel.customerDetailsList[index].full_name, style: titleStyle,),
                            subtitle: Text('\$ ${customerModel.customerDetailsList[index].salary.toStringAsFixed(2)}',style: titleStyle,),
                            trailing: new GestureDetector(
                              child: new Icon(Icons.delete, color: Colors.red,),
                              onTap: (){
                                _showAlertDialog('Status', 'Are you sure you want to delete ${customerModel.customerDetailsList[index].full_name.toUpperCase()}',index);
                              },
                            ),
                          ),
                        ),
                      );
                    }
                ),

            ),
          )

        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(context: context,
                builder: (_) => AddCustomerDialog());
          },
        child: Icon(Icons.person_add),
      ),
    );
  }

  void _showAlertDialog(String title, String message, int index){
    AlertDialog alertDialog = AlertDialog(
      title: new Icon(Icons.warning, size: 80.0, color: Colors.amber,),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text('YES',style: TextStyle(color: Colors.red),),
          onPressed: () {
            final register = Provider.of<RegisterCustomerModel>(context);
            register.removeCustomer(index);
            Navigator.of(context).pop();
          },
        ),

        FlatButton(
          child: Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (_)=>alertDialog
    );
  }
}

class AddCustomerDialog extends StatefulWidget{
  @override
  State createState()=> AddCustomerDialogState();

}

class AddCustomerDialogState extends State<AddCustomerDialog>{
  String full_name, salary;
  final formKey = new GlobalKey<FormState>();
  Size deviceSize;

  Widget build(BuildContext context){
    deviceSize = MediaQuery.of(context).size;
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          height: deviceSize.height/2.0,
          child: new Form(
            key: formKey,
            child: new Column(
              children: <Widget>[
                Flexible(

                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Padding(
                            padding: EdgeInsets.only(left:30.0, top: 30.0),
                            child: new Text("Customer Details",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25.0),),
                          ),
                          new Padding(
                            padding: EdgeInsets.all(10.0),
                            child: new ListTile(
                              leading: const Icon(Icons.person_outline),
                              title: new TextFormField(
                                autofocus: false,
                                decoration: InputDecoration(
                                  labelText: "Full Name",
                                ),
                                validator: (value)=> value.isEmpty ? "Fristname cant\'t be empty":null,
                                onSaved: (value)=>full_name = value,
                              ),
                            ),
                          ),


                          new Padding(
                            padding: EdgeInsets.all(10.0),
                            child: new ListTile(
                              leading: const Icon(Icons.attach_money),
                              title: new TextFormField(
                                autofocus: false,
                                initialValue: this.salary,
                                keyboardType:TextInputType.numberWithOptions(),
                                decoration: InputDecoration(
                                  labelText: "Salary",
                                ),
                                validator: (value)=> value.isEmpty ? "Amount No cant\'t be empty":null,
                                onSaved: (value)=>salary = value,
                              ),
                            ),
                          ),




                          new Padding(
                            padding: EdgeInsets.only(right: 0.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[

                                new FlatButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child: new Text("CANCEL",style: TextStyle(color: Colors.red),)
                                ),
                                new FlatButton(
                                    onPressed: (){
                                       addCustomer();
                                    },
                                    child: new Text("ADD",style: TextStyle(color: Colors.blue),)
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
        )
    );
  }

  bool validateAndSave(){
    final form  = formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }

  Future<String> addCustomer() async{
    if(validateAndSave()){
      final register = Provider.of<RegisterCustomerModel>(context);
      register.addCustomer(CustomerDetails(full_name, double.parse(salary)));
      Navigator.pop(context);
    }
    return "Success";
  }
}
