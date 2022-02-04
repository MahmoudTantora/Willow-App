import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:willow_care_app/controllers/botom_tab/bottom_tab_cubit.dart';
import 'package:willow_care_app/controllers/schedule_tab/schedule_tab_cubit.dart';
import 'package:willow_care_app/screens/app/app_screen.dart';
import 'package:willow_care_app/screens/doctor_profile/doctor_profile_screen.dart';
import 'package:willow_care_app/screens/schedule/schedule_screen.dart';
import 'package:willow_care_app/services/schedules_api.dart';
import 'package:willow_care_app/theme/app_colors.dart';

import 'controllers/schedule/schedule_cubit.dart';

void main() {
  runApp(const WillowCareApp());
}

class WillowCareApp extends StatefulWidget {
  const WillowCareApp({Key? key}) : super(key: key);

  @override
  State<WillowCareApp> createState() => _WillowCareAppState();
}

class _WillowCareAppState extends State<WillowCareApp> {
  late ScheduleApi scheduleApi;

  @override
  void initState() {
    scheduleApi = ScheduleApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BottomTabCubit(),
          ),
          BlocProvider(
            create: (context) => ScheduleTabCubit(),
          ),
          BlocProvider(
            create: (context) => ScheduleCubit(scheduleApi)..getAllSchedules(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: AppColors.primaryColor,
            textTheme:
                TextTheme(bodyText2: TextStyle(color: AppColors.appTextColor)),
          ),
          builder: (context, widget) {
            ScreenUtil.setContext(context);
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget ?? const SizedBox(),
            );
          },
          initialRoute: AppScreen.routeName,
          routes: {
            AppScreen.routeName: (context) => const AppScreen(),
            ScheduleScreen.routeName: (context) => const ScheduleScreen(),
            DoctorProfileScreen.routeName: (context) =>
                const DoctorProfileScreen(),
          },
          //home: const AppScreen(),
        ),
      ),
    );
  }
}
