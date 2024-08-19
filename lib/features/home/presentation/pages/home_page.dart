import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osrmtesting/app/theme/custom_theme.dart';
import 'package:osrmtesting/app/theme/theme.dart';
import 'package:osrmtesting/core/widgets/customx_widgets.dart';
import 'package:osrmtesting/features/login/presentation/blocs/fetch_account_data/fetch_account_data_bloc.dart';
import 'package:osrmtesting/features/login/presentation/blocs/fetch_account_data/fetch_account_data_event.dart';
import 'package:osrmtesting/features/login/presentation/pages/login_page.dart';

class BottomBarItemData {
  final String name;
  final String iconPath;

  BottomBarItemData({
    required this.name,
    required this.iconPath,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;
  late RemoteAccountDataBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = BlocProvider.of<RemoteAccountDataBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    bloc.close();
    super.dispose();
  }

  final items = [
    BottomBarItemData(name: 'Home', iconPath: IconPath.cottage),
    BottomBarItemData(name: 'Harvest', iconPath: IconPath.naturePeople),
    BottomBarItemData(name: 'Maintenace', iconPath: IconPath.homeRepair),
    BottomBarItemData(name: 'Report', iconPath: IconPath.exportNotes),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CxStackContainer(
      bottomAppBar: BottomNavBar(
        items: items,
        ontap: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
      child: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                bloc.add(const Logout());
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginPage(
                          brand: 'weee',
                        )));
              },
              child: Text('Logout'),
            ),
          ),
          Center(
            child: Text('2'),
          ),
          Center(
            child: Text('3'),
          ),
          Center(
            child: Text('4'),
          ),
        ],
      ),
    ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }
}

class BottomNavBar extends StatelessWidget {
  final List<BottomBarItemData> items;
  final int selectedIndex;
  final Function(int) ontap;
  const BottomNavBar(
      {super.key,
      required this.items,
      required this.selectedIndex,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: AlignedGridView.count(
        padding: EdgeInsets.zero,
        mainAxisSpacing: 0,
        shrinkWrap: true,
        itemCount: items.length,
        crossAxisCount: items.length,
        itemBuilder: (context, index) {
          return BottomBarItem(
            onTap: () {
              ontap(index);
            },
            focused: index != selectedIndex,
            label: items[index].name,
            path: items[index].iconPath,
          );
        },
      ),
    );
  }
}

class BottomBarItem extends StatelessWidget {
  final bool focused;
  final String path;
  final String label;
  final Function()? onTap;
  const BottomBarItem(
      {super.key,
      required this.path,
      this.label = '',
      this.onTap,
      this.focused = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: padding4All,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              path,
              width: 28,
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            spacer4h,
            Text(
              label,
              style: text10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 4),
              child: Divider(
                color: focused ? Colors.transparent : primaryColor,
                height: 0,
                thickness: 1.5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
