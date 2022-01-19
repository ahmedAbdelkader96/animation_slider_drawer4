import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
void main() {
  runApp( MyApp1());
}








class MyApp1 extends StatefulWidget {
  @override
  State<MyApp1> createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}










class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppDrawerPageState createState() => _MyAppDrawerPageState();
}

class _MyAppDrawerPageState extends State<MyApp>
    with TickerProviderStateMixin {
  bool menuShown = false;
  double appbarHeight = 80.0;
  double menuHeight = 0.0;
   Animation<double> openAnimation;
   AnimationController openController;

  @override
  void initState() {
    super.initState();
    openController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    openAnimation = Tween(begin: 0.0, end: 1.0).animate(openController)
      ..addListener(() {
        setState(() {
          menuHeight = openAnimation.value;
        });
      });

  }

  _handleMenuPress() {
    setState(() {
      //openController.reset();
      //closeController.reset();
      menuShown = !menuShown;
      menuShown ? openController.forward() : openController.reverse();
    });
  }

  @override
  void dispose() {
    openController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.teal,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            GestureDetector(
              onVerticalDragUpdate: (details) {

                if (details.delta.dy > 0)
                {
                  print("y+");
                  setState(() {
                    menuShown = true;
                    openController.forward() ;
                  });
                }
                else
                {                      print("y-");

                setState(() {

                  menuShown = false;
                  openController.reverse();
                });
                }
              },
              child: AnimatedPadding(
                duration: Duration(milliseconds: 500),

                padding: EdgeInsets.all(openAnimation.value*24),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),

                  height: menuHeight,
                  decoration: BoxDecoration(color: Colors.amber,borderRadius: BorderRadius.circular(openAnimation.value*24)),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              menuShown ? Icons.arrow_back_ios : Icons.menu,
                            ),
                            color: Colors.white,
                            onPressed: _handleMenuPress,
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: !menuShown ?MediaQuery.of(context).size.width*0.13: MediaQuery.of(context).size.width*0.2),
                            child: Text(!menuShown ? "Animation Drawer" : "Drawer",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 22.0)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Expanded(
                        child:   Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,

                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: drawerItems
                              .map((element) => Padding(
                                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.17,
                                    top: MediaQuery.of(context).size.height*0.05),
                                child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                Icon(
                                  element['icon'],
                                  color: Colors.white,
                                  size: 30,
                                ),
                                 SizedBox(
                                  width: MediaQuery.of(context).size.width*0.08,
                                ),
                                Text(element['title'],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20))
                            ],
                          ),
                              )).toList(),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.nightlight_round,color: Colors.grey[800]),
                              Switch(value: true, onChanged: (bool){} ,activeColor: Colors.green,),
                              Icon(Icons.lightbulb_outline,color: Colors.white,),

                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30,right: 30),
                            child: Text("|"),
                          ),
                          TextButton(onPressed: (){}, child: Text("logout",style: TextStyle(color: Colors.red,fontSize: 20),))
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return  AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      //height: menuHeight * (constraints.maxHeight - 60) + 60,
                      margin: EdgeInsets.only(
                          top: menuHeight * (constraints.maxHeight - 62) + 62),
                      color: Colors.transparent,
                      child: Material(
                          elevation: 16.0,
                          // shape: const BeveledRectangleBorder(
                          //   borderRadius:
                          //   BorderRadius.only(topLeft: Radius.circular(15.0)),
                          // ),
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(top: 20.0),

                            itemBuilder: (_, int index) {
                              return Column(
                                children: [Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    NewPadd("assets/second.jpeg","ahmed") ,
                                    NewPadd("assets/second.jpeg","ahmed") ,
                                  ],
                                ),
                                  SizedBox(height: 13,),],
                              );

                            },
                            itemCount: 10,
                          ),
                        ),

                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}

List<Map> drawerItems = [
  {'icon': Icons.category_outlined, 'title': 'Categories'},
  {'icon': Icons.add_alert_outlined, 'title': 'Notifications'},
  {'icon': Icons.chat_bubble_outline, 'title': 'Messages'},
  {'icon': Icons.email, 'title': 'Inbox'},
  {'icon': Icons.favorite_border, 'title': 'Favorites'},
  {'icon': FontAwesomeIcons.userAlt, 'title': 'Profile'},
];
class NewPadd extends StatelessWidget {
  const NewPadd(this.image , this.text );
  final String image ;
  final String text ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ],
              image: DecorationImage(image: AssetImage(image))
          ),

        ),
        SizedBox(height: 6,),
        Text(
          text,
          style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
              decoration: TextDecoration.none),
        )
      ],
    );
  }
}