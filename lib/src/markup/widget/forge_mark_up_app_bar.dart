

part of '../controller/forge_mark_up_controller.dart';


class CustomIcon extends StatelessWidget {
  final Function()? onTap;
  final Widget icon;
  final bool selected;
  const CustomIcon({Key? key,this.onTap,required this.icon,this.selected = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: selected ? Colors.white.withOpacity(0.2) : Colors.transparent,
      ),
      child: InkWell(
        onTap:onTap,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          child: icon,
        ),
      ),
    );
  }
}


_markUpAppBar(BuildContext context,{Function()? onDeletePressed}){


  final controller = Get.find<ForgeMarkUpController>();

  double iconSize = Theme.of(context).iconTheme.size ?? 25;

  return AppBar(
    centerTitle: false,
    elevation: 0,
    title: const Text("Mark-up"),
    actions: [


      Row(
        children: [

          GetBuilder<ForgeMarkUpController>(
            id: "selected",
            builder: (controller){
              return CustomIcon(
                onTap: (){
                  controller.edit();
                },
                selected: controller.editMode,
                icon: const Icon(Icons.edit),
              );
            },
          ),

          // if(!context.isLandscape) GetBuilder<ForgeMarkUpController>(
          //   id: "selected",
          //   builder: (controller){
          //     return IconButton(
          //       onPressed: (){
          //         controller.clearSelection();
          //       },
          //       icon: Image.asset(
          //         MarkUpIcons.hand,
          //         width: iconSize - 5,
          //         color: Colors.white,
          //       ),
          //     );
          //   },
          // ),

          if(onDeletePressed != null) IconButton(
            onPressed:onDeletePressed,
            icon: Image.asset(MarkUpIcons.delete,width: iconSize,color: Colors.white,),
          ),

          if(!context.isLandscape) IconButton(
            onPressed: (){
              controller.rotate();
            },
            icon: Image.asset(
              MarkUpIcons.rotate,
              width: iconSize - 5,
              color: Colors.white,
            ),
          ),

          if(!context.isLandscape) IconButton(
            onPressed: (){
              controller.save();
            },
            icon: const Icon(Icons.save),
          ),

          if(!context.isLandscape) const SizedBox(width: 5,)

        ],
      )


    ],

  );
}