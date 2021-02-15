import 'package:businesslisting/controllers/auth_controller.dart';
import 'package:businesslisting/controllers/dash_controller.dart';
import 'package:businesslisting/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DashScreen extends StatelessWidget {
  final AuthController _authController = Get.find();
  final DashboardController _dashboardController =
  Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    List<Widget> _tiles = <Widget>[
      StreamBuilder<QuerySnapshot>(
          stream: _dashboardController.getActiveBusiness(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return DashCard(
              bgColor: Colors.green,
              iconData: Icons.widgets,
              cardTitle: 'Active Business  ${snapshot.data.docs.length}',
            );
          }),
      StreamBuilder<QuerySnapshot>(
          stream: _dashboardController.getInActiveBusiness(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return DashCard(
              bgColor: Colors.red,
              iconData: Icons.widgets,
              cardTitle: 'InActive Business  ${snapshot.data.docs.length}',
            );
          }),
      StreamBuilder<QuerySnapshot>(
          stream: _dashboardController.getRegisteredBusiness(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return DashCard(
              bgColor: Colors.amber,
              iconData: Icons.panorama_wide_angle,
              cardTitle: 'Registered Business  ${snapshot.data.docs.length}',
            );
          }),

      /* Obx(() {
        return DashCard(
          bgColor: Colors.red,
          iconData: Icons.widgets,
          cardTitle: 'InActive Business  ${_dashboardController.nInActive}',
        );
      }),
      Obx(() {
        return DashCard(
            bgColor: Colors.amber,
            iconData: Icons.panorama_wide_angle,
            cardTitle:
            'Rgistered Business  ${_dashboardController.nRegistered}');
      }),*/
      DashCard(
        bgColor: Colors.blue,
        iconData: Icons.map,
        cardTitle: 'View Business List',
        onTap: () {
          Get.toNamed('/businessListView');
        },
      ),
      DashCard(
        bgColor: Colors.purple,
        iconData: Icons.person,
        cardTitle: 'View Profile',
        onTap: () {
          Get.toNamed('/profileView');
        },
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Container(
          child: Column(
            children: _tiles,
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/addBusinessView');
        },
        child: FaIcon(FontAwesomeIcons.pen),
      ),
    );
  }
}

class DashCard extends StatelessWidget {
  DashCard({this.bgColor, this.iconData, this.onTap, this.cardTitle});

  final Color bgColor;
  final IconData iconData;
  final Function onTap;
  final String cardTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: new Card(
        color: bgColor,
        child: new InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    iconData,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                cardTitle,
                style: TextStyle(color: kWhiteColor, fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
