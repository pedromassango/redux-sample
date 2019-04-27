import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sample/redux/app_state.dart';
import 'package:sample/ui/home_page.dart';
import 'package:sample/reducers/counter_reducer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final createStore = Store<AppState>(
    productsReducer,
    distinct: true,
    initialState: AppState.initialState(),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: createStore,
      child: MaterialApp(
        title: 'Flutter Redux Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: HomePage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text("Bunced Navigation Bar"),
      ),
      bottomNavigationBar: BouncedNavigationBar(
        items: [
          Item(title: "News", icon: Icons.wallpaper),
          Item(title: "Messages", icon: Icons.message),
          Item(title: "Events", icon: Icons.event),
          Item(title: "Log", icon: Icons.insert_emoticon),
          Item(title: "Profile", icon: Icons.account_circle),
        ],
      ),
    );
  }
}

class BouncedNavigationBar extends StatefulWidget {
  final List<Item> items;

  const BouncedNavigationBar({Key key, this.items}) : super(key: key);
  @override
  _BouncedNavigationBarState createState() => _BouncedNavigationBarState();
}

class _BouncedNavigationBarState
    extends State<BouncedNavigationBar>
    with SingleTickerProviderStateMixin{

  final elevation = 50;
  int _selectedIndex = 0;
  List<Item> get items => widget.items;

  Duration _duration = Duration(milliseconds: 500);
  Animation<Alignment> _alignAnimation;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _duration
    );

    _alignAnimation = AlignmentTween(
      begin: Alignment.bottomCenter, end: Alignment.topCenter
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut
      )
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = kBottomNavigationBarHeight*1.8;
    final width = MediaQuery.of(context).size.width;
    final heightDividedByTwo = height/1.5;

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.transparent,
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[

          Container(
            width: width,
            height: heightDividedByTwo,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10
                    )
                  ]
              )
          ),

          Row(
            children: items.map((i){
              final isSelected = (_selectedIndex == items.indexOf(i));

              return AnimatedBuilder(
                animation: _controller,
                builder: (_, ch){
                  return AnimatedAlign(
                    duration: _duration,
                    curve: Curves.bounceOut,
                    alignment: isSelected ? Alignment.topCenter : Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: (){
                        _selectedIndex = items.indexOf(i);
                        if(_controller.isCompleted){
                          _controller.reverse();
                        }else{
                          _controller.forward();
                        }
                        setState(() {});
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        width: width / items.length,
                        height: heightDividedByTwo,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 5,
                            color: Colors.white
                          ),
                          color: isSelected ? Colors.blueAccent : Colors.white,
                        ),
                        child: Icon(i.icon, color: isSelected ? Colors.white : Colors.black,),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

class Item{
  final String title;
  final IconData icon;
  const Item({this.title, this.icon});
}