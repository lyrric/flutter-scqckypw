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
      appBar: AppBar(
        title: Text('选择地区'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: _cityList.length,
          itemBuilder: (context, index){
            return _CityListItem(_cityList[index]);
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
      decoration: BoxDecoration(color:Colors.black12),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(_cityModel.name, style: TextStyle(fontSize: 14),)
            ),
          ],
    ));
  }
  //可选择的城市
  Widget selectableWidget(){
    return Container(
      decoration: BoxDecoration(color:Colors.white),
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 10, top: 0,bottom: 0),
              title: Text(_cityModel.name, style: TextStyle(fontSize: 16)),
              onTap: (){
                Navigator.pop(_context, _cityModel);
              },
            ),
          ),
          Divider(height: 5, ),
        ],
      )
    );
  }

}