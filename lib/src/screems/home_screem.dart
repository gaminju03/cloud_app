import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreem extends StatefulWidget {
  HomeScreem({Key key}) : super(key: key);

  @override
  _HomeScreemState createState() => _HomeScreemState();
}

class DemoInfo{
 final String name;
 final int votes;

 DemoInfo({this.name, this.votes});
}



class _HomeScreemState extends State<HomeScreem> {
final List<DemoInfo> _bandList = [
DemoInfo(name: 'Nombre demo 1', votes: 0),
DemoInfo(name: 'Nombre demo 2', votes: 2),
DemoInfo(name: 'Nombre demo 3', votes: 3),
DemoInfo(name: 'Nombre demo 4', votes: 4),
];

@override
void initState() { 
  super.initState();

  Firestore.instance
    .collection('bandnames')
    //.where("topic", isEqualTo: "flutter")
    .snapshots()
    .listen((data) => //parte mas importante con la app en ejecucion 
        data.documents.forEach((doc) => print(doc['name'])));

}

  @override
  Widget build(BuildContext context) {
    return Material(
          child: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
CupertinoSliverNavigationBar(largeTitle: Text('Band Names and Survey'),
),
SliverSafeArea(
  sliver:   StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('bandanames').snapshots(),
    builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
        if(!snapshot.hasData)return SliverToBoxAdapter(child: CupertinoActivityIndicator());
        return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index){
          return _buildListItem(context,snapshot.data.documents[index]);// de donde los va a recuperar 
          
        },childCount: snapshot.data.documents.length),
  );
    },
    ),
   ),
          ],),
      ),
    );
    
  }
}



Widget _buildListItem(BuildContext context, DocumentSnapshot document){
  return ListTile (
    title: Text(document['name']),
    trailing: Row(mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(document['votes'].toString()),
      Icon(CupertinoIcons.right_chevron),
    ],
    )
  );
}