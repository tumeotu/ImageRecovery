import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/language/localization/app_translations.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/progress_loading.dart';
import 'package:image_recovery/pages/FilterHome/bloc/FilterHomeBloc.dart';
import 'package:image_recovery/pages/FilterHome/state/FilterHomeState.dart';
import 'package:image_recovery/pages/home/model/bottomSheet.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class FilterHomePage extends StatefulWidget {
  @override
  _FilterHomePageState createState() => _FilterHomePageState();
}

class _FilterHomePageState extends State<FilterHomePage> {

  final _navigation = GetIt.instance.get<NavigationDataSource>();
  double height;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: _getCustomBody(),
        )
      ),
    );
  }

  _getCustomBody() {
    return BlocBuilder<FilterHomeBloc, FilterHomeState>(
      builder: (context, state) {
        if (state is FilterHomeStateInitial) {
          return ProgressLoading();
        } 
        else if(state is FilterHomeStateStart)
          {
            return _getCustomBodyView();
          }
        return Container();
      },
    );
  }

  _getCustomBodyView() {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [Color(0xff56AAE7), Colors.white],
                  center: Alignment(1.2, 0.6),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [Color(0xff56AAE7), Colors.white],
                  center: Alignment(-1.2, -0.2),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: (){
                showCupertinoModalBottomSheet(
                      expand: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context, scroll) => ModalInsideModal(
                    multi: false,
                  ));
                },
              child: Container(
                height: MediaQuery.of(context).size.height*0.5,
                width: MediaQuery.of(context).size.width*0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2 - 20,
                                height: MediaQuery.of(context).size.width / 2 / 0.6625,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width / 2 - 14,
                                      height: MediaQuery.of(context).size.width /
                                          2 /
                                          0.6625,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.1),
                                        border: Border.all(
                                            color: Theme.of(context).primaryColor,
                                            width: 3),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Opacity(
                                            opacity: 1,
                                            child: Image.asset(
                                              'images/filter.webp',
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 60.0),
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Theme.of(context).primaryColor,
                                                  width: 1),
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.1),
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Icon(
                                              Icons.image,
                                              color: Colors.blue,
                                              size: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              "Filters",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
