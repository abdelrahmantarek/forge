
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart' as lottie;



class ForgeLoading extends StatelessWidget {
  final double size;
  final String title;
  const ForgeLoading({Key? key, required this.size,this.title = "Loading..."}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size,width: size,
            child: Stack(
              children: [


                Positioned.fill(
                  child: SizedBox(
                    height: size * 0.9,
                    width: size * 0.9,
                    child: Transform.scale(
                      scale: size * 0.01,
                      child: lottie.Lottie.asset(
                        "packages/forge/assets/animations/sand-clock.json",
                        delegates: lottie.LottieDelegates(
                          values: [
                            lottie.ValueDelegate.color(
                              const ["bottom sand 2","Group 1","Fill 1"],
                              value: Theme.of(context).primaryColor,
                            ),
                            lottie.ValueDelegate.color(
                              const ["top sand","Group 1","Fill 1"],
                              value: Theme.of(context).primaryColor,
                            ),
                            lottie.ValueDelegate.color(
                              const ["bottom fill","Group 1","Fill 1"],
                              value: Theme.of(context).primaryColor,
                            ),
                            lottie.ValueDelegate.color(
                              const ["top fill","Group 1","Fill 1"],
                              value: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Center(
                  child: SizedBox(
                    height: size,
                    width: size,
                    child:CircularProgressIndicator(
                      // backgroundColor: Colors.pinkAccent,
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    ),
                  ),
                )

              ],
            ),
          ),
          if(title.isNotEmpty) const SizedBox(height: 20,),
          if(title.isNotEmpty) Text(title,style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),),
        ],
      ),
    );
  }
}
