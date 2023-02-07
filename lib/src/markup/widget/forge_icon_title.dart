
part of '../controller/forge_mark_up_controller.dart';


class ForgeIconTitle extends StatelessWidget {

  final String title;
  final String icon;
  final bool selected;
  final bool border;
  final Function()? onTap;
  final Color? fillIconColor;

  const ForgeIconTitle({Key? key, required this.title, this.border = true, required this.icon, this.selected = false, this.onTap, this.fillIconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconSize = Theme.of(context).iconTheme.size ?? 25;
    return Container(
      height: isMobile ? 60 : 100,
      width: 80,
      decoration: BoxDecoration(
          border: border ? Border.all(color: Theme.of(context).accentColor) : null,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: selected ? Theme.of(context).accentColor.withOpacity(0.1) : Colors.transparent
        // color: Colors.red,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap:onTap,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5,top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(icon,width: iconSize,height: iconSize,color: fillIconColor ?? Theme.of(context).primaryColor,),
                ),
                const SizedBox(height: 10,),
                Text(title,maxLines: 1,textAlign: TextAlign.center,style: const TextStyle(fontSize: 12),),
              ],
            ),
          ),
        ),
      ),
    );

  }

}