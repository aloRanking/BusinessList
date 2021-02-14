import 'package:businesslisting/controllers/dash_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessListScreen extends StatelessWidget {
  final DashboardController _dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Business List'),
      ),
      body: Container(
        child: Column(
          children: [
            FutureBuilder<QuerySnapshot>(
                future:
                    _dashboardController.fireStore.collection('business').get(),
                builder: (context, snapshot) {
                  List<Widget> children;

                  if (snapshot.hasData) {
                    // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                    final List<DocumentSnapshot> documents = snapshot.data.docs;
                    print(documents.length);
                    children = [
                      Container(
                        height: 300,
                        child: ListView(
                            children: documents
                                .map((doc) => GestureDetector(
                                      onTap: () {
                                        Get.toNamed('/businessDetailView',
                                            arguments: doc.id);
                                      },
                                      child: Card(
                                        child: ListTile(
                                          title: Text(doc['name']),
                                          subtitle: Text(doc['address']),
                                        ),
                                      ),
                                    ))
                                .toList()),

                        /*ListView.separated(
                       itemCount: documents.length,
                       separatorBuilder: (BuildContext context, int index) => Divider(),
                       itemBuilder: (BuildContext context, int index) {
                         return Card(
                           child: ListTile(
                             title: Text(documents['name']),
                             subtitle: Text(doc['address']),
                           ),
                         )
                       },
                     )*/

                        /**/
                      )
                    ];
                  } else if (snapshot.hasError) {
                    children = <Widget>[
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Error: ${snapshot.error}'),
                      )
                    ];
                  } else {
                    children = <Widget>[
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      )
                    ];
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: children,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
