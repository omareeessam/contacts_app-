import 'package:flutter/material.dart';
import 'package:my_contacts_app/presentaion/views/favourites_list_item.dart';
import 'package:my_contacts_app/presentaion/widgets/default_text.dart';

import 'package:sizer/sizer.dart';
import 'contacts_list_item.dart';

class ContactsListBuilder extends StatelessWidget {
  ContactsListBuilder({
    Key? key,
    required this.contacts,
    required this.noContactsText,
    required this.contactType,
  }) : super(key: key);

  List<Map> contacts;
  String noContactsText;
  String contactType;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: contacts.isNotEmpty,
      replacement: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.no_accounts,
            size: 70.sp,
            color: Colors.white,
          ),
          DefaultText(
            text: noContactsText,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
            color: Colors.white,
          )
        ],
      ),
      child: ListView.separated(
        itemBuilder: (context, index) {
          if (contactType == 'favourite') {
            return FavouritesListItem(
              model: contacts[index],
            );
          } else {
            return ContactsListItem(
              model: contacts[index],
            );
          }
        },
        separatorBuilder: (context, index) => Row(
          children: [
            Expanded(
                child: Divider(
              height: 1.h,
              color: Colors.white,
            ))
          ],
        ),
        itemCount: contacts.length,
      ),

    );
  }
}
