import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_scqckypw/data/data.dart';
import 'package:flutter_scqckypw/data/sys_constant.dart';
import 'package:flutter_scqckypw/model/target_city_model.dart';
import 'package:flutter_scqckypw/service/base_service.dart';

///
class CityService extends BaseService{


  //终点站搜索列表
 Future<List<TargetCityModel>> getTargetCityList(int formCityId, String key) async {
    Response response = await dio.get(TARGET_CITY_URL,
      queryParameters: {
        'cid':formCityId,
        's':key,
        'city_name':'asd'
      },
      options: new Options(
          headers: { 'cookie':Data.getCookie(),},
          responseType: ResponseType.plain
      ),
    );
    String data = response.data;
    data = data.replaceAll("var ecl =", "");
    List list = json.decode(data);
    List<TargetCityModel> targetCityList = new List();
    for(Map map in list){
      TargetCityModel targetCity = TargetCityModel.fromJson(map);
      targetCityList.add(targetCity);
    }
    return targetCityList;
  }
}