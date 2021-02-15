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
        child: FutureBuilder<QuerySnapshot>(
            future: _dashboardController.fireStore.collection('business').get(),
            builder: (context, snapshot) {
              List<Widget> children;

              if (snapshot.hasData) {
                // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                final List<DocumentSnapshot> documents = snapshot.data.docs;
                print(documents.length);
                children = [
                  Flexible(
                    child: Container(
                      height: Get.height,
                      child: ListView(
                          children: documents
                              .map((doc) =>
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed('/businessDetailView',
                                      arguments: doc);
                                },
                                child: Card(
                                  child: ListTile(
                                    title: Text(doc['name']),
                                    subtitle: Text(doc['address']),
                                  ),
                                ),
                              ))
                              .toList()),
                    ),
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
            }),
      ),
    );
  }

/*List<IntSize> _createSizes(int count) {
    Random rnd = new Random();
    return new List.generate(count,
            (i) => new IntSize((rnd.nextInt(500) + 200), rnd.nextInt(800) + 200));
  }*/

}

/*Container(
height: Get.height,
child: StaggeredGridView.countBuilder(
crossAxisCount: 4,
itemCount: 5,
itemBuilder: (BuildContext context, int index) => new Container(
color: Colors.green,
child: new Center(
child: Container(
child: GestureDetector(
onTap: () {
Get.toNamed('/businessDetailView',
arguments: documents[index]);
print(documents[index].id);
},
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children:[
documents[index]['imgurl'] == null ? Text('no image') : Container(
height: 100,
child: Image.network(documents[index]['imgurl'])),
Text(documents[index]['name']),
Text(documents[index]['address'])
]
),
),
),
)),
staggeredTileBuilder: (int index) =>
new StaggeredTile.count(2, index.isEven ? 2 : 1),
mainAxisSpacing: 4.0,
crossAxisSpacing: 4.0,
),
)*/

/*
class _Tile extends StatelessWidget {
  const _Tile(this.index, this.size);

  final IntSize size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        children: <Widget>[
          new Stack(
            children: <Widget>[
              //new Center(child: new CircularProgressIndicator()),
              new Center(
                child: new FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: 'https://picsum.photos/${size.width}/${size.height}/',
                ),
              ),
            ],
          ),
          new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new Column(
              children: <Widget>[
                new Text(
                  'Image number $index',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                new Text(
                  'Width: ${size.width}',
                  style: const TextStyle(color: Colors.grey),
                ),
                new Text(
                  'Height: ${size.height}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
*/
