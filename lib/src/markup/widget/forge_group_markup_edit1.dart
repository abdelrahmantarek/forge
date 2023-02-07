
part of '../controller/forge_mark_up_controller.dart';



class ForgeGroupMarkUpEdit1<T> extends StatelessWidget {

  const ForgeGroupMarkUpEdit1({Key? key}) : super(key: key);

  static showPop(BuildContext context){
    return showCupertinoModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      expand: false,
      duration: const Duration(milliseconds: 500),
      builder: (context) => const ForgeGroupMarkUpEdit1(),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Material(
      color: Colors.transparent,
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MarkUpIcons.forgeBackgroundBlure),fit: BoxFit.cover
          ),
        ),
        padding: const EdgeInsets.only(right: 10,left: 10,bottom: 10,top: 0),

        child: Stack(
          children: [

            GetBuilder<ForgeMarkUpController>(
              id: "selected",
              builder: (controller){

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),


                    Row(
                      children: [


                        ForgeIconTitle(
                          title: "Highlight",
                          icon: MarkUpIcons.highlight,
                          selected: controller.selected == "highlight",
                          border: false,
                          fillIconColor: Theme.of(context).primaryColor,
                          onTap: (){
                            controller.highlight();
                            Navigator.pop(context);
                          },
                        ),

                        ForgeIconTitle(
                          title: "Symbols",
                          icon: MarkUpIcons.symbols,
                          selected: controller.selected == "symbols",
                          border: false,
                          fillIconColor: Theme.of(context).primaryColor,
                          onTap: (){
                            controller.symbols();
                            Navigator.pop(context);
                          },
                        ),


                        ForgeIconTitle(
                          title: "Stamps",
                          icon: MarkUpIcons.stamps,
                          selected: controller.selected == "stamp",
                          border: false,
                          fillIconColor: Theme.of(context).primaryColor,
                          onTap: (){
                            controller.stamp();
                            Navigator.pop(context);
                          },
                        ),

                      ],
                    ),

                    const SizedBox(height: 10,),

                    SizedBox(
                      child: Row(
                        children: [
                          ForgeIconTitle(
                            title: "Ellipse",
                            icon: MarkUpIcons.circle,
                            border: false,
                            selected: controller.selected == "circle",
                            onTap: (){
                              controller.circle();
                              Navigator.pop(context);
                            },
                          ),

                          ForgeIconTitle(
                            title: "Rectangle",
                            icon: MarkUpIcons.rectangle,
                            border: false,
                            selected: controller.selected == "rectangle",
                            onTap: (){
                              controller.rectangle();
                              Navigator.pop(context);
                            },
                          ),

                          ForgeIconTitle(
                            title: "Cloud",
                            icon: MarkUpIcons.circle2,
                            border: false,
                            selected: controller.selected == "cloud",
                            onTap: (){
                              controller.cloud();
                              Navigator.pop(context);
                            },
                          ),

                          ForgeIconTitle(
                            title: "Arrow",
                            icon: MarkUpIcons.arrowRight,
                            selected: controller.selected == "arrow",
                            border: false,
                            onTap: (){
                              controller.arrow();
                              Navigator.pop(context);
                            },
                          ),

                        ],
                      ),
                    ),


                  ],
                );


              },
            )

          ],
        ),
      ),
    );

  }

}







