import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/components/listview_group.dart';
import 'package:shimmer/shimmer.dart';

class EventListLoading extends StatelessWidget {
  const EventListLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 20),
        //   child: Card(
        //     elevation: 0,
        //     margin: const EdgeInsets.only(bottom: 10),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //     child: ListTile(
        //       contentPadding: const EdgeInsets.symmetric(
        //         horizontal: 13,
        //         vertical: 10,
        //       ),
        //       leading: Shimmer.fromColors(
        //         baseColor: Theme.of(context).scaffoldBackgroundColor,
        //         highlightColor:
        //             Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
        //         child: Container(
        //           height: 55,
        //           width: 55,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10),
        //             color: Theme.of(context).scaffoldBackgroundColor,
        //           ),
        //         ),
        //       ),
        //       title: Shimmer.fromColors(
        //         baseColor: Theme.of(context).scaffoldBackgroundColor,
        //         highlightColor:
        //             Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
        //         child: Padding(
        //           padding: const EdgeInsets.only(right: 52, bottom: 3),
        //           child: Container(
        //             height: 16,
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(4),
        //               color: Theme.of(context).scaffoldBackgroundColor,
        //             ),
        //           ),
        //         ),
        //       ),
        //       subtitle: Shimmer.fromColors(
        //         baseColor: Theme.of(context).scaffoldBackgroundColor,
        //         highlightColor:
        //             Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
        //         child: Container(
        //           height: 16,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(4),
        //             color: Theme.of(context).scaffoldBackgroundColor,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        ListViewGroup(
          title: Shimmer.fromColors(
            baseColor: Theme.of(context).cardColor,
            highlightColor: Theme.of(context).cardColor.withOpacity(0.2),
            child: Container(
              width: 69,
              height: 16,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          items: [
            Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 10,
                ),
                leading: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
                title: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 52, bottom: 3),
                    child: Container(
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
                subtitle: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Container(
                    height: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 10,
                ),
                leading: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
                title: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 52, bottom: 3),
                    child: Container(
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
                subtitle: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Container(
                    height: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 10,
                ),
                leading: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
                title: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 52, bottom: 3),
                    child: Container(
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
                subtitle: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Container(
                    height: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 10,
                ),
                leading: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
                title: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 52, bottom: 3),
                    child: Container(
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
                subtitle: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Container(
                    height: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        ListViewGroup(
          title: Shimmer.fromColors(
            baseColor: Theme.of(context).cardColor,
            highlightColor: Theme.of(context).cardColor.withOpacity(0.2),
            child: Container(
              width: 69,
              height: 16,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          items: [
            Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 10,
                ),
                leading: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
                title: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 52, bottom: 3),
                    child: Container(
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
                subtitle: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Container(
                    height: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 10,
                ),
                leading: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
                title: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 52, bottom: 3),
                    child: Container(
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
                subtitle: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Container(
                    height: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 10,
                ),
                leading: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
                title: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 52, bottom: 3),
                    child: Container(
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
                subtitle: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Container(
                    height: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 10,
                ),
                leading: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
                title: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 52, bottom: 3),
                    child: Container(
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
                subtitle: Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  highlightColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: Container(
                    height: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
