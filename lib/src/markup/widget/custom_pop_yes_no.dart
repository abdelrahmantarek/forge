import 'package:flutter/material.dart';
import 'package:get/get.dart';



class CustomPopYesNo extends StatelessWidget {

  final String? title;
  final String? subTitle;

  const CustomPopYesNo({Key? key,this.title, this.subTitle}) : super(key: key);

  static Future<bool?> show({String? title,String? subTitle}){
    return showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomPopYesNo(title: title,subTitle: subTitle,);
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Material(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: Container(
            width: 500,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.white
            ),
            child: Column(
              children: [

                const SizedBox(height: 30,),

                Row(
                  children:  [
                    const SizedBox(width: 10,),
                    Expanded(child: Text("Discard changes?",style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600
                    ),),),
                  ],
                ),

                const SizedBox(height: 10,),

                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("If you discard changes, you will not be able to get back to it again.",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Color(0xFF828282)),
                    )
                ),


                const SizedBox(height: 20,),

                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [

                      Expanded(
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                          child: const Center(
                            child: Opacity(
                              opacity: 0.5,
                              child: Text("No"),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10,),

                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pop(true);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8.0))
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                          ),
                          child: const Text("Yes,Discard changes"),
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 20,),

              ],
            ),
          ),
        ),

      ],
    );
  }

}