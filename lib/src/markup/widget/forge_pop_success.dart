



part of '../controller/forge_mark_up_controller.dart';




showPopSuccess(BuildContext context,String title){
  showDialog(
      context: context,
      builder: (context){
        return SuccessPop(title: title,);
      }
  );
}

class SuccessPop extends StatelessWidget {
  final String title;
  const SuccessPop({Key? key,required this.title}) : super(key: key);
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
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.white
            ),
            child: Column(
              children: [


                const SizedBox(height: 50,),


                Column(
                  children: [

                    SvgPicture.asset("packages/forge/assets/forge/icons/done.svg",height: 80,width: 120,color: Theme.of(context).primaryColor,),

                    const SizedBox(height: 30,),

                    Text(title,style: Theme.of(context).textTheme.titleLarge,),

                  ],
                ),

                const SizedBox(height: 20,),



                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(

                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0))
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      ),
                      child: const Text("Done"),
                    ),
                  ),
                ),

                const SizedBox(height: 50,),

              ],
            ),
          ),
        ),

      ],
    );
  }
}

