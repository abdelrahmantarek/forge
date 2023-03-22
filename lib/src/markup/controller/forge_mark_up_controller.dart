
import 'dart:convert';
import 'dart:developer';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forge/src/assets/MarkUpIcons.dart';
import 'package:forge/src/markup/model/device.dart';
import 'package:forge/src/markup/widget/custom_pop_yes_no.dart';
import 'package:forge/src/markup/widget/forge_loading.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' hide ModalBottomSheetRoute;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webviewx/webviewx.dart';

import '../../../forge.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:ui' as ui;

part 'forge_mark_up_overrides.dart';
part '../model/forge_mark_up_style.dart';
part '../view/forge_mark_up_view.dart';

part '../widget/forge_bottom_navigation_item.dart';
part '../widget/forge_edit_colors.dart';
part '../widget/forge_group_markup_edit1.dart';
part '../widget/forge_icon_title.dart';
part '../widget/forge_pop_success.dart';
part '../widget/forge_mark_up_app_bar.dart';



/// An event handler is responsible for reacting to an incoming [Event]
/// and can emit zero or more states via the [Emitter].
typedef OnMarkUpViewCrated = void Function(ForgeMarkUpController controller);




class ForgeMarkUpController extends GetxController with ForgeMarkUpOverrides{

  late WebViewXController webViewXController;
  late MarkUpStyle currentMarkUpStyle;

  final OnMarkUpViewCrated? onMarkUpViewCrated;
  final Function()? onSavedListener;


  String? base64;
  String? imageUrl;

  final bool logJavaScriptFunctions;

  RxString selected = "".obs;



  bool forgeLoading = true;

  static const String LOG = "ForgeMarkUpController : ";
  static const String undoRedoBuilder = "undoRedoBuilder";

  ForgeMarkUpController( {this.base64,this.imageUrl,this.logJavaScriptFunctions = false,this.onMarkUpViewCrated, this.onSavedListener,});

  bool redoValue = false;

  bool undoValue = false;


  Set<DartCallback> dartCallBack(BuildContext context){
    return {

      DartCallback(
          name: 'onViewerLoaded_Flutter',
          callBack: (message) {
            if(onMarkUpViewCrated != null) onMarkUpViewCrated!(this);
            onViewerLoaded(context);
          }
      ),

      DartCallback(
          name: 'onSave_Flutter',
          callBack: (message) {
            if(onSavedListener != null) onSavedListener!();
            onSaved(context);
          }
      ),

      DartCallback(
          name: 'onHistoryChanged_Flutter',
          callBack: (message) {
            onHistoryChanged(message);
          }
      ),

      DartCallback(
          name: 'onEditModeLeave_Flutter',
          callBack: (message) {
            onEditModeLeaveFlutter(message);
          }
      ),

    };
  }




  @override
  void save() {
    onMarkUpToolClicked("save");
  }

  @override
  void undo() {
    onMarkUpToolClicked("undo");
  }

  @override
  void arrow() {
    onMarkUpToolClicked("arrow");
    selected.value = "arrow";
    updateUpStyle(currentMarkUpStyle);
  }

  @override
  void circle() {
    onMarkUpToolClicked("circle");
    selected.value = "circle";
    updateUpStyle(currentMarkUpStyle);
  }

  @override
  void cloud() {
    onMarkUpToolClicked("cloud");
    selected.value = "cloud";
    updateUpStyle(currentMarkUpStyle);
  }

  @override
  void delete() {
    onMarkUpToolClicked("delete");
    updateUpStyle(currentMarkUpStyle);
  }

  @override
  void highlight() {
    onMarkUpToolClicked("highlight");
    selected.value = "highlight";
    updateUpStyle(currentMarkUpStyle);
  }

  @override
  void rectangle() {
    onMarkUpToolClicked("rectangle");
    selected.value = "rectangle";
    updateUpStyle(currentMarkUpStyle);
  }

  @override
  void redo() {
    onMarkUpToolClicked("redo");
  }

  @override
  void rotate() {
    onMarkUpToolClicked("rotate-right");
  }

  @override
  void symbols() {
    onMarkUpToolClicked("symbols");
    updateUpStyle(currentMarkUpStyle);
  }

  @override
  void text() {
    onMarkUpToolClicked("text");
    selected.value = "text";
    updateUpStyle(currentMarkUpStyle);
  }

  @override
  void stamp() {
    onMarkUpToolClicked("stamp");
    updateUpStyle(currentMarkUpStyle);
  }

  @override
  void edit() {
    if(editMode && selected.isNotEmpty){
      if(selected.value == "edit"){
        onMarkUpToolClicked("edit");
      }else{
        onMarkUpToolClicked("edit");
        onMarkUpToolClicked("edit");
      }
    }else{
      onMarkUpToolClicked("edit");
    }
    selected.value = "edit";
    updateUpStyle(currentMarkUpStyle);
  }

  void clearSelection(){
    onMarkUpToolClicked("edit");
    onMarkUpToolClicked("edit");
    selected.value = "";
  }

  // markupsComponent.onMarkupToolClicked({id:'text'})

  void onMarkUpToolClicked(String id){
    String function = "markupsComponent.onMarkupToolClicked({id:'$id'})";
    evaluateJavascript(function);
    if(logJavaScriptFunctions) log("$LOG $function");
  }
  
  void evaluateJavascript(dynamic name,[List<dynamic>? params]){
    if(logJavaScriptFunctions) log("$LOG $name");
    webViewXController.callJsMethod(name, ['test']);
  }

  @override
  void updateUpStyle(MarkUpStyle markUpStyle) {
    _updateUpStyle(markUpStyle.toForge());
    markUpStyle.saveLocalStyle(markUpStyle);
  }

  void _updateUpStyle(Map<String,dynamic> style) {
    var function = "updateMarkupsStyle('${jsonEncode(style)}')";
    if(logJavaScriptFunctions) log("$LOG $function");
    evaluateJavascript(function);
  }

  void onMarkUpStyleChanged(MarkUpStyle value) async {
    currentMarkUpStyle = value;
    updateUpStyle(value);
  }



  @override
  void onInit() {
    getCurrentStyle();
    selected.listen((p0) {
      if(selected.value.isEmpty){
        editMode = false;
      }else{
        editMode = true;
      }
      update(["selected"]);
      log("selected mode $selected");
    });
    super.onInit();
  }


  void getCurrentStyle() async {
    currentMarkUpStyle = MarkUpStyle();
    currentMarkUpStyle = await currentMarkUpStyle.getCurrentMarkUpStyle();
  }


  void onSaved(BuildContext context) {

    showPopSuccess(context,"Saved");
    hasNoChanged = false;
    clearSelection();

  }

  void onViewerLoaded(BuildContext context) async {

    if(this.base64 != null){
      await Future.delayed(const Duration(seconds: 1));
    }

    if(logJavaScriptFunctions) log("$LOG ${"onViewerLoaded ------------"}");
    // await Future.delayed(const Duration(seconds: 1));
    String base64 = await getBase64();
    evaluateJavascript("drawImage64OnPlane('data:image/png;base64,$base64',markupsComponent.markupViewer)");
    forgeLoading = false;
    hasNoChanged = false;
    update(["loading"]);

    _resetUndoRedo();

  }


  void _resetUndoRedo(){

    redoValue = false;
    undoValue = false;
    update([undoRedoBuilder]);

  }

  Future<String> getBase64() async {

    if(base64 != null){
      return base64!;
    }

    String base = await networkImageToBase64(imageUrl!);
    base64 = base;
    return base64!;

  }


  Future<String> networkImageToBase64(String imageUrl) async {
    dio.Response response = await dio.Dio().get(imageUrl,options: dio.Options(responseType: dio.ResponseType.bytes),);
    return base64Encode(response.data);
  }


  void onHistoryChanged(message) {

    var json = jsonDecode(message.toString());
    redoValue = !json["redo"];
    undoValue = !json["undo"];


    if(undoValue){
      hasNoChanged = true;
    }

    log("onHistoryChanged : redo $redoValue undo $undoValue hasNoChanged $hasNoChanged");

    update([undoRedoBuilder]);
  }



  void onEditModeLeaveFlutter(message) {
    editMode = false;
    selected.value = "";
    log("onEditModeLeave_Flutter : $message");
  }


  bool editMode = false;

  bool hasNoChanged = false;

}