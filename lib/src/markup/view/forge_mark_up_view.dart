

part of '../controller/forge_mark_up_controller.dart';


class ForgeMarkUp extends StatefulWidget {
  final String url;
  final OnMarkUpViewCrated? onMarkUpViewCrated;
  final Function()? onSaved;
  final Function(WebResourceError error)? onWebResourceError;
  final String? base64;
  final String? imageUrl;
  final double? width;
  final double? height;
  final bool logJavaScriptFunctions;
  final bool showLoading;
  const ForgeMarkUp({Key? key,
    required this.url,
    this.onMarkUpViewCrated,
    this.onSaved,
    this.onWebResourceError,
    this.width,
    this.height,
    this.base64,
    this.imageUrl,
    this.logJavaScriptFunctions = false,
    this.showLoading = false,
  }) : super(key: key);
  @override
  _ForgeMarkUpState createState() => _ForgeMarkUpState();
}

class _ForgeMarkUpState extends State<ForgeMarkUp> {

  late ForgeMarkUpController controller;

  @override
  void initState() {

    controller = Get.put(ForgeMarkUpController(
      base64: widget.base64,
      imageUrl: widget.imageUrl,
      logJavaScriptFunctions: widget.logJavaScriptFunctions
    ));

    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ForgeMarkUpController>();
    super.dispose();
  }

  // CustomPopYesNo

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        if(controller.hasNoChanged){
          return true;
        }
        bool? yes = await CustomPopYesNo.show();
        return yes ?? false;
      },
        child: Scaffold(

          appBar: _markUpAppBar(context),

          body: Stack(
            children: [

              MarkUpWebView(
                url: widget.url,
                onMarkUpViewCrated: widget.onMarkUpViewCrated,
                onSaved: widget.onSaved,
                onWebResourceError: widget.onWebResourceError,
                width: widget.width,
                height: widget.height,
              ),

              if(widget.showLoading) GetBuilder<ForgeMarkUpController>(
                  id: "loading",
                  builder: (controller){

                    if(controller.forgeLoading == false){
                      return const SizedBox();
                    }

                    return Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: const ForgeLoading(
                        size: 140,
                        title: "Reality",
                      ),
                    );

                  }
              ),

            ],
          ),

          bottomNavigationBar: const _MarkUpBottomNavigation(),

        ),
    );
    

  }
}


class MarkUpWebView extends StatelessWidget {
  final String url;
  final OnMarkUpViewCrated? onMarkUpViewCrated;
  final Function()? onSaved;
  final Function(WebResourceError error)? onWebResourceError;
  final String? base64;
  final double? width;
  final double? height;
  const MarkUpWebView({Key? key,
    required this.url,
    this.onMarkUpViewCrated,
    this.onSaved,
    this.onWebResourceError,
    this.width,
    this.height,
    this.base64
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    final controller = Get.find<ForgeMarkUpController>();

    var kAndroidUserAgent1 = 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';
    var kAndroidUserAgent2 = 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_3 like Mac OS X) AppleWebKit/600.14 (KHTML, like Gecko) Mobile/12F70';

    String html = """<!DOCTYPE html>
          <html>
            <head>
            <style>
            body {
              overflow: hidden; 
            }
        .embed-youtube {
            position: relative;
            padding-bottom: 56.25%; 
            padding-top: 0px;
            height: 0;
            overflow: hidden;
        }

        .embed-youtube iframe,
        .embed-youtube object,
        .embed-youtube embed {
            border: 0;
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }
        </style>

        <meta charset="UTF-8">
         <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
          <meta http-equiv="X-UA-Compatible" content="ie=edge">
           </head>
          <body bgcolor="#121212">                                    
        <div class="embed-youtube">
         <iframe
          id="vjs_video_3_Youtube_api"
          style="width:100%;height:100%;top:0;left:0;position:absolute;"
          class="vjs-tech holds-the-iframe"
          frameborder="0"
          allowfullscreen="1"
          allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
          webkitallowfullscreen mozallowfullscreen allowfullscreen
          title="Live Tv"
          frameborder="0"
          src="$url"
          ></iframe></div>
          </body>                                    
        </html>
  """;

    final String contentBase64 = base64Encode(const Utf8Encoder().convert(html));

    return WebViewX(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? MediaQuery.of(context).size.height,
      initialContent: true ? url : 'data:text/html;base64,$contentBase64',
      userAgent: kAndroidUserAgent1,
      initialSourceType: SourceType.url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebResourceError: onWebResourceError,
      onWebViewCreated: (webViewXController){
        controller.webViewXController = webViewXController;
      },
      jsContent: const {
        EmbeddedJsContent(
          js: "function onViewerLoaded_Flutter() { console.log('Hi from JS') } "
              "function onHistoryChanged_Flutter() { console.log('Hi from JS') }"
              "function onSave_Flutter() { console.log('Hi from JS') }",
        ),
        EmbeddedJsContent(
          webJs: "function onViewerLoaded_Flutter(msg) { TestDartCallback('Web callback says: ' + msg) }"
              "function onHistoryChanged_Flutter(msg) { TestDartCallback('Web callback says: ' + msg) }"
              "function onSave_Flutter(msg) { TestDartCallback('Web callback says: ' + msg) }",
          mobileJs: "function onViewerLoaded_Flutter(msg) { TestDartCallback.postMessage('Mobile callback says: ' + msg) } "
              "function onHistoryChanged_Flutter(msg) { TestDartCallback.postMessage('Mobile callback says: ' + msg) }"
              "function onSave_Flutter(msg) { TestDartCallback.postMessage('Mobile callback says: ' + msg) }",
        ),
      },
      mobileSpecificParams: const MobileSpecificParams(
          androidEnableHybridComposition: true,
          debuggingEnabled: true
      ),
      dartCallBacks:  {

        DartCallback(
            name: 'onViewerLoaded_Flutter',
            callBack: (message) {
              if(onMarkUpViewCrated != null) onMarkUpViewCrated!(controller);
              controller.onViewerLoaded();
            }
        ),

        DartCallback(
            name: 'onSave_Flutter',
            callBack: (message) {
              if(onSaved != null) onSaved!();
              controller.onSaved(context);
            }
        ),

        DartCallback(
            name: 'onHistoryChanged_Flutter',
            callBack: (message) {
              controller.onHistoryChanged(message);
            }
        ),

      },
      navigationDelegate: (navigation) {
        debugPrint(navigation.content.sourceType.toString());
        return NavigationDecision.prevent;
      },
    );

  }
}



