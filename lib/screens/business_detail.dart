import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessDetailScreen extends StatelessWidget {

  var name = ''.obs;
  var address = ''.obs;
  var type = ''.obs;
  var coordinates = ''.obs;

  @override
  Widget build(BuildContext context) {
    var docData = Get.arguments;
    print('docData id ${docData.id}');

    name.value = docData['name'];
    address.value = docData['address'];
    type.value = docData['type'];
    coordinates.value = docData['coordinates'];

    //print(coordinates);

    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            //color: Colors.red,
            child: Image.network('${docData['imgurl']}'),
          ),
          SizedBox(height: 30),
          Obx(
                () =>
                Text(
                  "Business Name: ${name.value}",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
          ),
          SizedBox(height: 20),
          Obx(
                () =>
                Text(
                  "Business Address: ${address.value} ",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
          ),
          SizedBox(
            height: 20,
          ),
          Obx(
                () =>
                Text(
                  "Business coordinate: ${coordinates.value} ",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
          ),
          SizedBox(height: 20),
          Obx(
                () =>
                Text(
                  "Business Type: ${type.value}",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
          ),
          SizedBox(height: 20),
          RaisedButton(
            onPressed: () async {
              var result =
              await Get.toNamed('/editBusinessView', arguments: docData);
              if (result == null) {
                print('no data');
              } else {
                name.value = result[0];
                address.value = result[1];
                type.value = result[2];
              }
            },
            child: Text('Edit'),
          ),
        ],
      ),
    );
  }
}
