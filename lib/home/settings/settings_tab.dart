import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';
class SettingsTab extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Language'
            //AppLocalizations.of(context)!.language,
            ,style: Theme.of(context).textTheme.bodyMedium,),
          SizedBox(height: 15,),
          InkWell(
            onTap: (){
              // showLanguageBottomSheet();
            },
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('English'
                    //provider.applanguage == 'en' ?
                    //AppLocalizations.of(context)!.english :
                    //AppLocalizations.of(context)!.arabic ,
                    ,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.whiteColor
                    ),),
                  Icon(Icons.arrow_drop_down , size: 40,)
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Text('Theme'//AppLocalizations.of(context)!.theme,
            ,style: Theme.of(context).textTheme.bodyMedium,),
          SizedBox(height: 15,),
          InkWell(
            onTap: (){
              //showthemeBottomSheet();
            },
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('light',
                    //provider.appTheme == ThemeMode.dark ?
                    // AppLocalizations.of(context)!.dark :
                    //AppLocalizations.of(context)!.light ,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.whiteColor
                    ),
                  ),
                  Icon(Icons.arrow_drop_down , size: 40,)
                ],
              ),
            ),
          )
        ],
      ),
    );

  }
  }

