import 'package:dysistant/providers/chat_answer_provider.dart';
import 'package:dysistant/widgets/home_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class ChatBox extends ConsumerStatefulWidget{
  final double initialX;
  final double initialY;
  ChatBox({this.initialX=0, this.initialY=0});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _ChatBoxState();
  }
}
class _ChatBoxState extends ConsumerState<ChatBox>{
  double _xPosition = 0;
  double _yPosition = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _xPosition = widget.initialX;
      _yPosition = widget.initialY;
    });
    // Set initial position to the center of the screen
    //_xPosition = (MediaQuery.of(context).size.width - 200) / 2; // 200 is width of Draggable
    //_yPosition = (MediaQuery.of(context).size.height - 100) / 2; // 100 is height of Draggable
  }

  @override
  Widget build(BuildContext context) {
    final answersMap = ref.watch(chatAnswerMapProvider);
    return Positioned(
      left: _xPosition,
      top: _yPosition,
      child: Draggable(
        child: Container(
          width: MediaQuery.of(context).size.width > 275 ?
          MediaQuery.of(context).size.width * 0.75 >  275 ?
          MediaQuery.of(context).size.width * 0.75 : 275 : 275,
          height: 300,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.teal.shade100,
            borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.black, // Warna border
                width: 2.0, // Lebar border
              )
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: Text(
                    'What can I help you with?',
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ))
                ],
              ),
              Expanded(
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Text(
                    'OR', textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold
                    ),
                  ))
                ],
              ),
              SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HomeIcon
                    (func: (){},
                      iconColor: Colors.green, backgroundColor: Colors.green.shade50,
                      title: 'Text', icon: Icons.keyboard),
                  SizedBox(width: 8,),
                  HomeIcon
                    (func: (){},
                      iconColor: Colors.blue, backgroundColor: Colors.blue.shade50,
                      title: 'Voice', icon: Icons.keyboard_voice_rounded),

                ],
              ),
            ],
          )
        ),
        feedback: Material(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.6),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                'Dragging...',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        childWhenDragging: Container(), // Empty container when dragging
        onDragEnd: (dragDetails) {
          // Code executed when dragging ends
          // You can handle the position or any other logic here
        },
        onDragUpdate: (dragDetails) {
          setState(() {
            _xPosition += dragDetails.delta.dx;
            _yPosition += dragDetails.delta.dy;
          });
        },
      ),
    );
  }
}