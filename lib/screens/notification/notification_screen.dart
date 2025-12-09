import 'dart:convert';
import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/components/appbar_component.dart';
import 'package:demo_users_app/components/button_component.dart';
import 'package:demo_users_app/components/textfield_component.dart';
import 'package:demo_users_app/extension.dart';
import 'package:demo_users_app/main.dart';
import 'package:demo_users_app/screens/notification/model/notification_model.dart';
import 'package:demo_users_app/screens/notification/notification_service.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  double opacity = 0;
  DateTime dateTime = DateTime.now();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  FocusNode titlefocusnode = FocusNode();
  FocusNode descriptionfocusnode = FocusNode();
  bool isfromschedule = false;
  late List<NotificationModel> notificationlist;

  @override
  void initState() {
    // TODO: implement initState
    loadNotifications();
    super.initState();
  }

  void loadNotifications() async {
    notificationlist = await getNotificationList();
    setState(() {

    });
  }

  Future<List<NotificationModel>> getNotificationList() async {
    final raw = sharedprefshelper.getData(LocalStorageKeys.notifications);

    if (raw == null) return [];

    final decoded = jsonDecode(raw) as List;
    List<NotificationModel> list =
    decoded.map((e) => NotificationModel.fromJson(e)).toList();

    DateTime now = DateTime.now();
    bool changed = false;

    for (var item in list) {
      if (item.isScheduled == true) {

        if (item.scheduledTime != null) {
          DateTime scheduled = DateTime.parse(item.scheduledTime!);

          // If current time is greater than scheduled time, mark as fired
          if (now.isAfter(scheduled)) {
            item.isFired = true;
            changed = true;
          }
        }
      }
    }

    // Save changes back to storage only if something updated
    if (changed) {
      final jsonList = list.map((e) => e.toJson()).toList();
      await sharedprefshelper.saveData(
          LocalStorageKeys.notifications, jsonEncode(jsonList));
    }

    return list;
  }

  Future<void> saveNotificationList(List<NotificationModel> list) async {
    final jsonList = list.map((e) => e.toJson()).toList();
    await sharedprefshelper.saveData(LocalStorageKeys.notifications, jsonEncode(jsonList));
  }

  Future<void> addNotification(NotificationModel model) async {
    List<NotificationModel> list = await getNotificationList();
    list.add(model);
    await saveNotificationList(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: opacity == 1
          ? AppColors.primarycolor.withValues(alpha: 0.4)
          : null,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: AnimatedOpacity(
          opacity: opacity == 1 ? 0.3 : 1,
          duration: Duration(milliseconds: 250),
          child: IgnorePointer(
            ignoring: opacity == 1, // disable background
            child: AppbarComponent(title: AppLabels.notifications, centertitle: true,
            leading: IconButton(onPressed: () {
              Navigator.pop(context,false);
            }, icon: Icon(Icons.arrow_back_outlined)),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: opacity == 1 ? 0.3 : 1,
              duration: Duration(milliseconds: 250),
              child: IgnorePointer(
                ignoring: opacity == 1, // disable background
                child: RefreshIndicator(
                  color: AppColors.primarycolor,
                  onRefresh: () async{
                    loadNotifications();
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 9,vertical: 5),
                      itemCount: notificationlist.length,
                      itemBuilder: (context, index) {
                        final item = notificationlist[index];
                        return item.isFired! ? Card(
                          elevation: 2,
                          child: ListTile(
                            leading: Icon(item.isScheduled == true
                                ? Icons.calendar_month_outlined
                                : Icons.notifications),
                            title: Text(item.title ?? ''),
                            subtitle: Text(item.description ?? ''),
                            trailing: Text(item.isScheduled! ? AppLabels.scheduled : AppLabels.direct),
                          ),
                        ) : Container();
                      }
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.linearToEaseOut,
              bottom: opacity == 1 ? 80 : -300,
              left: 0,
              right: 6,
              child: AnimatedOpacity(
                opacity: opacity,
                duration: Duration(milliseconds: 300),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  padding: .symmetric(horizontal: AppPadding.lg),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLabels.schedule_notification,
                              style: TextStyle(color: AppColors.whitecolor),
                            ),
                            sbw(10),
                            ElevatedButton(
                              onPressed: () {
                                openDatePicker();
                              },
                              child: Icon(Icons.calendar_month_outlined),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primarycolor,
                                foregroundColor: AppColors.whitecolor,
                                minimumSize: Size(50, 50),
                                maximumSize: Size(50, 50),
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: .circular(AppRadius.lg),
                                ),
                                elevation: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLabels.direct_notification,
                              style: TextStyle(color: AppColors.whitecolor),
                            ),
                            sbw(10),
                            ElevatedButton(
                              onPressed: () {
                                isfromschedule = false;
                                showDialog(context: context, builder: alertDialogWidget);
                              },
                              child: Icon(Icons.notifications_outlined),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primarycolor,
                                foregroundColor: AppColors.whitecolor,
                                minimumSize: Size(50, 50),
                                maximumSize: Size(50, 50),
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: .circular(AppRadius.lg),
                                ),
                                elevation: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          opacity = opacity == 0 ? 1 : 0;
          setState(() {});
        },
        child: Icon(
          opacity == 1 ? Icons.close : Icons.add,
          color: AppColors.primarycolor,
        ),
      ),
    ).onTapEvent(() {
      opacity = 0;
      setState(() {});
    });
  }

  Widget alertDialogWidget(BuildContext dialogContext) {
    return AlertDialog(
      titlePadding: .only(
        left: AppPadding.xl,
        right: AppPadding.xl,
        top: AppPadding.xl,
        bottom: AppPadding.md,
      ),
      actionsPadding: .symmetric(
        horizontal: AppPadding.xl,
        vertical: AppPadding.md,
      ),
      contentPadding: .symmetric(
        horizontal: AppPadding.xl,
        vertical: AppPadding.sm,
      ),
      title:Text('Notification Details',textAlign: TextAlign.center,),
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextfieldComponent(
              focusnode: titlefocusnode,
              controller: titlecontroller,
              label: AppLabels.title,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(titlefocusnode);
              },
            ),
            sb(20),
            TextfieldComponent(
              focusnode: descriptionfocusnode,
              controller: descriptioncontroller,
              hinttext: AppLabels.description,
              label: AppLabels.description,
              maxLines: 2,
            ),
            if(isfromschedule)
              Column(
                children: [
                  sb(10),
                  Text("${AppStrings.scheduled_date} ${dateTime.toDateTimeString()}",style: TextStyle(color: AppColors.greencolor,fontFamily: Appfonts.robotobold),),
                  sb(15),
                ],
              )
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonComponent(
              ontap: () {
                opacity = 0;
                Navigator.pop(dialogContext);
                setState(() {

                });
              },
              buttontitle: AppLabels.cancel,
              bgcolor: AppColors.greywithshade.withValues(alpha: 0.2),
              width: 100,
            ),
            ButtonComponent(
              ontap: () async {
                if (isfromschedule) {
                  final model = NotificationModel(
                    id: (notificationlist.length + 1).toString(),
                    title: titlecontroller.text,
                    description: descriptioncontroller.text,
                    isScheduled: isfromschedule,
                    scheduledTime: dateTime.toIso8601String(),
                    isFired: false,
                  );

                  await addNotification(model);
                  NotificationService().scheduleNotification(model);
                  Cm.showSnackBar(context, message: "${AppStrings.notification_scheduled_on} ${dateTime.toDateTimeString()}",bg: AppColors.greencolor);
                } else {
                  final model = NotificationModel(
                    id: (notificationlist.length + 1).toString(),
                    title: titlecontroller.text,
                    description: descriptioncontroller.text,
                    isScheduled: false,
                    scheduledTime: null,
                    isFired: true,
                  );

                  await addNotification(model);
                  NotificationService().showInstantNotification(model);
                }
                titlecontroller.clear();
                descriptioncontroller.clear();
                Navigator.pop(dialogContext);
                opacity = 0;
                loadNotifications();
                setState(() {});
              },
              buttontitle: AppLabels.submit,
              bgcolor: AppColors.primarycolor,
              width: 90,
            ),
          ],
        ),
      ],
    );
  }

  void openDatePicker() {
    DateTime date = DateTime.now();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.40,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  AppStrings.select_date,
                  style: TextStyle(
                    fontSize: AppFontSizes.xxl,
                    fontFamily: Appfonts.robotobold,
                  ),
                ),
              ),
              Divider(height: 1),

              Expanded(
                child: CupertinoDatePicker(
                  minimumDate: DateTime.now(),
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (value) {
                    date = value;
                    setState(() {});
                  },
                ),
              ),

              ButtonComponent(
                buttontitle: AppLabels.next,
                ontap: () {
                  Navigator.pop(context);
                  dateTime = date;
                  openTimePicker();
                  setState(() {});
                },
              ).withPadding(padding: EdgeInsets.symmetric(horizontal: 20)),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void openTimePicker() {
    DateTime now = DateTime.now();
    DateTime time = DateTime(dateTime.year,dateTime.month,dateTime.day,now.hour,now.minute,0);
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.40,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  AppStrings.select_time,
                  style: TextStyle(
                    fontSize: AppFontSizes.xxl,
                    fontFamily: Appfonts.robotobold,
                  ),
                ),
              ),
              Divider(height: 1),
              Expanded(
                child: CupertinoDatePicker(
                  minimumDate: DateTime.now(),
                  initialDateTime: DateTime.now(),
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (value) {
                    time = value;
                    setState(() {});
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ButtonComponent(
                  buttontitle: AppLabels.next,
                  ontap: () {
                    Navigator.pop(context);
                    isfromschedule = true;
                    showDialog(context: context, builder: alertDialogWidget);
                    dateTime = DateTime(dateTime.year,dateTime.month,dateTime.day,time.hour,time.minute,time.second) ;
                    print("FINAL DATETIME → $dateTime");
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}