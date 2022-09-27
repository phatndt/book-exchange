import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:book_exchange/presentation/views/screens/home/library/recustom_elevated_button.dart';
import 'package:book_exchange/presentation/views/widgets/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/foundation.dart';
import '../../../../../colors/colors.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

bool isVisible = true;

class _CollectionScreenState extends State<CollectionScreen> {
  @override
  Widget build(BuildContext context) {
    debugPrint('visibility: $isVisible');
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: S.size.length_40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                width: 100,
              )),
              Visibility(
                visible: isVisible,
                child: ReCustomElevatedButton(
                  height: 40,
                  width: 120,
                  text: 'Collection',
                  onPress: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(S.size.length_10),
                      bottomLeft: Radius.circular(S.size.length_10),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isVisible,
                child: Container(
                  width: 2,
                  height: 40,
                  color: S.colors.black,
                ),
              ),
              Visibility(
                visible: isVisible,
                child: ReCustomElevatedButton(
                  height: 40,
                  width: 120,
                  text: 'Share',
                  onPress: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(S.size.length_10),
                      bottomRight: Radius.circular(S.size.length_10),
                    ),
                  ),
                ),
              ),

              // RawMaterialButton(
              //   onPressed: () {
              //     setState(() {
              //       if (isVisible) {
              //         isVisible = false;
              //       } else {
              //         isVisible = true;
              //       }
              //     });
              //   },
              //   elevation: 2.0,
              //   fillColor: S.colors.white,
              //   child: const Icon(
              //     FontAwesomeIcons.magnifyingGlass,
              //     size: 15.0,
              //   ),
              //   padding: EdgeInsets.all(S.size.length_10),
              //   shape: CircleBorder(),
              // )
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                if (isVisible) {
                  isVisible = false;
                } else {
                  isVisible = true;
                }
              });
              debugPrint('visibility: $isVisible');
            },
            child: AnimSearchBar(
              width: 200,
              textController: TextEditingController(),
              helpText: 'Searh Books...',
              color: S.colors.white,
              animationDurationInMilli: 375,
              closeSearchOnSuffixTap: true,
              onSuffixTap: () {},
              rtl: true,
            ),
          ),
        ],
      ),
    );
  }
}
