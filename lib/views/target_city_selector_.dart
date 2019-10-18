import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/model/target_city_model.dart';
import 'package:flutter_scqckypw/service/city_service.dart';



class TargetCitySelector extends SearchDelegate<TargetCityModel> {

  //出发车站
  int _fromCityId;

  List<TargetCityModel> _targetCityList = List();

  CityService cityService = CityService();

  State state;

  TargetCitySelector(this._fromCityId, this.state){
//    cityService.getTargetCityList(_fromCityId, 'a').then((data){
//      _targetCityList = data;
//    });
  }

  getTargetCityList(){
    cityService.getTargetCityList(_fromCityId, 'a').then((data){
      _targetCityList = data;
    });
  }

  @override
  List<Widget> buildActions(BuildContext context){
    return [
      IconButton(
        icon:Icon(Icons.clear),
        onPressed: ()=>query = "",)
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () => close(context, null));

  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isNotEmpty){
      return FutureBuilder(
          builder: _buildFuture,
          future:cityService.getTargetCityList(_fromCityId, query)
      );
    }else{
      return Text('');
    }
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.done:
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return _createListView(context, snapshot);
      default:
        return Center(
          child: CircularProgressIndicator(),
        );
    }
  }
  Widget _createListView(BuildContext context, AsyncSnapshot snapshot) {
    _targetCityList = snapshot.data;
    if(_targetCityList.length == 0){
      return Text('没有数据');
    }
    return ListView.builder(
        itemCount: _targetCityList.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(_targetCityList[index].name),
          onTap: (){
            close(context, _targetCityList[index]);
          },
        ));
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    return super.appBarTheme(context);
  }
}