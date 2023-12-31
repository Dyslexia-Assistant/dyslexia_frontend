import 'package:dyslexia_assistant/providers/should_open_overlay_provider.dart';
import 'package:dyslexia_assistant/services/ocr_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_screenshot/flutter_native_screenshot.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/overlay_screen_settings.dart';
import '../widgets/chatbox.dart';
import '../widgets/home_icon.dart';

class Home extends ConsumerStatefulWidget{
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
  }
}
class _HomeState extends ConsumerState<Home>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
        title: const Text('Dysistant', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.settings, color: Colors.white,))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tindakan yang dilakukan ketika FAB ditekan
        },
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Atur nilai sesuai keinginan untuk membuat bentuk bulat
        ),
        child: Icon(
          Icons.face,
          // Ganti dengan ikon bot atau ikon yang diinginkan
          color: Colors.white,
          size: 32,// Warna ikon
        ),
      )
      ,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue
        ),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 120,
                ),
                Expanded(child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50), // Jika ingin membulatkan di kedua sisi atas
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('What Can I Do for You', style: TextStyle(color: Colors.blue,fontSize: 18, fontWeight: FontWeight.bold),)
                        ],
                      ),
                      SizedBox(height: 24,),
                      GridView(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,
                            mainAxisExtent: 120
                        ),
                        children: [
                          HomeIcon(func: (){}, icon: Icons.phone_android_outlined, iconColor: Colors.indigo.shade700,
                              backgroundColor: Colors.indigo.shade50, title: 'Screen Assistance'),
                          HomeIcon(func: (){}, iconColor: Colors.green.shade800
                              , backgroundColor: Colors.green.shade50, title: "Image Assistance", icon: Icons.image),
                          HomeIcon(func: (){}, iconColor: Colors.lightBlue,
                              backgroundColor: Colors.lightBlue.shade50, title: 'Improve Reading',
                              icon: Icons.chrome_reader_mode_outlined),
                          HomeIcon(func: (){}, iconColor: Colors.teal,
                              backgroundColor: Colors.teal.shade50, title: 'Improve Writing',
                              icon: Icons.draw),
                          HomeIcon(func: (){}, iconColor: Colors.orange,
                              backgroundColor: Colors.orange.shade50, title: 'PDF/Text Narration',
                              icon: Icons.picture_as_pdf),
                          HomeIcon(func: (){}, iconColor: Colors.pink,
                              backgroundColor: Colors.pink.shade50, title: 'Your Preferences',
                              icon: Icons.settings_cell_rounded),
                        ],)
                    ],
                  ),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () async {
                      final bool isActive = await FlutterOverlayWindow.isActive();
                      if(isActive){
                        await OverlayScreenSettings.instance.closeOverlay();
                        return;
                      }
                      nativeSettings.shouldOpen = true;
                      nativeSettings.alreadyOpenScreenRecording = false;
                     await OverlayScreenSettings.instance.openOverlay(300, MediaQuery.of(context).size.width);
                      ref.read(shouldOpenOverlayProvider.notifier).state =
                          NativeSettings(alreadyOpenScreenRecording: false, shouldOpen: true);
                    },
                        child: Text('Open/Close Overlay', style: TextStyle(
                          color: Colors.red
                        ),))
                  ],
                )
              ],
            ),
            ChatBox(initialX: 300,)
          ],
        ),
      ),
    );
  }

}