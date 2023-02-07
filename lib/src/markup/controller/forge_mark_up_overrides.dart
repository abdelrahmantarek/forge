
part of 'forge_mark_up_controller.dart';


abstract class ForgeMarkUpOverrides{

  void save();

  void undo();

  void redo();

  void delete();

  void rotate();

  void text();

  void highlight();

  void symbols();

  void circle();

  void rectangle();

  void cloud();

  void arrow();

  void stamp();

  void edit();

  void updateUpStyle(MarkUpStyle markUpStyle);

}