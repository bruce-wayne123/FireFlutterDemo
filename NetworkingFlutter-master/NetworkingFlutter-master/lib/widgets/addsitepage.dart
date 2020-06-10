import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:networking_demo/database/database.dart';
import 'package:networking_demo/models/sites.dart';


class AddListStatePage extends State<AddListPage> {
  TextEditingController siteController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController noteController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(title: new Text("Add Site")),
      body: new Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          new TextFormField(
            keyboardType: TextInputType.multiline,
            autofocus: false,
            maxLength: null,
            textInputAction: TextInputAction.next,
            maxLines: null,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Enter site';
              }
              return null;
            },
            controller: siteController,
            decoration: InputDecoration(
                hintText: "Enter Site name",
                border: new OutlineInputBorder(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(10)))),
          ),
          new SizedBox(
            height: 50,
          ),
          new TextField(
            controller: addressController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                hintText: "Enter Address",
                border: new OutlineInputBorder(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(10)))),
          ),
          new SizedBox(
            height: 50,
          ),
          new TextFormField(
            controller: noteController,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                hintText: "Enter Notes",
                border: new OutlineInputBorder(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(10)))),
          ),
          new Expanded(
              child: new Align(
                  alignment: Alignment.bottomCenter,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          width: 150,
                          height: 60,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: new FlatButton(
                                onPressed: () {
                                  saveSite();
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(color: Colors.red)),
                                child: Text(
                                  "Save",
                                  style: new TextStyle(fontSize: 15),
                                ),
                                disabledColor: Colors.red,
                                disabledTextColor: Colors.white,
                                focusColor: Colors.orange,
                              ))),
                      SizedBox(
                          width: 150,
                          height: 60,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: new FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(color: Colors.red)),
                                onPressed: null,
                                child: Text(
                                  "Back",
                                  style: new TextStyle(fontSize: 15),
                                ),
                                disabledColor: Colors.red,
                                disabledTextColor: Colors.white,
                                focusColor: Colors.orange,
                              ))),
                    ],
                  ))),
        ],
      ),
    );
  }
  saveSite() {
    try {
      if (siteController.text.isEmpty ||
          addressController.text.isEmpty ||
          noteController.text.isEmpty) {

        Fluttertoast.showToast(
            msg: "Please fill all the fields",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }
      var site = new Sites(siteController.text, addressController.text,
          noteController.text, DateTime.now().toString(), 3);
      DbProvider.db.addRecord("SITES", site);
      Fluttertoast.showToast(
          msg: "Site added successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);

    } catch (saveExc) {
      Fluttertoast.showToast(
          msg: "Something went wrong!!Please try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}

class AddListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddListStatePage();
  }

 

}
