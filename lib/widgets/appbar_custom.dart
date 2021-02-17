import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';

class AppBarCustom extends StatelessWidget {
  final title,
      startColor,
      endColor,
      endTitle,
      iconEnd,
      iconMenu,
      iconCancel,
      iconStart,
      actionLeftIcon,
      actionCancel,
      actionLightIcon;
  final VoidCallback actionRightTitle;
  const AppBarCustom(
      {Key key,
      this.title,
      this.startColor,
      this.endColor,
      this.endTitle,
      this.iconStart,
      this.iconMenu,
      this.iconEnd,
      this.iconCancel,
      this.actionLeftIcon,
      this.actionRightTitle,
      this.actionCancel,
      this.actionLightIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            startColor,
            endColor,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _getViewIconStart(context,iconMenu, iconStart),
            iconCancel != null
                ? IconButton(
                    icon: Icon(iconCancel),
                    color: Colors.white,
                    onPressed: () {
                      actionCancel();
                    })
                : SizedBox(
                    width: 0,
                    height: 0,
                  ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            IconButton(
                icon: iconEnd==null?Icon(null):iconEnd,
                color: Colors.white,
                onPressed: () {
                  actionLightIcon();
                }),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: (){
                actionRightTitle();
              },
              child: Text(
                endTitle,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getViewIconStart(context, iconMenu, iconStart) {
    if(iconStart!=null)
      {
        return IconButton(
            icon: Icon(
                iconStart,
              size: 35,
            ),
            color: Colors.white,
            onPressed: () {
              if(iconStart!=null){
                try {
                  if (actionLeftIcon()) {
                    GetIt.instance<NavigationDataSource>().popNavigation(context);
                  } else
                    actionLeftIcon();
                } catch (error) {
                  GetIt.instance<NavigationDataSource>().popNavigation(context);
                }
              }
            });
      }
    else if(iconMenu!=null)
      {
        return IconButton(
            icon: Icon(
                iconMenu,
              size: 35,
            ),
            color: Colors.white,
            onPressed: () {
              if(iconMenu!=null){
                try {
                  if (actionLeftIcon()) {
                    Scaffold.of(context).openDrawer();
                  } else
                    actionLeftIcon();
                } catch (error) {
                  Scaffold.of(context).openDrawer();
                }
              }
            });
      }
  }
}
