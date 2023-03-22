part of '../controller/forge_mark_up_controller.dart';



class _MarkUpBottomNavigation extends StatelessWidget {
  const _MarkUpBottomNavigation({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final controller = Get.find<ForgeMarkUpController>();

    double iconSize = Theme.of(context).iconTheme.size ?? 25;


    return Container(
      height: MediaQuery.of(context).size.longestSide * 0.07,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(MarkUpIcons.forgeBackgroundBlure),fit: BoxFit.cover
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [


            BottomNavigationItemMarkUp(
              onTap: (){
                // controller.evaluateJavascript("onMarkupViewerLoaded()");
                ForgeGroupMarkUpColors.showPop(
                  context,
                  markUpStyle: controller.currentMarkUpStyle,
                  onChanged:controller.onMarkUpStyleChanged,
                );
              },
              onLongPress: (){
                controller.onViewerLoaded(context);
              },
              icon: Image.asset(MarkUpIcons.colors,color: Theme.of(context).primaryColor,),
            ),


            BottomNavigationItemMarkUp(
              onTap: (){
                ForgeGroupMarkUpEdit1.showPop(context);
              },
              icon: Image.asset(MarkUpIcons.groupEditCircle,color: Theme.of(context).primaryColor,),
            ),


            GetBuilder<ForgeMarkUpController>(
              id: "selected",
              builder: (controller){
                return BottomNavigationItemMarkUp(
                  onTap: (){
                    controller.text();
                  },
                  selected: controller.selected == "text",
                  icon: Image.asset(MarkUpIcons.addText,color:  controller.selected == "text" ? Theme.of(context).primaryColor.withAlpha(100) : Theme.of(context).primaryColor,),
                );
              },
            ),


            GetBuilder<ForgeMarkUpController>(
              id: ForgeMarkUpController.undoRedoBuilder,
              builder: (controller){
                return BottomNavigationItemMarkUp(
                  onTap: controller.undoValue ? (){
                    controller.undo();
                  } : null,
                  icon: Image.asset(MarkUpIcons.undo,color: controller.undoValue ? Theme.of(context).primaryColor : Colors.grey,),
                );
              },
            ),


            GetBuilder<ForgeMarkUpController>(
              id: ForgeMarkUpController.undoRedoBuilder,
              builder: (controller){
                return BottomNavigationItemMarkUp(
                  onTap: controller.redoValue ? (){
                    controller.redo();
                  } : null,
                  icon: Image.asset(MarkUpIcons.redo,color:  controller.redoValue ? Theme.of(context).primaryColor : Colors.grey,),
                );
              },
            ),



            if(context.isLandscape) BottomNavigationItemMarkUp(
              onTap: (){
                controller.rotate();
              },
              icon:  Image.asset(MarkUpIcons.rotate,color: Theme.of(context).primaryColor,),
            ),


            // if(context.isLandscape) GetBuilder<ForgeMarkUpController>(
            //   id: "selected",
            //   builder: (controller){
            //     return BottomNavigationItemMarkUp(
            //       onTap: (){
            //         controller.clearSelection();
            //       },
            //       icon: Image.asset(
            //         MarkUpIcons.hand,
            //         color: Theme.of(context).primaryColor,
            //       ),
            //     );
            //   },
            // ),


            if(context.isLandscape) BottomNavigationItemMarkUp(
              onTap: (){
                controller.save();
                // controller.test();
              },
              icon: Icon(Icons.save,size: iconSize + 5,),
            ),


          ],
        ),
      ),
    );
  }
}


class BottomNavigationItemMarkUp extends StatelessWidget {
  final Widget? icon;
  final bool selected;
  final Function()? onTap;
  final Function()? onLongPress;
  const BottomNavigationItemMarkUp({Key? key, this.selected = false, this.onTap, this.onLongPress, required this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double iconSize = Theme.of(context).iconTheme.size ?? 25;
    return InkWell(
      onTap:onTap,
      onLongPress: onLongPress,
      child: Container(
        width: iconSize,
        height: iconSize,
        decoration: BoxDecoration(
          // border: border ? Border.all(color: Theme.of(context).accentColor) : null,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: selected ? Theme.of(context).accentColor.withOpacity(0.1) : Colors.transparent
          // color: Colors.red,
        ),
        child:icon,
      ),
    );
  }
}

