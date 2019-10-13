import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_scqckypw/model/city_model.dart';
import 'package:flutter_scqckypw/views/city_selector.dart';
import 'package:flutter_scqckypw/views/home_drawer.dart';
import 'package:flutter_scqckypw/views/pay_web_view.dart';
import 'package:flutter_scqckypw/views/target_city_selector_.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '四川汽车票务网',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale.fromSubtags(languageCode: 'zh'),
        const Locale.fromSubtags(languageCode: 'en'),
      ],
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
        centerTitle: true,
      ),
      drawer: new Drawer(
        child: new HomeDrawerWidget(),
      ),
      backgroundColor:  Color(0xF0FFFFFF),
      body: _Body(context)
    );
  }
}

class _Body extends StatefulWidget{



  BuildContext _topContext;

  _Body(this._topContext);

  @override
  State createState() {
    return new _BodyState(_topContext);
  }


}

class _BodyState extends State<_Body>{

  //发车城市
  CityModel _fromCity = CityModel.of(255,'成都市');
  //目标城市
  CityModel _targetCity = CityModel.of(325,'宜宾');
  //处罚日期
  DateTime _date = DateTime.now();

  BuildContext _topContext;

  _BodyState(this._topContext);

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
                    width: 100,
                    child:  new Column(
                      children: <Widget>[
                        new FlatButton(
                          child: new Text(_fromCity.name, style: new TextStyle(fontSize: 22),),
                          onPressed: () {
                            Navigator.of(_topContext).push(new MaterialPageRoute(builder:
                                (_){ return new CitySelector();}
                            )
                            ).then((city){
                              if(city != null) {
                                super.setState((){
                                  _fromCity = city;
                                });
                              }
                            });
                          },
                        ),
                        Divider(height:10.0,indent:0.0,color: Colors.red,),
                      ],
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: 40, right: 50),
                    child: new Icon(Icons.arrow_forward),
                  ),
                  new Container(
                    width: 100,
                    child:  new Column(
                      children: <Widget>[
                        new FlatButton(
                          child: new Text(_targetCity.name, style: new TextStyle(fontSize: 22),),
                          onPressed: () {
                            showSearch(context: _topContext, delegate: new TargetCitySelector(_fromCity.id, this))
                              .then((city){
                                _targetCity = CityModel.of(city.id,city.name);
                                setState(() {

                                });
                            });
                          }
                        ),
                        Divider(height:10.0,indent:0.0,color: Colors.red,),
                      ],
                    ),
                  ),
                ],
              ),
              new Container(
                margin: EdgeInsets.only(top: 0.0),
                child: new FlatButton(
                  child: new Text(_getShowDate(), style: new TextStyle(fontSize: 14),),
                  onPressed: () {
                    showDatePicker(
                      locale: Locale.fromSubtags(languageCode: 'zh'),
                      context: context,
                      lastDate: DateTime.now().add(new Duration(days: 15)),
                      firstDate: _date,
                      initialDate: _date
                    ).then((date){
                      if(date != null){
                        setState(() {
                          _date = date;
                        });
                      }
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
                  onPressed: (){
                    Navigator.of(_topContext).push(new MaterialPageRoute(builder: (_){
                      //return new TicketListView(_fromCity, _targetCity, _getDateString());
                      /*return new WebviewScaffold(
                        url: 'http://www.taobao.com',
                        appBar: new AppBar(
                          title: Text('确认订单'),
                        ),
                        initialChild: new CircularProgressIndicator(),
                      );*/
                      return new PayWebView('https://www.taobao.com');
                    }));
                  },
                ),
              )
            ],
          ),
        )
    );
  }

  //格式化时间2019-05-11
  String _getDateString(){
    return '${_date.year}-${_date.month}-${_date.day}';
  }
  //格式化时间，9月29日 星期五
  String _getShowDate(){
    int weekday = _date.weekday;
    String weekStr;
    switch(weekday){
      case 1:
        weekStr = '星期一';break;
      case 2:
        weekStr = '星期二';break;
      case 3:
        weekStr = '星期三';break;
      case 4:
        weekStr = '星期四';break;
      case 5:
        weekStr = '星期五';break;
      case 6:
        weekStr = '星期六';break;
      case 7:
        weekStr = '星期天';break;
      default:
        weekStr = '星期天';break;
    }
    return '${_date.month}月${_date.day}日 $weekStr';
  }
}