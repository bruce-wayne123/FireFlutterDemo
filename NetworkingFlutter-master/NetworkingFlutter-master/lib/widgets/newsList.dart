import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:load/load.dart';
import 'package:networking_demo/database/database.dart';
import 'package:networking_demo/models/newsArticle.dart';
import 'package:networking_demo/models/sites.dart';
import 'package:networking_demo/widgets/addsitepage.dart';

class NewsListState extends State<NewsList> {
  List<NewsArticle> _newsArticles = List<NewsArticle>();
  List<Sites> sitesList = List<Sites>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    _populateNewsArticles();
  }

  void _populateNewsArticles() async {
    try {
//      showLoadingDialog();
//      showCustomLoadingWidget(Container());
      sitesList = await DbProvider.db.getAllSites();
//      hideLoadingDialog();
    } catch (loadExc) {
      print(loadExc);
    } finally {}
  }

  Card _buildItemsForListView(BuildContext context, int index) {
    return Card(
        child: new InkWell(
      onLongPress: () {
        showDialog(
            barrierDismissible: false,
            context: context,
            child: new CupertinoAlertDialog(
                title: new Column(
                  children: <Widget>[
                    new FlatButton(
                        onPressed: () {
                          print("TEst");
//showDialog(context: context,
//
//builder:(BuildContext context)
//{
//  return AlertDialog(
//    title: Text('Are You Sure Want To delete the site ?'),
//    actions: <Widget>[
//      FlatButton(
//        child: Text("YES"),
//        onPressed: () {
//          try {
//            DbProvider.db.deleteRecord("SITES", sitesList[index]);
//            Navigator.of(context).pop();
//          }
//          catch(deleteEx)
//{
//  print(deleteEx);
//}
//          }
//  ,
//      ),
//
//      FlatButton(
//        child: Text("NO"),
//        onPressed: () {
//          //Put your code here which you want to execute on No button click.
//          Navigator.of(context).pop();
//        },
//      ),
//    ],
//  );
//});
                        },
                        child: new Text("Delete")),
                    Divider(color: Theme.of(context).primaryColor)
                  ],
                ),
                content: new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text("Update"))));
      },
      child: Expanded(
        child: new Container(
          padding: EdgeInsets.fromLTRB(5, 25, 5, 25),
          width: double.maxFinite,
          child: (new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Column(
                children: [
                  new Text(sitesList[index].siteName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.start),
                  new Text("Panels:" + sitesList[index].panelCount.toString(),
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.start)
                ],
              ),
//                    new Text(sitesList[index].displayDate)
            ],
          )),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sites'),
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: UserAccountsDrawerHeader(
              accountName: Text("Ankush Patil"),
              accountEmail: Text("Jpatila3@jci.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text("Help & Support"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text("Sign Out"),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => (AddListPage())));
        },
      ),
      body: ListView.builder(
        itemCount: sitesList.length,
        itemBuilder: _buildItemsForListView,
      ),
    );
  }
}

class NewsList extends StatefulWidget {
  @override
  createState() => NewsListState();
}
