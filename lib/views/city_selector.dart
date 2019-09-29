import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_scqckypw/data/data.dart';
import 'package:flutter_scqckypw/model/city_model.dart';

///地区选择器
class CitySelector extends StatefulWidget{

  @override
  State createState() {
    return _CitySelectorState();
  }

}
class _CitySelectorState extends State<CitySelector>{

  static List<CityModel>  _cityList = Data.getCityList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('选择地区'),
      ),
      body: ListView.builder(
          itemCount: _cityList.length,
          itemBuilder: (context, index){
            if(_cityList.length >= index){
              return _CityListItem(_cityList[index]);
            }
          }
      ),
    );
  }
}

class _CityListItem extends StatelessWidget{

  CityModel _cityModel;

  _CityListItem(this._cityModel);

  BuildContext _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    return _cityModel.isTitle?unSelectableWidget():selectableWidget();
  }
  //标题，不可选择
  Widget unSelectableWidget(){
    return Container(
      height: 40,
      decoration: new BoxDecoration(color:Colors.black12),
        child:new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(left: 10),
              child: new Text(_cityModel.name, style: new TextStyle(fontSize: 14),)
            ),
          ],
    ));
  }
  //可选择的城市
  Widget selectableWidget(){
      return new Container(
        decoration: new BoxDecoration(color:Colors.white),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new MaterialButton(
              textColor: Colors.black,
              minWidth: 350,
              height: 30,
              child: new Container(
                alignment: Alignment.centerLeft,
                child: Text(_cityModel.name),
              ),
              onPressed: ()=>{

              },
            ),
            Divider(height: 5, ),
          ],
        ),
      );
//    return Container(
//      decoration: new BoxDecoration(color:Colors.white),
//      child: new Column(
//        children: <Widget>[
//          new Container(
//            height: 40,
//            child: new ListTile(
//              contentPadding: EdgeInsets.only(left: 10, top: 0,bottom: 0),
//              title: new Text(_cityModel.name, style: new TextStyle(fontSize: 16)),
//              onTap: (){
//                Navigator.pop(_context, _cityModel.name);
//              },
//            ),
//          ),
//          Divider(height: 5, ),
//        ],
//      )
//    );
  }

}