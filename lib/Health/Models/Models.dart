
//API获取的全部数据
class DatasModel {
  final ChinaTotal chinaTotal;        //中国今日情况
  final List<InListDay> chinaDayList; //中国最近趋势
  final List<Country> areaTree;       //所有国家的信息
  final String lastUpdateTime;        //国内更新时间
  final String overseaLastUpdateTime; //国外更新时间

  // 构造函数
  DatasModel({
    this.chinaTotal, 
    this.chinaDayList, 
    this.areaTree, 
    this.lastUpdateTime, 
    this.overseaLastUpdateTime}
  );

  // 工厂方法
  factory DatasModel.fromJson(Map<String, dynamic> json){
    
    if (json == null) {
      return null;
    }
    List chinaDaylist = List<InListDay>();
    List children1 = json['chinaDayList'];
    children1.forEach((element) {
      var daylist = InListDay.fromJson(element);
      chinaDaylist.add(daylist);
    });
    
    List countries = List<Country>();
    List children2 = json['areaTree'];
    children2.forEach((element) {
      var country = Country.fromJson(element);
      countries.add(country);
    });

    var model = DatasModel(
      chinaTotal: ChinaTotal.fromJson(json['chinaTotal']),
      chinaDayList: chinaDaylist,
      areaTree: countries,
      lastUpdateTime: json['lastUpdateTime'],
      overseaLastUpdateTime: json['overseaLastUpdateTime'],
    );

    return model;
  }
}

//2.中国今日情况
class ChinaTotal {
  final CaseInfo today;               //国内今日情况
  final CaseInfo total;               //国内至今情况
  final ExtData extData;              //额外信息（无症状感染者）

  //构造方法
  ChinaTotal({this.today, this.total, this.extData});

  // 工厂方法
  factory ChinaTotal.fromJson(Map<String, dynamic> json){
    if (json == null) {
        return null;
    }
    var chanaTotal = ChinaTotal(
      today: CaseInfo.fromJson(json['today']),
      total: CaseInfo.fromJson(json['total']),
      extData: ExtData.fromJson(json['extData']),
    );

    return chanaTotal;
  }
}

//3.中国最近趋势
class InListDay {  
  final String date;                  //更新日期
  final CaseInfo today;               //国内今日情况
  final CaseInfo total;               //国内至今情况
  final ExtData extData;              //无症状感染者
  final String lastUpdateTime;        //更新时间
  
  // 构造方法
  InListDay({this.date, this.today, this.total, this.extData, this.lastUpdateTime});

  // 工厂方法
  factory InListDay.fromJson(Map<String, dynamic> json){
    if (json == null) {
      return null;
    }
    var inListDay = InListDay(
      date: json['date'],
      today: CaseInfo.fromJson(json['today']),
      total: CaseInfo.fromJson(json['total']),
      extData: ExtData.fromJson(json['extData']),
      lastUpdateTime: json['lastUpdateTime'],
    );
    
    return inListDay;
  }
}

// 4.国家
class Country {
  final String name;                  //国家名
  final String id;                    //国家编码
  final CaseInfo today;               //国家今日情况
  final CaseInfo total;               //国家总体情况
  final ExtData extData;              //无症状感染者
  final String lastUpdateTime;        //上次更新时间
  final List<Province> children;      //省列表
  
  //构造函数
  Country({this.name, this.id, this.today, this.total, this.extData, this.lastUpdateTime, this.children});

  // 工厂方法
  factory Country.fromJson(Map<String, dynamic> json){
    if (json == null) {
      return null;
    }
    List<Province> provinces = List();
    List children = json['children'];
    children.forEach((element) { 
      var province = Province.fromJson(element);
      provinces.add(province);
    });

    var country = Country(
      name: json['name'],
      id: json['id'],
      today: CaseInfo.fromJson(json['today']),
      total: CaseInfo.fromJson(json['total']),
      extData: ExtData.fromJson(json['extData']),
      lastUpdateTime: json['lastUpdateTime'],
      children: provinces,
    );

    return country;
  }
}

//5.省
class Province {
  final String name;
  final String id;
  final CaseInfo today;
  final CaseInfo total;
  final ExtData extData;
  final String lastUpdateTime;
  final List<City> children;

  // 构造函数
  Province({this.name, this.id, this.today, this.total, this.extData, this.lastUpdateTime, this.children});

  // 工厂方法
  factory Province.fromJson(Map<String, dynamic> json){
    if (json == null) {
      return null;
    }
    //城市列表
    List cities = List<City>();
    List children = json['children'];
    children.forEach((element) { 
      var city = City.fromJson(element);
      cities.add(city);
    });

    return Province(
      name: json['name'],
      id: json['id'],
      today: CaseInfo.fromJson(json['today']),
      total: CaseInfo.fromJson(json['total']),
      extData: ExtData.fromJson(json['extData']),
      lastUpdateTime: json['lastUpdateTime'],
      children: cities,
    );
  }
}

//6.城市
class City {
  final String name;            //城市名
  final String id;              //编码
  final String lastUpdateTime;  //上次更新时间
  final CaseInfo today;         //今天数字
  final CaseInfo total;         //总计数字
  final ExtData extData;        //额外信息

  // 构造函数
  City({this.name, this.id, this.lastUpdateTime, this.today, this.total, this.extData});
  
  // 工厂方法
  factory City.fromJson(Map<String, dynamic> json){

    if (json == null) {
      return null;
    }
    return City(
      name: json['name'],
      id: json['id'],
      lastUpdateTime: json['lastUpdateTime'],
      today: CaseInfo.fromJson(json['today']),
      total: CaseInfo.fromJson(json['total']),
      extData: ExtData.fromJson(json['extData']),
    );
  }
}

//7.病例相关数字
class CaseInfo {
  final int confirm;      //累计确诊
  final int storeConfirm; //现有确诊的增减情况（==今日的确诊变化）
  final int suspect;      //疑似病例
  final int heal;         //治愈
  final int dead;         //死亡
  final int severe;       //重症
  final int input;        //境外输入病例
  
  // 构造函数
  CaseInfo({this.confirm, this.storeConfirm, this.suspect, this.heal, this.dead, this.severe, this.input});

  // 工厂方法
  factory CaseInfo.fromJson(Map<String, dynamic> json){
    if (json == null) {
      return null;
    }
    var caseinfo = CaseInfo(
      confirm: json['confirm'] ?? 0,
      storeConfirm: json['storeConfirm'] ?? 0,
      suspect: json['suspect'] ?? 0,
      heal: json['heal'] ?? 0,
      dead: json['dead'] ?? 0,
      severe: json['severe'] ?? 0,
      input: json['input'] ?? 0,
    );

    return caseinfo;
  }
}

//8.额外信息
class ExtData {
  final int noSymptom;     //无症状感染者
  final int incrNoSymptom; //无症状感染者的增减情况（==今日的无症状感染者）
  
  // 构造函数
  ExtData({this.noSymptom, this.incrNoSymptom});

  // 工厂方法
  factory ExtData.fromJson(Map<String, dynamic> json){
    if (json == null) {
      return null;
    }
    return ExtData(
      noSymptom: json['noSymptom'] ?? 0,
      incrNoSymptom: json['incrNoSymptom'] ?? 0,
    );
  }
}


//新闻
class NewsModel{
  int id;
  String title;
  String summary;
  String sourceUrl;
  String infoSource;
  String provinceId;
  String pubDateStr;
  int pubDate;

  //构造函数
  NewsModel({
    this.id, 
    this.title, 
    this.summary, 
    this.sourceUrl, 
    this.infoSource, 
    this.provinceId, 
    this.pubDateStr, 
    this.pubDate
});

  factory NewsModel.fromJson(Map<String, dynamic> json){
    if (json == null) {
      return null;
    }
    var model = NewsModel(
      id: json['id'],
      title: json['title'],
      summary: json['summary'],
      sourceUrl: json['sourceUrl'],
      infoSource: json['infoSource'],
      provinceId: json['provinceId'],
      pubDateStr: json['pubDateStr'],
      pubDate: json['pubDate'],
    );

    return model;
  }
}