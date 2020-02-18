import 'package:cresenity/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'api_client_page.dart';
import 'coming_soon_page.dart';

/**
 * @author Muhammad Harisuddin Thohir <me@harisuddin.com>
 * @since 2020-02-17 20:58
 * @license Ittron Global Teknologi <ittron.co.id>
 */


class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text('Cresenity Framework'),
      ),
      body: ListView(
        children: <Widget>[
          item(
              title: 'Cresenity API Client',
              subtitle: 'Simple API client support for Cresenity Framework',
              iconData: Icons.backup,
              page: ApiClientPage()

          ),
          item(
            title: 'Page Navigation',
            subtitle: 'Simple way to navigate between page',
            iconData: Icons.mobile_screen_share,
            page: ComingSoonPage(),
          ),
          item(
            title: 'Shared Preference',
            subtitle: 'Simple way to save local variable',
            iconData: Icons.cloud_download,
            page: ComingSoonPage(),
          ),
          item(
            title: 'Logger',
            subtitle: 'Simple way to debug your code',
            iconData: Icons.bug_report,
            page: ComingSoonPage(),
          ),
          item(
            title: 'UI Library',
            subtitle: 'Bunch of simple UI ready to use for Your Apps',
            iconData: Icons.phone_iphone,
            page: ComingSoonPage(),
          ),
          item(
            title: 'Multi Language',
            subtitle: 'Support Your App using multiple language',
            iconData: Icons.translate,
            page: ComingSoonPage(),
          ),
          item(
            title: 'Easy Var',
            subtitle: 'Easily save Your variable and call it from everywhere',
            iconData: Icons.code,
            page: ComingSoonPage(),
          ),


        ],
      ),

    );
  }

  item({String title, String subtitle, IconData iconData, Function onTap, Widget page}){
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(title),
          leading: Icon(iconData),
          subtitle: Text(subtitle),
          onTap: (){
            if(page != null){
              Router.push(context, page);
            }else{
              onTap();
            }
          },
        ),
        Container(height: 1, color: Colors.grey[100],)
      ],
    );
  }

}