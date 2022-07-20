import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_application/Provider/PostNotiProvider.dart';
import 'package:test_application/Screen/PostScreen/Post_CommitTableWidget.dart';
import 'package:test_application/Screen/PostScreen/Post_inputDataWidget.dart';


class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create: (_) => PostNotiProvider(),
      child: Scaffold(
        body: Column(
          children: const [
            Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: Post_InputDataWidget()
            ),
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Post_CommitTableWidget()
            ),
          ],
        ),
      ),
    );
  }
}
