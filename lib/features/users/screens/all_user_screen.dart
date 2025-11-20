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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: AppbarComponent(
          title: AppLabels.users,
          centertitle: true,
          actions: [
            IconButton(onPressed: () {
              
            }, icon: Icon(Icons.tune_outlined,size: 25,color: AppColors.greywithshade,))
          ],
        ),
      ),
      body: Column(
        children: [
          sb(20),
          Padding(
            padding: .symmetric(horizontal: 15,),
            child: SearchbarComponent(controller: searchcontroller,hintText: AppStrings.search_by_name_or_email,),
          ),
          sb(20),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: UserListtileComponent(
                    ontap: () {

                    },
                    email: 'eleanore.penna@example.com',
                    name: 'Eleanor pena',
                    image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFU7U2h0umyF0P6E_yhTX45sGgPEQAbGaJ4g&s',
                  ),
                );
              },
              padding: .symmetric(horizontal: 15),
              itemCount: 4,
              ),
          ),
        ],
      ),
    );
  }
}
