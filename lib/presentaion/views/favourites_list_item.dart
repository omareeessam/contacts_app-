import 'package:flutter/material.dart';
import 'package:my_contacts_app/presentaion/styles/colors.dart';
import 'package:my_contacts_app/presentaion/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class FavouritesListItem extends StatelessWidget {
  FavouritesListItem({Key? key, required this.model}) : super(key: key);
  final Map model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp),
          gradient: LinearGradient(
              begin: AlignmentDirectional.centerEnd,
              end: AlignmentDirectional.centerEnd,
              colors: [
                lightPurple,
                Colors.black,
                lightPurple,
              ])),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(start: 2.w),
                      child: DefaultText(
                        text: "${model['name']}",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        maxLines: 1,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Flexible(
                    child: DefaultText(
                      text: "${model['phoneNumber']}",
                      fontSize: 14.sp,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
