import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: StickyHeaderDelegate(),
        ),
        SliverFixedExtentList(
          itemExtent: 500.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: const Color(0xffc7ccdb),
                child: Text('content $index',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff767b91),
                    )),
              );
            },
          ),
        ),
      ],
    ));
  }
}

class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  StickyHeaderDelegate();

  @override
  double get minExtent => 64;

  @override
  double get maxExtent => 128;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 128,
      decoration: BoxDecoration(
        color: Color.lerp(const Color(0xffc7ccdb), const Color(0xff2a324b),
            shrinkOffset / maxExtent),
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff767b91),
            width: 0.5,
          ),
        ),
      ),
      child: Center(
        child: Text(
          'Sticky Header',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.lerp(const Color(0xff767b91), const Color(0xffffffff),
                shrinkOffset / maxExtent),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(StickyHeaderDelegate oldDelegate) {
    return false;
  }
}
