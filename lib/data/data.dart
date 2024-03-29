
import 'dart:convert';
import 'dart:io';
import 'dart:core';

import 'package:flutter_des/flutter_des.dart';
import 'package:flutter_scqckypw/model/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../model/city_model.dart';

class Data{
  static const _fromCityJson = '[{"id":255,"is_connected":true,"name":"成都市","pinyin":"chengdushi","children":[{"pinyin":"chengdushi","id":255,"is_connected":true,"name":"成都市"},{"pinyin":"jintangxian","id":256,"is_connected":true,"name":"金堂县"},{"pinyin":"shuangliuqu","id":257,"is_connected":true,"name":"双流区"},{"pinyin":"pixian","id":258,"is_connected":true,"name":"郫县"},{"pinyin":"dayixian","id":259,"is_connected":true,"name":"大邑县"},{"pinyin":"xinjinxian","id":261,"is_connected":true,"name":"新津县"},{"pinyin":"dujiangyanshi","id":262,"is_connected":true,"name":"都江堰市"},{"pinyin":"pengzhoushi","id":263,"is_connected":true,"name":"彭州市"},{"pinyin":"qionglaishi","id":264,"is_connected":true,"name":"邛崃市"},{"pinyin":"chongzhoushi","id":265,"is_connected":true,"name":"崇州市"},{"pinyin":"huayang","id":440,"is_connected":true,"name":"华阳"},{"pinyin":"longquan","id":534,"is_connected":true,"name":"龙泉驿"},{"pinyin":"xinduqu","id":543,"is_connected":true,"name":"新都区"},{"pinyin":"qingbaijiangqu","id":544,"is_connected":true,"name":"青白江区"}]},{"id":272,"is_connected":true,"name":"泸州市","pinyin":"luzhoushi","children":[{"pinyin":"luzhoushi","id":272,"is_connected":true,"name":"泸州市"},{"pinyin":"luxian","id":273,"is_connected":true,"name":"泸县"},{"pinyin":"hejiangxian","id":274,"is_connected":true,"name":"合江县"},{"pinyin":"xuyongxian","id":275,"is_connected":true,"name":"叙永县"},{"pinyin":"gulanxian","id":276,"is_connected":true,"name":"古蔺县"},{"pinyin":"naxiqu","id":533,"is_connected":true,"name":"纳溪区"}]},{"id":283,"is_connected":true,"name":"绵阳市","pinyin":"mianyangshi","children":[{"pinyin":"mianyangshi","id":283,"is_connected":true,"name":"绵阳市"},{"pinyin":"santaixian","id":284,"is_connected":true,"name":"三台县"},{"pinyin":"yantingxian","id":285,"is_connected":true,"name":"盐亭县"},{"pinyin":"anxian","id":286,"is_connected":true,"name":"安县"},{"pinyin":"zitongxian","id":287,"is_connected":true,"name":"梓潼县"},{"pinyin":"beichuanxian","id":288,"is_connected":true,"name":"北川县"},{"pinyin":"pingwuxian","id":289,"is_connected":true,"name":"平武县"},{"pinyin":"jiangyoushi","id":290,"is_connected":true,"name":"江油市"},{"pinyin":"xiushui","id":536,"is_connected":true,"name":"秀水"}]},{"id":312,"is_connected":true,"name":"南充市","pinyin":"nanchongshi","children":[{"pinyin":"nanchongshi","id":312,"is_connected":true,"name":"南充市"},{"pinyin":"nanbuxian","id":313,"is_connected":true,"name":"南部县"},{"pinyin":"yingshanxian","id":314,"is_connected":true,"name":"营山县"},{"pinyin":"penganxian","id":315,"is_connected":true,"name":"蓬安县"},{"pinyin":"yilongxian","id":316,"is_connected":true,"name":"仪陇县"},{"pinyin":"xichongxian","id":317,"is_connected":true,"name":"西充县"},{"pinyin":"langzhongshi","id":318,"is_connected":true,"name":"阆中市"}]},{"id":277,"is_connected":true,"name":"德阳市","pinyin":"deyangshi","children":[{"pinyin":"deyangshi","id":277,"is_connected":true,"name":"德阳市"},{"pinyin":"zhongjiangxian","id":278,"is_connected":true,"name":"中江县"},{"pinyin":"luojiangxian","id":279,"is_connected":true,"name":"罗江县"},{"pinyin":"guanghanshi","id":280,"is_connected":true,"name":"广汉市"},{"pinyin":"shifangshi","id":281,"is_connected":true,"name":"什邡市"},{"pinyin":"mianzhushi","id":282,"is_connected":true,"name":"绵竹市"}]},{"id":347,"is_connected":true,"name":"雅安市","pinyin":"yaanshi","children":[{"pinyin":"yaanshi","id":347,"is_connected":true,"name":"雅安市"},{"pinyin":"mingshanxian","id":348,"is_connected":true,"name":"名山县"},{"pinyin":"yingjingxian","id":349,"is_connected":true,"name":"荥经县"},{"pinyin":"hanyuanxian","id":350,"is_connected":true,"name":"汉源县"},{"pinyin":"shimianxian","id":351,"is_connected":true,"name":"石棉县"},{"pinyin":"tianquanxian","id":352,"is_connected":true,"name":"天全县"},{"pinyin":"lushanxian","id":353,"is_connected":true,"name":"芦山县"},{"pinyin":"baoxingxian","id":354,"is_connected":true,"name":"宝兴县"},{"pinyin":"jiuxiang","id":443,"is_connected":true,"name":"九襄镇"}]},{"id":269,"is_connected":true,"name":"攀枝花市","pinyin":"panzhihuashi","children":[{"pinyin":"panzhihuashi","id":269,"is_connected":true,"name":"攀枝花市"},{"pinyin":"miyixian","id":270,"is_connected":true,"name":"米易县"},{"pinyin":"yanbianxian","id":271,"is_connected":true,"name":"盐边县"}]},{"id":304,"is_connected":true,"name":"乐山市","pinyin":"leshanshi","children":[{"pinyin":"leshanshi","id":304,"is_connected":true,"name":"乐山市"},{"pinyin":"qianweixian","id":305,"is_connected":true,"name":"犍为县"},{"pinyin":"jingyanxian","id":306,"is_connected":true,"name":"井研县"},{"pinyin":"jiajiangxian","id":307,"is_connected":true,"name":"夹江县"},{"pinyin":"muchuanxian","id":308,"is_connected":true,"name":"沐川县"},{"pinyin":"mabianxian","id":310,"is_connected":true,"name":"马边县"},{"pinyin":"emeishanshi","id":311,"is_connected":true,"name":"峨眉山市"},{"pinyin":"wutongqiao","id":537,"is_connected":true,"name":"五通桥"},{"pinyin":"shawan","id":556,"is_connected":true,"name":"沙湾"}]},{"id":396,"is_connected":false,"name":"凉山州","pinyin":"liangshanzhou","children":[{"pinyin":"xichangshi","id":397,"is_connected":true,"name":"西昌市"},{"pinyin":"yanyuanxian","id":399,"is_connected":true,"name":"盐源县"},{"pinyin":"dechangxian","id":400,"is_connected":true,"name":"德昌县"},{"pinyin":"huilixian","id":401,"is_connected":true,"name":"会理县"},{"pinyin":"huidongxian","id":402,"is_connected":true,"name":"会东县"},{"pinyin":"butuoxian","id":405,"is_connected":true,"name":"布拖县"},{"pinyin":"jinyangxian","id":406,"is_connected":true,"name":"金阳县"},{"pinyin":"zhaojuexian","id":407,"is_connected":true,"name":"昭觉县"},{"pinyin":"mianningxian","id":409,"is_connected":true,"name":"冕宁县"},{"pinyin":"yuexixian","id":410,"is_connected":true,"name":"越西县"},{"pinyin":"ganluoxian","id":411,"is_connected":true,"name":"甘洛县"},{"pinyin":"meiguxian","id":412,"is_connected":true,"name":"美姑县"},{"pinyin":"leiboxian","id":413,"is_connected":true,"name":"雷波县"},{"pinyin":"yanshixian","id":547,"is_connected":true,"name":"演示县"}]},{"id":377,"is_connected":true,"name":"甘孜州","pinyin":"ganzizhou","children":[{"pinyin":"ganzizhou","id":377,"is_connected":true,"name":"甘孜州"},{"pinyin":"daochengxian","id":394,"is_connected":true,"name":"稻城县"},{"pinyin":"xiangchengxian","id":393,"is_connected":true,"name":"乡城县"},{"pinyin":"batangxian","id":392,"is_connected":true,"name":"巴塘县"},{"pinyin":"litangxian","id":391,"is_connected":true,"name":"理塘县"},{"pinyin":"sedaxian","id":390,"is_connected":true,"name":"色达县"},{"pinyin":"shiquxian","id":389,"is_connected":true,"name":"石渠县"},{"pinyin":"baiyuxian","id":388,"is_connected":true,"name":"白玉县"},{"pinyin":"degexian","id":387,"is_connected":true,"name":"德格县"},{"pinyin":"xinlongxian","id":386,"is_connected":true,"name":"新龙县"},{"pinyin":"ganzixian","id":385,"is_connected":true,"name":"甘孜县"},{"pinyin":"luhuoxian","id":384,"is_connected":true,"name":"炉霍县"},{"pinyin":"daofuxian","id":383,"is_connected":true,"name":"道孚县"},{"pinyin":"yajiangxian","id":382,"is_connected":true,"name":"雅江县"},{"pinyin":"jiulongxian","id":381,"is_connected":true,"name":"九龙县"},{"pinyin":"danbaxian","id":380,"is_connected":true,"name":"丹巴县"},{"pinyin":"ludingxian","id":379,"is_connected":true,"name":"泸定县"},{"pinyin":"kangdingxian","id":378,"is_connected":true,"name":"康定县"}]},{"id":363,"is_connected":false,"name":"阿坝州","pinyin":"abazhou","children":[{"pinyin":"wenchuanxian","id":364,"is_connected":true,"name":"汶川县"},{"pinyin":"lixian","id":365,"is_connected":true,"name":"理县"},{"pinyin":"maoxian","id":366,"is_connected":true,"name":"茂县"},{"pinyin":"songpanxian","id":367,"is_connected":true,"name":"松潘县"},{"pinyin":"jiuzhaigouxian","id":368,"is_connected":true,"name":"九寨沟县"},{"pinyin":"jinchuanxian","id":369,"is_connected":true,"name":"金川县"},{"pinyin":"xiaojinxian","id":370,"is_connected":true,"name":"小金县"},{"pinyin":"heishuixian","id":371,"is_connected":true,"name":"黑水县"},{"pinyin":"maerkangxian","id":372,"is_connected":true,"name":"马尔康县"},{"pinyin":"rangtangxian","id":373,"is_connected":true,"name":"壤塘县"},{"pinyin":"abaxian","id":374,"is_connected":true,"name":"阿坝县"},{"pinyin":"ruoergaixian","id":375,"is_connected":true,"name":"若尔盖县"},{"pinyin":"hongyuanxian","id":376,"is_connected":true,"name":"红原县"},{"pinyin":"chuanzhusi","id":436,"is_connected":true,"name":"川主寺"},{"pinyin":"shuimozhen","id":442,"is_connected":true,"name":"水磨镇"}]},{"id":359,"is_connected":true,"name":"资阳市","pinyin":"ziyangshi","children":[{"pinyin":"ziyangshi","id":359,"is_connected":true,"name":"资阳市"},{"pinyin":"anyuexian","id":360,"is_connected":true,"name":"安岳县"},{"pinyin":"lezhixian","id":361,"is_connected":true,"name":"乐至县"},{"pinyin":"jianyangshi","id":362,"is_connected":true,"name":"简阳市"},{"pinyin":"danshanzhen","id":542,"is_connected":true,"name":"丹山镇"}]},{"id":355,"is_connected":true,"name":"巴中市","pinyin":"bazhongshi","children":[{"pinyin":"bazhongshi","id":355,"is_connected":true,"name":"巴中市"},{"pinyin":"tongjiangxian","id":356,"is_connected":true,"name":"通江县"},{"pinyin":"nanjiangxian","id":357,"is_connected":true,"name":"南江县"},{"pinyin":"pingchangxian","id":358,"is_connected":true,"name":"平昌县"}]},{"id":340,"is_connected":true,"name":"达州市","pinyin":"dazhoushi","children":[{"pinyin":"dazhoushi","id":340,"is_connected":true,"name":"达州市"},{"pinyin":"xuanhanxian","id":342,"is_connected":true,"name":"宣汉县"},{"pinyin":"kaijiangxian","id":343,"is_connected":true,"name":"开江县"},{"pinyin":"dazhuxian","id":344,"is_connected":true,"name":"大竹县"},{"pinyin":"quxian","id":345,"is_connected":true,"name":"渠县"},{"pinyin":"wanyuanshi","id":346,"is_connected":true,"name":"万源市"}]},{"id":335,"is_connected":true,"name":"广安市","pinyin":"guanganshi","children":[{"pinyin":"guanganshi","id":335,"is_connected":true,"name":"广安市"},{"pinyin":"yuechixian","id":336,"is_connected":true,"name":"岳池县"},{"pinyin":"wushengxian","id":337,"is_connected":true,"name":"武胜县"},{"pinyin":"linshuixian","id":338,"is_connected":true,"name":"邻水县"},{"pinyin":"huayingshi","id":339,"is_connected":true,"name":"华蓥市"}]},{"id":325,"is_connected":true,"name":"宜宾市","pinyin":"yibinshi","children":[{"pinyin":"yibinshi","id":325,"is_connected":true,"name":"宜宾市"},{"pinyin":"yibinxian","id":326,"is_connected":true,"name":"宜宾县"},{"pinyin":"nanxiqu","id":327,"is_connected":true,"name":"南溪区"},{"pinyin":"jianganxian","id":328,"is_connected":true,"name":"江安县"},{"pinyin":"changningxian","id":329,"is_connected":true,"name":"长宁县"},{"pinyin":"gaoxian","id":330,"is_connected":true,"name":"高县"},{"pinyin":"gongxian","id":331,"is_connected":true,"name":"珙县"},{"pinyin":"junlianxian","id":332,"is_connected":true,"name":"筠连县"},{"pinyin":"xingwenxian","id":333,"is_connected":true,"name":"兴文县"},{"pinyin":"pingshanxian","id":334,"is_connected":true,"name":"屏山县"}]},{"id":319,"is_connected":true,"name":"眉山市","pinyin":"meishanshi","children":[{"pinyin":"meishanshi","id":319,"is_connected":true,"name":"眉山市"},{"pinyin":"renshouxian","id":320,"is_connected":true,"name":"仁寿县"},{"pinyin":"pengshanxian","id":321,"is_connected":true,"name":"彭山县"},{"pinyin":"hongyaxian","id":322,"is_connected":true,"name":"洪雅县"},{"pinyin":"danlengxian","id":323,"is_connected":true,"name":"丹棱县"},{"pinyin":"qingshenxian","id":324,"is_connected":true,"name":"青神县"}]},{"id":266,"is_connected":true,"name":"自贡市","pinyin":"zigongshi","children":[{"pinyin":"zigongshi","id":266,"is_connected":true,"name":"自贡市"},{"pinyin":"rongxian","id":267,"is_connected":true,"name":"荣县"},{"pinyin":"fushunxian","id":268,"is_connected":true,"name":"富顺县"}]},{"id":300,"is_connected":true,"name":"内江市","pinyin":"neijiangshi","children":[{"pinyin":"neijiangshi","id":300,"is_connected":true,"name":"内江市"},{"pinyin":"weiyuanxian","id":301,"is_connected":true,"name":"威远县"},{"pinyin":"zizhongxian","id":302,"is_connected":true,"name":"资中县"},{"pinyin":"longchangxian","id":303,"is_connected":true,"name":"隆昌县"}]},{"id":296,"is_connected":true,"name":"遂宁市","pinyin":"suiningshi","children":[{"pinyin":"suiningshi","id":296,"is_connected":true,"name":"遂宁市"},{"pinyin":"anjuqu","id":430,"is_connected":true,"name":"安居区"},{"pinyin":"pengxixian","id":297,"is_connected":true,"name":"蓬溪县"},{"pinyin":"shehongxian","id":298,"is_connected":true,"name":"射洪县"},{"pinyin":"dayingxian","id":299,"is_connected":true,"name":"大英县"}]},{"id":291,"is_connected":true,"name":"广元市","pinyin":"guangyuanshi","children":[{"pinyin":"guangyuanshi","id":291,"is_connected":true,"name":"广元市"},{"pinyin":"wangcangxian","id":292,"is_connected":true,"name":"旺苍县"},{"pinyin":"qingchuanxian","id":293,"is_connected":true,"name":"青川县"},{"pinyin":"jiangexian","id":294,"is_connected":true,"name":"剑阁县"},{"pinyin":"cangxixian","id":295,"is_connected":true,"name":"苍溪县"}]},{"id":555,"is_connected":true,"name":"拉萨市","pinyin":"ls","children":[{"pinyin":"ls","id":555,"is_connected":true,"name":"拉萨市"}]}]';


  static List<CityModel>  _cityList;
  static UserModel _defaultUser = new UserModel("点击登陆", '-', '-', '-', '-', '-');
  static UserModel user = _defaultUser;
  static var isLogin = false;
  static String cookie = "";

  ///获取城市列表
  static  List<CityModel> getCityList(){
    if(_cityList == null){
      List mapList = json.decode(_fromCityJson);
      List<CityModel> temp = mapList.map((m) => new CityModel.fromJson(m)).toList();
      _cityList = new List();
      for(CityModel city in temp){
        List<CityModel> children = city.children;
        city.children = null;
        city.isTitle = true;
        _cityList.add(city);
        //遍历子地区
        if(children != null && children.length > 0){
          for(CityModel child in children){
            child.isTitle = false;
            _cityList.add(child);
          }
        }
      }
    }
    return _cityList;
  }


  static void logout(){
    isLogin = false;
    cookie = '';
    user = _defaultUser;
  }
  ///存储用户名和密码
  static Future saveUsernamePwd(String username, String password) async {
    String fileName = '/userInfo';
    String key = Uuid().v1();
    String safeUsername = await FlutterDes.encryptToHex(username, key);
    String safePwd = await FlutterDes.encryptToHex(password, username);
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String data = key+','+safeUsername+','+safePwd;
    var file = await new File(appDocPath+fileName).create(recursive: true);
    file.writeAsBytesSync(utf8.encode(data));
  }

  ///读取用户名和密码
  static Future<Map<String, String>> getUsernamePwd() async {
    try{
      String fileName = '/userInfo';
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      var file = new File(appDocPath+fileName);
      if(await file.exists()){
        String dataStr = utf8.decode(file.readAsBytesSync());
        List<String> data = dataStr.split(',');
        String key = data[0];
        String username = await FlutterDes.decryptFromHex(data[1], key);
        String password = await FlutterDes.decryptFromHex(data[2], username);
        var map = Map<String, String>();
        map['username'] = username;
        map['password'] = password;
        return map;
      }
    }on Exception catch(e){
      print(e);
    }
    return null;
  }
}





