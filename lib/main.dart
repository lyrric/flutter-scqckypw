import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_scqckypw/views/city_selector.dart';
import 'package:flutter_scqckypw/views/home_drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '四川汽车票务网',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '四川汽车票务网'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: new Drawer(
        child: new HomeDrawerWidget(),
      ),
      backgroundColor:  Color(0xF0FFFFFF),
      body: _Body(context)
    );
  }
}

class _Body extends StatelessWidget{

  //发车城市
  String _fromCity;
  //目标城市
  String _targetCity;
  //开发日期
  DateTime _date;

  BuildContext _topContext;

  _Body(this._topContext);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration:  new BoxDecoration(
        color: Colors.white, // 底色
      ),
      child:  new Container(
        margin: EdgeInsets.only(left: 20, top: 20, right: 20),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Container(
                  width: 120,
                  child:  new Column(
                    children: <Widget>[
                      new FlatButton(
                        child: new Text('成都', style: new TextStyle(fontSize: 24),),
                        onPressed: () {
                          Navigator.of(_topContext).push(new MaterialPageRoute(builder:
                              (_){ return new CitySelector();}
                              )
                          ).then((cityName){
                             if(cityName != null) {
                               _fromCity = cityName;
                             }
                          });
                        },
                      ),
                      Divider(height:20.0,indent:0.0,color: Colors.red,),
                    ],
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(left: 40, right: 50),
                  child: new Icon(Icons.sync),
                ),
                new Container(
                  width: 120,
                  child:  new Column(
                    children: <Widget>[
                      new FlatButton(
                        child: new Text('宜宾', style: new TextStyle(fontSize: 24),),
                        onPressed: () {
                          Navigator.of(_topContext).push(new MaterialPageRoute(builder:
                              (_){ return new CitySelector();}
                          )
                          ).then((cityName){
                            if(cityName != null) {
                              _targetCity = cityName;
                            }
                          });
                        },
                      ),
                      Divider(height:20.0,indent:0.0,color: Colors.red,),
                    ],
                  ),
                ),
              ],
            ),
            new Container(
              margin: EdgeInsets.only(top: 0.0),
              child: new FlatButton(
                child: new Text('9月29日 星期五', style: new TextStyle(fontSize: 14),),
                onPressed: () {
                  showDatePicker(
                      context: context,
                      lastDate: DateTime.now().add(new Duration(days: 15)),
                      firstDate: DateTime.now(),
                      initialDate: DateTime.now()
                  ).then((date)=>{
                    _date = date
                  });
                },
              ),
            ),
            new Container(
              alignment: Alignment.center,
              child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 350,
                child: Text('查询'),
                onPressed: ()=>{

                },
              ),
            )
          ],
        ),
      )
    );
  }
 String getDateString(){
    return '${_date.year}-${_date.month}-${_date.day}';
 }
}