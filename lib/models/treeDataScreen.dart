import 'package:flutter/material.dart';
import 'treesToBeVerified.dart';
class TreeListScreen extends StatelessWidget {
  final List<TreesToBeVerifiedData> treesData;

  TreeListScreen(this.treesData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trees Data')),
      body: ListView.builder(
        itemCount: treesData.length, // Use the length of the list of treesData
        itemBuilder: (context, index) {
          final tree = treesData[index];
          return ListTile(
            title: Text('Tree ID: ${tree.treeId}'),
            subtitle: Text('Girth: ${tree.girth}\nPlot No: ${tree.plotNo}'),
          );
        },
      ),
    );
  }
}
