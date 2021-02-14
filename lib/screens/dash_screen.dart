import 'package:businesslisting/controllers/auth_controller.dart';
import 'package:businesslisting/controllers/dash_controller.dart';
import 'package:businesslisting/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class DashScreen extends StatelessWidget {
  final AuthController _authController = Get.find();
  final DashboardController _dashboardController =
  Get.put(DashboardController());
  List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
    const StaggeredTile.count(2, 2),
    const StaggeredTile.count(2, 1),
    const StaggeredTile.count(2, 2),
    const StaggeredTile.count(4, 1),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> _tiles = <Widget>[
      Obx(() {
        return DashCard(
          bgColor: Colors.green,
          iconData: Icons.widgets,
          cardTitle: 'Active Business  ${_dashboardController.nActive}',
        );
      }),
      Obx(() {
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
      }),
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
          )

        /*StaggeredGridView.count(

          crossAxisCount: 4,
          staggeredTiles: _staggeredTiles,
          children: _tiles,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          padding: const EdgeInsets.all(4.0),
        )*/

        /*StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) => new Container(
              color: Colors.green,
              child: new Center(
                child: new CircleAvatar(
                  backgroundColor: Colors.white,
                  child: new Text('$index'),
                ),
              )),
          staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2 : 1),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        )*/
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/addBusinessView');
        },
        child: Icon(Icons.person),
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

/*
Column(
children: [



Text('${_authController.user.email}'),

RaisedButton(onPressed: (){
Get.toNamed('/businessListView');
})
],
),
*/
