import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_contacts_app/presentaion/screens/favourites_screen.dart';
import 'package:sqflite/sqflite.dart';

import '../presentaion/screens/contacts_screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context)=>BlocProvider.of<AppCubit>(context);
  int  currentIndex =0;
IconData floatingActionButtonIcon =Icons.person_add;

bool isBottomSheetShown =false;
  List<Widget>  screens =[
   ContactsScreen(),
  FavouritesScreen(),
];

List<String> appBarTitles =[
  'Contacts',
  'Favourites',
];

List<Map> contacts=[];
List<Map> favouritrs=[];


void changeIndex(int index){
  currentIndex =index;
  emit(AppChangeBottomNavBarState());
}

void changeBottomSheetState({required bool isShown,required IconData icon,}){
isBottomSheetShown =isShown;
floatingActionButtonIcon =icon;
emit(ChangeBottomSheetState());
}
late Database database;
void createDatabase(){
  openDatabase(
  "contacts.db",
    version: 1,
    onCreate: (database,version){
    if (kDebugMode) {
      print("data base created");
    }
    database.execute("CREATE TABLE contacts (id INTEGER PRIMARY KEY,name TEXT,phoneNumber TEXT,status TEXT)").
    then((value) {
        if (kDebugMode) {
          print("table Created");
        }
    }).catchError((error) {
      if (kDebugMode) {
        print("error while creating table $error");
      }
    });
  },onOpen: (database){
    getContacts(database);
    if (kDebugMode) {
      print("database open");
    }
  }

  ).then((value) {
    database =value;
    emit(AppCreatedDatabaseState());
  });
}

void getContacts(Database database){
  contacts =[];
  favouritrs =[];
  database.rawQuery('SELECT * FROM contacts').then((value) {
    for (var element in value) {
      contacts.add(element);
      if(element['status'] == 'favourite'){
        favouritrs.add(element);
      }
    }
  });
  emit(AppGetDatabaseState());
}
 insertToDatabase({required String name,required String phoneNumber})async{
await database.transaction((txn) {
  return txn.rawInsert('INSERT INTO contacts (name ,phoneNumber,status) VALUES("$name","$phoneNumber","all")')
  .then((value) {
    if (kDebugMode) {
      print("contacts $value succesfuly insert");
    }emit(AppInsertContactsState());
  getContacts(database);
  }).catchError((error) {
    if (kDebugMode) {
      print("error while inserting contacts $error");
    }
    });
});
}

}













