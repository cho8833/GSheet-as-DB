import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:test_application/Constants/Constants.dart';
import 'package:test_application/Constants/GSheetsAPIConfig.dart';
import 'package:test_application/Provider/PostNotiProvider.dart';


class Post_CommitTableWidget extends StatefulWidget {
  const Post_CommitTableWidget({Key? key}) : super(key: key);

  @override
  State<Post_CommitTableWidget> createState() => _Post_CommitTableWidgetState();
}

class _Post_CommitTableWidgetState extends State<Post_CommitTableWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          const Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Center(
              child: Text(
                "구글시트 미리보기",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: const [
                Flexible(
                  flex: 2,
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Name",
                      style: Constants.itemTextStyle,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Phone",
                      style: Constants.itemTextStyle,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Sender",
                      style: Constants.itemTextStyle,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Contents",
                      style: Constants.itemTextStyle,
                    ),
                  ),
                ),
                Flexible(flex: 1, child: Text(""))
              ],
            ),
          ),
          Flexible(
            flex: 7,
            fit: FlexFit.tight,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Consumer<PostNotiProvider>(
                builder: (context, provider, child) => ListView.separated(
                  controller: ScrollController(),
                  itemCount: provider.notifies.length,
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 1,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 50,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  provider.notifies[index].member.name,
                                  style: Constants.listTextStyle,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(provider.notifies[index].member.phoneNumber,
                                    style: Constants.listTextStyle),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(provider.notifies[index].sender,
                                    style: Constants.listTextStyle),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(provider.notifies[index].postCount,
                                    style: Constants.listTextStyle),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: IconButton(
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                onPressed: () {
                                  provider.deleteNoti(index);
                                }, 
                                icon: const Icon(Icons.close)
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Center(
                child: Consumer<PostNotiProvider>(
                    builder: ((__, provider, _) {
                  if (provider.status == Status.loading) {
                    return SpinKitRotatingPlain(
                      itemBuilder: ((context, index) {
                        return const DecoratedBox(
                            decoration: BoxDecoration(color: Colors.blue));
                      }),
                    );
                  } else {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(300, 80),
                          maximumSize: const Size(500, 100),
                        ),
                        onPressed: () {
                          Provider.of<PostNotiProvider>(context,
                                  listen: false)
                              .commit();
                        },
                        child: const Text(
                          "구글시트 다운로드",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ));
                  }
                })),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
