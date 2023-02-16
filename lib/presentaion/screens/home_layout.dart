import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_contacts_app/business_logic/app_cubit.dart';
import 'package:my_contacts_app/presentaion/styles/colors.dart';
import 'package:my_contacts_app/presentaion/widgets/default_form_field.dart';
import 'package:my_contacts_app/presentaion/widgets/default_phone_form_field.dart';
import 'package:my_contacts_app/presentaion/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  late AppCubit cubit;
var scaffoldKey =GlobalKey<ScaffoldState>();
var formKey =GlobalKey<FormState>();
var nameController =TextEditingController();
var phoneNumberController =TextEditingController();
 var myCountryCode =CountryCode(name: 'eg',dialCode:  '+20');

  @override
  void initState() {
    cubit = AppCubit.get(context);
    // TODO: implement initState
    cubit.createDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is AppInsertContactsState){
          Navigator.pop;
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          extendBody: true,
          appBar: AppBar(
backgroundColor: darkSkyBlue,
centerTitle: true,
            title: DefaultText(
                text:cubit.appBarTitles[cubit.currentIndex],
                 color: Colors.lightBlueAccent,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 16.sp,

            ),
          ),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                  begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                      colors: [
                        skyBlue,
                        lightPurple,
                        skyBlue,
                      ]
                  )
                  ,
                ),
              ),
              cubit.screens[cubit.currentIndex],
            ],
          ),
          floatingActionButton: Visibility(
            visible: cubit.currentIndex == 0,
            child: FloatingActionButton(
                onPressed: ()async{
                  if(cubit.isBottomSheetShown){
                    if(formKey.currentState!.validate()){
                      await cubit.insertToDatabase(
                          name: nameController.text, phoneNumber:'${myCountryCode.dialCode}${phoneNumberController.text}',
                      );
                      nameController.text='';
                      phoneNumberController.text ='';
                    };
                  }else{
                    scaffoldKey.currentState!.showBottomSheet((context) =>
                    Wrap(
                      children: [
                        Container(
                          color: darkSkyBlue,
                          padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 3.w),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:EdgeInsets.only(bottom: 1.h),
                                  child: DefaultFormField(
                                      controller: nameController, keyboardType: TextInputType.name,
                               validator: (value){
                                   if(value!.isEmpty){
                                       return "Name can't be empty";
                                   }
                               },
                                    textColor: Colors.white,
                                    prefixIcon: Icon(Icons.title),
                                    hintText: "contact name",
                                  ),
                                ),
                                DefaultPhoneFormField(
                                    controller: phoneNumberController,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "phone number can't be empty";
                                    }
                                    return null;
                                  },
                                  labelText: 'contact phone number',
                                  labelColor: Colors.white,
                                  textColor: Colors.white,
                                  onChange: (countryCode){
                                      myCountryCode =countryCode;
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                    ).closed.then((value) {
                      cubit.changeBottomSheetState(isShown: false, icon:Icons.person_add);
                    });
                    cubit.changeBottomSheetState(isShown: true, icon: Icons.add);
                  }
                },
                 backgroundColor: darkSkyBlue,
              elevation: 20, 
              child: Icon(cubit.floatingActionButtonIcon,color: Colors.lightBlue,),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            color: darkSkyBlue,
            elevation: 0,
            shape: const CircularNotchedRectangle(),
            notchMargin: 10,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              selectedItemColor: Colors.lightBlue,
              unselectedItemColor: Colors.grey ,
              elevation: 0,
              currentIndex: cubit.currentIndex,
              onTap: (index)=>cubit.changeIndex(index),
              items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.contacts_outlined,),
                    label: cubit.appBarTitles[cubit.currentIndex],
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite,),
                    label: "favoirites",
                  ),
                ],
            ),
          ),
        );
      },
    );
  }
}
