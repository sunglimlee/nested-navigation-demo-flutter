import 'package:flutter/material.dart';

class ColorsListPage extends StatelessWidget {
  ColorsListPage({required this.color, required this.title, this.onPush});
  final MaterialColor color;
  final String title;
  final ValueChanged<int>? onPush; // callback function 콜백 함수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
          ),
          backgroundColor: color,
        ),
        body: Container(
          color: Colors.white,
          child: _buildList(),
        ));
  }

  final List<int> materialIndices = [
    900,
    800,
    700,
    600,
    500,
    400,
    300,
    200,
    100,
    50
  ];

  Widget _buildList() {
    return ListView.builder(
        itemCount: materialIndices.length,
        itemBuilder: (BuildContext content, int index) {
          int materialIndex = materialIndices[index];
          return Container(
            color: color[materialIndex],
            child: ListTile(
              title: Text('$materialIndex', style: TextStyle(fontSize: 24.0)),
              trailing: Icon(Icons.chevron_right),
              onTap: () => onPush?.call(materialIndex), // 도로 call 을 할 때 받아왔던 인자를 도로 돌려주는구나.
              // call() 함수 없어도 같다. 그냥 해준거다. 마치 class 인것 처럼
            ),
          );
        });
  }
}
