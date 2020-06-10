import 'package:intl/intl.dart';

class Sites {
  int id;
  String siteName;
  String addressName;
  String notes;
  DateTime createdDate;
  String displayDate;
  int panelCount;

  Sites(this.siteName, this.addressName, this.notes, this.displayDate,
      this.panelCount);

  Map<String, dynamic> toMap() => {
        "id": id,
        "siteName": siteName,
        "addressName": addressName,
        "notes": notes,
        "createdDate": createdDate,
        "panelCount": panelCount,
      };

  Sites.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    siteName = map['siteName'];
    addressName = map['addressName'];
    notes = map['notes'];
    createdDate = map['createdDate'];
    panelCount = map['panelCount'];
  }

//CREATE TABLE SITES(id INTEGER PRIMARY KEY AUTOINCREMENT, siteName TEXT, addressName TEXT,notes TEXT,createdDate TEXT,panelCount INTEGER)
}
