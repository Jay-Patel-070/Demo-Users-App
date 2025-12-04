import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/components/appbar_component.dart';
import 'package:demo_users_app/components/searchbar_component.dart';
import 'package:demo_users_app/components/user_listtile_component.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';

class AllUserScreen extends StatefulWidget {
  const AllUserScreen({super.key});

  @override
  State<AllUserScreen> createState() => _AllUserScreenState();
}

class _AllUserScreenState extends State<AllUserScreen> {
  TextEditingController searchcontroller = TextEditingController();
  List<String> _items = List.generate(10, (index) => 'Item ${index + 1}');

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1; // Adjust newIndex if moving down the list
      }
      final String item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: AppbarComponent(
          title: AppLabels.users,
          centertitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.tune_outlined,
                size: 25,
                color: AppColors.greywithshade,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: .symmetric(horizontal: AppPadding.md),
            child: SearchbarComponent(
              controller: searchcontroller,
              hintText: AppStrings.search_by_name_or_email,
            ),
          ),
          sb(20),
          Expanded(
            child: ReorderableListView.builder(
              onReorder: _onReorder,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: AppPadding.sm),
                  child: UserListtileComponent(
                    ontap: () {},
                    email: 'eleanore.penna@example.com',
                    name: '$index',
                    image:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFU7U2h0umyF0P6E_yhTX45sGgPEQAbGaJ4g&s',
                  ),
                  key: ValueKey(_items[index]),
                );
              },
              padding: .symmetric(horizontal: AppPadding.md),
              itemCount: _items.length,
            ),
          ),
        ],
      ),
    );
  }
}
