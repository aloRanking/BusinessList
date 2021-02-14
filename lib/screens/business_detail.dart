import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessDetailScreen extends StatelessWidget {
  /* final String documentId;


  BusinessDetail(this.documentId);*/

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    CollectionReference business =
        FirebaseFirestore.instance.collection('business');
    return Scaffold(
        appBar: AppBar(
          title: Text('Details'),
        ),
        body: Container(
            child: FutureBuilder<DocumentSnapshot>(
          future: business.doc(data).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            List<Widget> children;

            if (snapshot.hasError) {
              children = [Center(child: Text("Something went wrong"))];
            } else if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> docData = snapshot.data.data();
              children = [
                // Text("Full Name: ${data['name']} ${data['address']}")
                Column(
                  children: [
                    Container(
                      height: 200,
                      //color: Colors.red,
                      child: Image.network('${docData['imgurl']}'),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Business Name: ${docData['name']}",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),

                    SizedBox(height: 20),

                    Text(
                      "Business Address: ${docData['address']}",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Business Type: ${docData['type']}",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),

                    SizedBox(height: 20),

                    RaisedButton(
                      onPressed: () {
                        Get.toNamed('/editBusinessView', arguments: docData);
                      },
                      child: Text('Edit'),
                    ),

                    //Text("Business Name: ${data['name']}"),

                    //Image.network('${data['imgurl']}'),
                  ],
                )
              ];
            } else {
              children = <Widget>[
                Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('a moment...'),
                )
              ];
            }
            return Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ),
            );
          },
        )));
  }
}
