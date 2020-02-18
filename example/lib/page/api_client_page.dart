import 'package:cresenity/log.dart';
import 'package:cresenity/network/CApi.dart';
import 'package:cresenity/utils.dart';
import 'package:example/constant/assets.dart';
import 'package:flutter/material.dart';

/**
 * @author Muhammad Harisuddin Thohir <me@harisuddin.com>
 * @since 2020-02-17 21:01
 * @license Ittron Global Teknologi <ittron.co.id>
 */


class ApiClientPage extends StatefulWidget {
  @override
  _ApiClientPageState createState() => _ApiClientPageState();
}

class _ApiClientPageState extends State<ApiClientPage> {
  List<NotificationModel> notificationList = [];
  List<int> shownHeaderIndexList = [];
  ScrollController scrollController = ScrollController();
  String notifGroup = '';
  bool isLoading = false;

  @override
  void initState() {
    initNotification();
    Log('Cresenity API Client');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text('Cresenity API Client'),
        centerTitle: false,
      ),
      body: !isLoading ? notificationList.length > 0 ? RefreshIndicator(
        onRefresh: refresh,
        child: ListView.builder(
            itemCount:notificationList.length,
            physics: AlwaysScrollableScrollPhysics(),
            controller: scrollController,
            itemBuilder: (context, index){
              NotificationModel notificationModel = notificationList[index];
              return NotificationItem(notificationModel);
            }
        ),
      ) : Utils(context).notFound("You Don't have any notification yet!", refresh) : Utils.loading() ,
    );
  }

  Future<void> refresh() async{
    await initNotification();
    await Future.delayed(Duration(seconds: 1));
  }

  initNotification() async {
    notificationList = [];
    notifGroup = '';
    await CApi.of(context).request('GetNotification', scrollController: scrollController,
        onLoading: (val){
          setState(() {
            isLoading = val;
          });
        },
        parameter: {
          'sessionId': '202001231752595e297b0b9d1ab',
        }, onSuccess: (data){
          data['items'].forEach((val){
            if(val['notifGroup'] == notifGroup){
              val['notifGroup'] = '';
            }else{
              notifGroup = val['notifGroup'];
            }
            notificationList.add(NotificationModel.fromJson(val));
          });
          setState(() {});
        });
  }
}

class NotificationModel {
  String notificationId;
  String subject;
  String message;
  String created;
  String notifGroup;
  String statusRead;
  String timeAgo;

  NotificationModel(
      {this.notificationId,
        this.subject,
        this.message,
        this.created,
        this.notifGroup,
        this.statusRead,
        this.timeAgo});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    notificationId = json['notificationId'];
    subject = json['subject'];
    message = json['message'];
    created = json['created'];
    notifGroup = json['notifGroup'];
    statusRead = json['statusRead'];
    timeAgo = json['timeAgo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notificationId'] = this.notificationId;
    data['subject'] = this.subject;
    data['message'] = this.message;
    data['created'] = this.created;
    data['notifGroup'] = this.notifGroup;
    data['statusRead'] = this.statusRead;
    data['timeAgo'] = this.timeAgo;
    return data;
  }
}

class NotificationItem extends StatelessWidget {
  String headerTitle = "";
  NotificationModel notification;

  NotificationItem(this.notification);

  _header(){
    return Container(
      padding: EdgeInsets.only(left: 8, top: 18, bottom: 8),
      child: Align(
        child: Text(headerTitle,
          style: TextStyle(
              color: Colors.black,
              fontSize: 16
          ),
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch(notification.notifGroup ?? '') {
      case 'new':
        headerTitle = "New";
        break;
      case 'today':
        headerTitle = "Today";
        break;
      case 'thisWeek':
        headerTitle = "This Week";
        break;
      case 'thisMonth':
        headerTitle = "This Month";
        break;
      case 'earlier':
        headerTitle = "Earlier";
        break;
      default:
        headerTitle = "";
        break;
    }
    return Container(
      child: Column(
        children: <Widget>[
          notification.notifGroup != '' ? _header() : Container(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 55,
                  width: 55,
                  child: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(Assets.app_logo)
//                    CachedNetworkImageProvider(notification.memberImage),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: notification.subject + " ", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black)),
                                notification.message != "" ? TextSpan(text: " : \"" + notification.message + "\" ", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14, color: Colors.black)): TextSpan(),
                                TextSpan(text: notification.timeAgo, style: TextStyle(fontSize: 12, color: Colors.grey)),
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}