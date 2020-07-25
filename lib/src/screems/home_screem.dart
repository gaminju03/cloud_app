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
    .listen((data) =>
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
  sliver:   SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index){
          return _buildListItem(context,_bandList[index]);// de donde los va a recuperar 
          
        },
        childCount: _bandList.length),
  ),
)
          ],),
      ),
    );
    
  }
}

Widget _buildListItem(BuildContext context, DemoInfo bandInfo){
  return ListTile (
    title: Text(bandInfo.name),
    trailing: Row(mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(bandInfo.votes.toString()),
      Icon(CupertinoIcons.right_chevron),
    ],
    )
  );
}