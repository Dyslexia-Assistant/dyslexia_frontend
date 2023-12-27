import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../utils/id.dart';

final audioIdSession = generateUUID();
PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

Future<void> initPusher(context, WidgetRef ref) async {
  try{
    await pusher.init(apiKey: 'c7501626c9331edb3cec', cluster: 'ap1', onEvent: (event) async{
      onEvent(event, context, ref);
    });
    await pusher.subscribe(channelName: 'audio-session');
    await pusher.connect();
  }
  catch(err){
    print(err);
  }
}

Future<void> onEvent(PusherEvent event, context, WidgetRef ref) async{
  if(event.channelName == audioIdSession){ // Nama Channel
    switch (event.eventName) {
      case 'audio':
        final data = event.data;
        dynamic decodedData = jsonDecode(jsonEncode(data));
        if(decodedData.runtimeType == String){
          decodedData = jsonDecode(decodedData);
        }
        var message = decodedData['message'];
        if(message.runtimeType == String){
          message = jsonDecode(message);
        }
        print(message);
        break;
      default:
        break;
    }

  }
}