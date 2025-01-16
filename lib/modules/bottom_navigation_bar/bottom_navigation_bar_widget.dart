import 'package:heroicons/heroicons.dart';

import '../../theme/theme.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: selectedTabIndex != 0
                ? () {
                    print("Hello");
                    setState(() {
                      selectedTabIndex = 0;
                    });
                  }
                : null,
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
              child: Container(
                child: HeroIcon(
                  HeroIcons.archiveBox,
                  color: selectedTabIndex == 0 ? Colors.red : theme.colors.text,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            customBorder: ContinuousRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(40.0),
                right: Radius.circular(40.0),
              ),
            ),
            onTap: (selectedTabIndex != 1)
                ? () {
                    print("Hello");
                    setState(() {
                      selectedTabIndex = 1;
                    });
                  }
                : null,
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
              child: Container(
                child: HeroIcon(
                  HeroIcons.archiveBox,
                  color: selectedTabIndex == 1 ? Colors.red : theme.colors.text,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// class AppTabBar extends StatefulWidget {
//   const AppTabBar({
//     Key? key,
//     required this.controller,
//     required this.tabs,
//     required this.selectTab,
//     required this.selectedIndex,
//   }) : super(key: key);

//   final List<TabValue> tabs;
//   final Function selectTab;
//   final int selectedIndex;
//   final PageController controller;

//   @override
//   State<AppTabBar> createState() => _AppTabBarState();
// }

// class _AppTabBarState extends State<AppTabBar> with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     final theme = AppTheme.of(context);
//     return Column(
//       children: [
//         Row(
//           children: widget.tabs.asMap().entries.map((tab) {
//             return Flexible(
//               child: AppTab(
//                 title: tab.value.label,
//                 badge: tab.value.badgeLabel,
//                 selectTab: widget.selectTab,
//                 isSelected: widget.selectedIndex == tab.key,
//                 index: tab.key,
//                 showAlertBubble: tab.value.showAlertBubble,
//               ),
//             );
//           }).toList(),
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: AnimatedBuilder(
//                 animation: widget.controller,
//                 builder: (context, child) {
//                   return CustomPaint(
//                     painter: SelectedTabIndicatorPainter(
//                       screenWidth: MediaQuery.of(context).size.width,
//                       color: theme.colors.primary,
//                       pageCount: widget.tabs.length,
//                       scrollPosition: widget.controller.hasClients && widget.controller.page != null
//                           ? widget.controller.page!
//                           : 0.0,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class AppTab extends StatelessWidget {
//   const AppTab(
//       {Key? key,
//       required this.title,
//       required this.badge,
//       required this.selectTab,
//       required this.isSelected,
//       required this.index,
//       this.showAlertBubble = false})
//       : super(key: key);

//   final String title;
//   final String? badge;
//   final Function selectTab;
//   final bool isSelected;
//   final int index;
//   final bool showAlertBubble;

//   @override
//   Widget build(BuildContext context) {
//     final theme = AppTheme.of(context);
//     return InkWell(
//         onTap: () {
//           selectTab(index);
//         },
//         child: AppContainer(
//           height: 42,
//           alignment: Alignment.center,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Flexible(
//                 child: Stack(
//                   clipBehavior: Clip.none,
//                   alignment: Alignment.topRight,
//                   children: [
//                     AppText.semi14(
//                       title,
//                       color: (isSelected) ? theme.colors.gray800 : theme.colors.gray400,
//                       textAlign: TextAlign.center,
//                     ),
//                     Positioned(
//                       right: -10,
//                       child: AppContainer(
//                         width: 9,
//                         height: 9,
//                         decoration: showAlertBubble
//                             ? BoxDecoration(
//                                 color: theme.colors.tangerine,
//                                 border: Border.all(color: theme.colors.white),
//                                 borderRadius: BorderRadius.all(theme.radius.roundedFull),
//                               )
//                             : null,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               if (badge != null)
//                 AppPadding(
//                   padding: AppEdgeInsets.only(left: Spacing.xs),
//                   child: TabBarBadge(label: badge!),
//                 ),
//             ],
//           ),
//         ));
//   }
// }

// class TabBarBadge extends StatelessWidget {
//   const TabBarBadge({
//     super.key,
//     required this.label,
//   });
//   final String label;

//   @override
//   Widget build(BuildContext context) {
//     final theme = AppTheme.of(context);
//     return AppContainer(
//       padding: AppEdgeInsets.symmetric(horizontal: Spacing.xs),
//       decoration: BoxDecoration(
//         color: theme.colors.tangerine,
//         borderRadius: BorderRadius.all(theme.radius.roundedFull),
//       ),
//       child: AppText.semi14(
//         label,
//         color: theme.colors.white,
//       ),
//     );
//   }
// }

// class SelectedTabIndicatorPainter extends CustomPainter {
//   final int pageCount;
//   final Color color;
//   final double scrollPosition;
//   final double screenWidth;

//   SelectedTabIndicatorPainter({
//     required this.pageCount,
//     required this.color,
//     required this.screenWidth,
//     this.scrollPosition = 0,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint()
//       ..color = color //Set the color
//       ..strokeWidth = 2 //Set the width
//       ..strokeCap = StrokeCap.round; //Set the border radius

//     double slidePosition = screenWidth *
//         (scrollPosition % size.width) /
//         pageCount; // Calculate the sliding position based on the scrollPosition
//     Offset startingPoint = Offset(slidePosition, 0);
//     Offset endingPoint = Offset(startingPoint.dx + (size.width / pageCount), 0);

//     canvas.drawLine(startingPoint, endingPoint, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return this != oldDelegate;
//   }
// }
