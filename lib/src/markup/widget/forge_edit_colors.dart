
part of '../controller/forge_mark_up_controller.dart';




class ForgeGroupMarkUpColors extends StatefulWidget {

  final MarkUpStyle markUpStyle;
  final ValueChanged<MarkUpStyle> onChanged;

  const ForgeGroupMarkUpColors({Key? key, required this.markUpStyle, required this.onChanged}) : super(key: key);

  static showPop(BuildContext context,{required MarkUpStyle markUpStyle,required ValueChanged<MarkUpStyle> onChanged}){
    return showCupertinoModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      expand: false,
      duration: const Duration(milliseconds: 500),
      builder: (context) => ForgeGroupMarkUpColors(markUpStyle: markUpStyle,onChanged: onChanged,),
    );
  }

  @override
  _ForgeGroupMarkUpColorsState createState() => _ForgeGroupMarkUpColorsState();
}

class _ForgeGroupMarkUpColorsState extends State<ForgeGroupMarkUpColors> {

  // final List<String> ticknessItems = [
  //   'Thin',
  //   'Normal',
  //   'Thick',
  //   'Very Thick',
  // ];



  List<int> fontSizeItems = [];

  List<int> opacity = [];

  late MarkUpStyle markUpStyle;



  @override
  void initState() {
    markUpStyle = widget.markUpStyle;
    fontSizeItems = [for (var i = 1; i <= 200; i++) i];
    opacity = [for (var i = 0; i <= 100; i++) i];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    List<String> colors = [

      "#6467F2",
      "#EF4444",
      "#F97316",
      "#FACC15",
      "#4ADE80",
      "#84CC16",
      "#10B981",

      "#EC4899",
      "#F43F5E",
      "#D946EF",
      "#8B5CF6",
      "#3B82F6",
      "#989898",
      "#2DD4BF",

    ];

    double iconSize = Theme.of(context).iconTheme.size ?? 25;

    return Material(
      color: Colors.transparent,
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MarkUpIcons.forgeBackgroundBlure),fit: BoxFit.cover
          ),
        ),
        padding: const EdgeInsets.only(right: 10,left: 10,bottom: 30,top: 10),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [

                          Row(
                            children: [

                              Expanded(
                                flex: 2,
                                child: CustomDropDown<int?>(
                                  title: "Font Size",
                                  items: fontSizeItems,
                                  value: markUpStyle.fontSize,
                                  hint: markUpStyle.fontSize.toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      markUpStyle = markUpStyle.copyWith(fontSize: value);
                                      widget.onChanged(markUpStyle);
                                    });
                                  },
                                ),
                              ),

                              const SizedBox(width: 10,),


                              Expanded(
                                flex: 3,
                                child: CustomDropDown<String?>(
                                  title: "Thickness",
                                  hint: markUpStyle.thickness,
                                  icon: const SizedBox(),
                                  itemHeight: 30,
                                  dropdownWidth: 300,
                                  selectedItemBuilder: (context){
                                    return [
                                      Row(
                                        children: [
                                          Text(markUpStyle.thickness,style: const TextStyle(
                                            fontSize: 15
                                          ),)
                                        ],
                                      ),
                                    ];
                                  },
                                  customItems: [

                                    DropdownMenuItem<String>(
                                      value: "Thin",
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            child: Text("Thin",style: TextStyle(
                                                fontSize: 15
                                            ),),
                                          ),
                                          const SizedBox(width: 10,),
                                          Expanded(
                                            child: Image.asset(MarkUpIcons.thickness_thin,color: Colors.black),
                                          )
                                        ],
                                      ),
                                    ),

                                    DropdownMenuItem<String>(
                                      value: "Normal",
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            child: Text("Normal",style: TextStyle(
                                                fontSize: 15
                                            ),),
                                          ),
                                          const SizedBox(width: 10,),
                                          Expanded(
                                            child: Image.asset(MarkUpIcons.thickness_normal,color: Colors.black),
                                          )
                                        ],
                                      ),
                                    ),

                                    DropdownMenuItem<String>(
                                      value: "Thick",
                                      child: Row(
                                        children: [
                                          const Expanded(child: Text("Thick",style: TextStyle(
                                              fontSize: 15
                                          ),)),
                                          const SizedBox(width: 10,),
                                          Expanded(child: Image.asset(MarkUpIcons.thickness_thick,color: Colors.black))
                                        ],
                                      ),
                                    ),

                                    DropdownMenuItem<String>(
                                      value: "Very Thick",
                                      child: Row(
                                        children: [
                                          const Expanded(child: Text("Very Thick",style: TextStyle(
                                              fontSize: 15
                                          ),)),
                                          const SizedBox(width: 10,),
                                          Expanded(child: Image.asset(MarkUpIcons.thickness_very_thick,color: Colors.black))
                                        ],
                                      ),
                                    ),

                                  ],
                                  value: "Thin",
                                  onChanged: (value) {
                                    log("onChanged : ${value}");
                                    setState(() {
                                      markUpStyle = markUpStyle.copyWith(thickness: value as String);
                                      widget.onChanged(markUpStyle);
                                    });
                                  },
                                ),
                              ),


                            ],
                          ),

                          const SizedBox(height: 5,),

                          Row(
                            children: [

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    const Padding(
                                      padding: EdgeInsets.only(left: 5,right: 5),
                                      child: Text("Font Style"),
                                    ),

                                    const SizedBox(height: 5,),


                                    Row(
                                      children: [

                                        Expanded(child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              markUpStyle = markUpStyle.copyWith(fontWeight: markUpStyle.fontWeight == "bold" ? "normal" : "bold");
                                              widget.onChanged(markUpStyle);
                                            });
                                          },
                                          child: Container(
                                            width: 50,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey,width: 0.5),
                                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                                color: markUpStyle.fontWeight == "bold" ? Colors.grey.withOpacity(0.5) : Colors.transparent
                                          ),
                                            padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                                            child: Text("B",style: TextStyle(fontWeight: FontWeight.bold,fontSize: iconSize),),
                                          ),
                                        )),

                                        const SizedBox(width: 10,),

                                        Expanded(child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              markUpStyle = markUpStyle.copyWith(fontStyle:markUpStyle.fontStyle == "italic" ? "normal" : "italic");
                                              widget.onChanged(markUpStyle);
                                            });
                                          },
                                          child: Container(
                                            width: 50,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey,width: 0.5),
                                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                                color: markUpStyle.fontStyle == "italic" ? Colors.grey.withOpacity(0.5) : Colors.transparent
                                            ),
                                            padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                                            child: Text("I",style: TextStyle(fontWeight: FontWeight.normal,fontSize: iconSize,fontStyle: FontStyle.italic),),
                                          ),
                                        ))

                                      ],
                                    )


                                  ],
                                ),
                              ),

                              const SizedBox(width: 10,),

                              Expanded(
                                child: Column(
                                  
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [


                                    CustomDropDown<int?>(
                                      title: "Opacity",
                                      items: opacity,
                                      afterText: " %",
                                      value: markUpStyle.opacity,
                                      hint: markUpStyle.opacity.toString(),
                                      onChanged: (value) {
                                        setState(() {
                                          markUpStyle = markUpStyle.copyWith(opacity: value);
                                          widget.onChanged(markUpStyle);
                                        });
                                      },
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          )


                        ],
                      ),
                    ),
                  ),


                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        runAlignment: WrapAlignment.start,
                        spacing: isMobile ? 5 : 10,
                        runSpacing: isMobile ? 5 : 10,
                        children: colors.map((color){
                          return InkWell(
                            onTap: (){
                              setState(() {
                                markUpStyle = markUpStyle.copyWith(color: color,backgroundColor: markUpStyle.backgroundIsColored ? color : null);
                                widget.onChanged(markUpStyle);
                              });
                            },
                            child: Container(
                              height: iconSize,width: iconSize,
                              decoration: BoxDecoration(
                                  color: Color(int.parse("0xff${color.replaceAll("#", "")}")),
                                  shape: BoxShape.circle
                              ),
                              child: Center(
                                child: markUpStyle.color == color ? const Icon(Icons.check,size: 10,color: Colors.white,) : const SizedBox(),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                ],
              ),


              const Padding(
                padding: EdgeInsets.only(left: 15,right: 15,top: 10),
                child: Text("Background"),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                child: Row(
                  children: [

                    InkWell(
                      onTap: (){
                        setState(() {
                          markUpStyle = markUpStyle.copyWith(backgroundColor: "");
                          widget.onChanged(markUpStyle);
                        });
                      },
                      child: Row(
                        children: [
                          const Text("Transparent"),
                          const SizedBox(width: 10,),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey)
                            ),
                            height: iconSize,width: iconSize,
                            child: Center(
                              child: markUpStyle.backgroundIsTransparant ? const Icon(Icons.check,size: 10,color: Colors.black,) : const SizedBox(),
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(width: 10,),

                    InkWell(
                      onTap: (){
                        setState(() {
                          markUpStyle = markUpStyle.copyWith(backgroundColor: "#FFFFFFF");
                          widget.onChanged(markUpStyle);
                        });
                      },
                      child: Row(
                        children: [
                          const Text("White"),
                          const SizedBox(width: 10,),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey)
                            ),
                            height: iconSize,width: iconSize,
                            child: Center(
                              child: markUpStyle.backgroundIsWhite ? const Icon(Icons.check,size: 10,color: Colors.black,) : const SizedBox(),
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(width: 10,),

                    InkWell(
                      onTap: (){
                        setState(() {
                          markUpStyle = markUpStyle.copyWith(backgroundColor: markUpStyle.color);
                          widget.onChanged(markUpStyle);
                        });
                      },
                      child: Row(
                        children: [
                          const Text("Colored"),
                          const SizedBox(width: 10,),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(int.parse("0xff${markUpStyle.color.replaceAll("#", "")}")),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey)
                            ),
                            height: iconSize,width: iconSize,
                            child: Center(
                              child: markUpStyle.backgroundIsColored ? const Icon(Icons.check,size: 10,color: Colors.black,) : const SizedBox(),
                            ),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );

  }

}


class CustomDropDown<T> extends StatelessWidget {
  final String title;
  final String hint;
  final String? afterText;
  final List<T>? items;
  final Widget? icon;
  final double? dropdownWidth;
  final double itemHeight;
  final List<DropdownMenuItem<T>>? customItems;
  final T value;
  final DropdownButtonBuilder? selectedItemBuilder;
  final ValueChanged<T?>? onChanged;
  const CustomDropDown({Key? key,
    required this.title, this.items,
    required this.value, this.onChanged, this.dropdownWidth,this.itemHeight = 30, required this.hint,this.afterText,this.customItems,this.icon,this.selectedItemBuilder}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
          child: Text(title),
        ),
        const SizedBox(height: 5,),
        DropdownButtonHideUnderline(
          child:DropdownButton2(
            hint: Text(
              hint,
              style: TextStyle(
                fontSize: 14,
                color: Theme
                    .of(context)
                    .hintColor,
              ),
            ),
            selectedItemBuilder:selectedItemBuilder,
            items: customItems ?? items!.map((item) =>
                DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    "${item.toString()}${afterText ?? ""}",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )).toList(),
            value: value,
            onChanged: onChanged,
            buttonHeight: 40,
            itemHeight: itemHeight,
            buttonWidth: MediaQuery.of(context).size.width,
            icon: icon ?? const Icon(
              Icons.arrow_downward_rounded,
              color: Colors.black,
            ),
            // dropdownScrollPadding: EdgeInsets.only(bottom: 10),
            iconSize: 18,
            iconEnabledColor: Colors.yellow,
            iconDisabledColor: Colors.grey,
            buttonPadding: const EdgeInsets.only(left: 14, right: 14),
            buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white.withOpacity(0.4),
                border: Border.all(color: Colors.grey.withOpacity(0.8),width: 0.5)
            ),
            buttonElevation: 0,
            itemPadding: const EdgeInsets.only(left: 14, right: 14,bottom: 0),
            dropdownMaxHeight: 200,
            dropdownWidth: dropdownWidth,
            dropdownPadding: null,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            scrollbarRadius: const Radius.circular(8),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
          ),
        ),
      ],
    );
  }
}