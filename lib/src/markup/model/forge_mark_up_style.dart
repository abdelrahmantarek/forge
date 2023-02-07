
part of '../controller/forge_mark_up_controller.dart';

class MarkUpStyle{

  final String thickness;
  final int fontSize;
  final int opacity;
  final String fontStyle;
  final String fontWeight;
  final String color;
  final String backgroundColor;

  MarkUpStyle(
      {this.thickness = "Thick",
        this.fontSize = 20,
        this.opacity = 100,
        this.fontStyle = "normal",
        this.fontWeight = "normal",
        this.backgroundColor = "",
        this.color = "#6467F2"});

  factory MarkUpStyle.fromJson(dynamic json){
    return MarkUpStyle(
      thickness: json["thickness"],
      fontSize: json["fontSize"],
      opacity: json["opacity"],
      fontStyle: json["fontStyle"],
      fontWeight: json["fontWeight"],
      color: json["color"],
      backgroundColor: json["backgroundColor"],
    );
  }


  MarkUpStyle copyWith({
    String? thickness,
    int? fontSize,
    int? opacity,
    String? fontStyle,
    String? fontWeight,
    String? color,
    String? backgroundColor,
  }){
    return MarkUpStyle(
      thickness: thickness ?? this.thickness,
      fontSize: fontSize ?? this.fontSize,
      opacity: opacity ?? this.opacity,
      fontStyle: fontStyle ?? this.fontStyle,
      color: color ?? this.color,
      fontWeight: fontWeight ?? this.fontWeight,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  Map<String,dynamic> toSaveOnCache(){
    return {
      "thickness":thickness,
      "fontSize":fontSize,
      "opacity":opacity,
      "fontStyle":fontStyle,
      "color":color,
      "fontWeight":fontWeight,
      "backgroundColor":backgroundColor,
    };
  }

  double get getThick{
    switch(thickness){
      case "Thin": return 0.02;
      case "Normal": return 0.06;
      case "Thick": return 0.010;
      case "Very Thick": return 0.015;
    }
    return 0.06;
  }

  Map<String,dynamic> toForge(){
    return {
      "stroke-color":color,
      "stroke-opacity":opacity / 100,
      "stroke-width":getThick,
      "fill-color":backgroundColor,
      "fill-opacity":opacity / 100,
      "font-size":fontSize / 100,
      "font-style":fontStyle,
      "font-weight":fontWeight,
      "font-family":"Arial"
    };
  }


  bool get backgroundIsWhite{
    return backgroundColor == "#FFFFFFF";
  }

  bool get backgroundIsTransparant{
    return backgroundColor == "";
  }

  bool get backgroundIsColored{
    return backgroundColor == color;
  }


  SharedPreferences? _sharedPreferences;


  Future<SharedPreferences> get _preferences async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  void saveLocalStyle(MarkUpStyle markUpStyle) async {
    var pref = await _preferences;
    pref.setString("MarkUpStyle", jsonEncode(markUpStyle.toSaveOnCache()));
  }

  Future<bool> clearLocalStyle() async {
    var pref = await _preferences;
    await pref.remove("MarkUpStyle");
    return true;
  }

  Future<MarkUpStyle> getCurrentMarkUpStyle() async {
    var pref = await _preferences;
    try{
      return MarkUpStyle.fromJson(jsonDecode(pref.getString("MarkUpStyle")!));
    }catch(err){
      return MarkUpStyle();
    }
  }

}
