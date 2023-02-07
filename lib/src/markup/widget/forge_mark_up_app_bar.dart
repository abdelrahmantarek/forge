

part of '../controller/forge_mark_up_controller.dart';


_markUpAppBar(BuildContext context){


  final controller = Get.find<ForgeMarkUpController>();

  double iconSize = Theme.of(context).iconTheme.size ?? 25;

  return AppBar(
    centerTitle: false,
    elevation: 0,
    title: const Text("Mark-up"),
    actions: [

      if(!context.isLandscape) GetBuilder<ForgeMarkUpController>(
        id: "selected",
        builder: (controller){
          return IconButton(
            onPressed: (){
              controller.clearSelection();
            },
            icon: Image.asset(
              MarkUpIcons.hand,
              width: iconSize,
              color: Colors.white,
            ),
          );
        },
      ),

      if(!context.isLandscape) IconButton(
        onPressed: (){
          controller.delete();
        },
        icon: Image.asset(MarkUpIcons.delete,width: iconSize,color: Colors.white,),
      ),

      if(!context.isLandscape) IconButton(
        onPressed: (){
          controller.rotate();
        },
        icon: Image.asset(
          MarkUpIcons.rotate,
          width: iconSize,
          color: Colors.white,
        ),
      ),

      if(!context.isLandscape) IconButton(
        onPressed: (){
          controller.save();
        },
        icon: Icon(Icons.save,size: iconSize + 5,
        ),
      ),

      if(!context.isLandscape) const SizedBox(width: 5,)

    ],

  );
}