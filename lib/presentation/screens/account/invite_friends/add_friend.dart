import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';

class AddFriend extends StatefulWidget {
  const AddFriend({super.key});

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {

  final TextEditingController _searchController = TextEditingController();
  List<String> searchResults = [];   //! fake_users:
  List<String> addedFriends = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add_friends".tr(),style: GoogleFonts.urbanist(
            fontWeight: FontWeight.w700,
            fontSize: 25.sp,
            color: context.colors.onPrimaryContainer
        ),),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.5),
          child: Container(
            color: context.ccolors.dividerLight,
            height: 1.5,
          ),
        ),
        leading: IconButton(
          onPressed: (){
            context.pop(context);
          },
          icon: SvgPicture.asset(
            "assets/icons/remove.svg",
            color: context.colors.onPrimaryContainer,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "search_nickname".tr(),
                  hintStyle: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w400,
                    fontSize: 20.sp,
                    color: context.ccolors.greyScale600
                  ),
                  prefixIcon: Icon(
                      Icons.search,
                    color: context.colors.primary,
                    size: 30,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color:context.colors.greyScale600),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: context.colors.primary),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 2, color: context.colors.error),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchResults = searchResults
                        .where((user) => user.contains(value))
                        .toList();
                  });
                },
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  String user = searchResults[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: context.colors.primary.withOpacity(0.8),
                      child: Text(user[0].toUpperCase(),style: GoogleFonts.urbanist(
                        color: context.colors.onPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp
                      ),),
                    ),
                    title: Text(user),
                    trailing: IconButton(
                      icon: Icon(
                          Icons.person_add,
                          color: context.colors.primary),
                      onPressed: () {
                        setState(() {
                          if (!addedFriends.contains(user)) {
                            addedFriends.add(user);
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            if (addedFriends.isNotEmpty)
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: context.ccolors.grey200,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("added_friends",
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                          color: context.colors.onPrimaryContainer,
                        )),
                    Wrap(
                      spacing: 8,
                      children: addedFriends
                          .map((friend) => Chip(
                        label: Text(friend),
                        onDeleted: () {
                          setState(() {
                            addedFriends.remove(friend);
                          });
                        },
                      ))
                          .toList(),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
