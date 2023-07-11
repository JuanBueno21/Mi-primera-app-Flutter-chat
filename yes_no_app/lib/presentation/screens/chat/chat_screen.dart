import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:yes_no_app/domain/entitis/message.dart";
import "package:yes_no_app/presentation/providers/chat_provider.dart";
import "package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart";
import "package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart";
import "package:yes_no_app/presentation/widgets/share/message_field_box.dart";

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4EIO1K063cI3iRwVIWy059aYvPn0xfQTjBg&usqp=CAU"),
          ),
        ),
        title: const Text("Designer UX 🚀"),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatprovider = context.watch<ChatProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    controller: chatprovider.chatScrollControler,
                    itemCount: chatprovider.messageList.length,
                    itemBuilder: (context, index) {
                      final message = chatprovider.messageList[index];

                      return (message.fromWho == FromWho.hers)
                          ? HerMessageBubble(message: message)
                          : MyMessageBubble(
                              messsage: message,
                            );
                    })),

            /// caja de textos de mensajes
            MessageFieldBox(
              //onValue: (value) => chatprovider.sendMessage(value),
              onValue: chatprovider.sendMessage,
            )

            //const Text("Mundo")
          ],
        ),
      ),
    );
  }
}
