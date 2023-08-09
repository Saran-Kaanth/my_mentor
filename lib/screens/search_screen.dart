import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mentor/blocs/searchBloc/search_bloc.dart';
import 'package:my_mentor/data/models/user.dart';
import 'package:my_mentor/data/repositories/profile_repository.dart';
import 'package:my_mentor/screens/my_profile_screen.dart';
import 'package:my_mentor/widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  // late UserProfileDetailsModel currentUserData;
  final searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    return Scaffold(
        body: SafeArea(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.search_rounded,
                    size: 35,
                    color: Colors.deepOrangeAccent,
                  ),
                  Container(
                      width: size.width / 1.25,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: TextFormField(
                          enableInteractiveSelection: true,
                          controller: searchController,
                          style: TextStyle(
                              color: Colors.grey.shade200, fontSize: 15),
                          decoration: InputDecoration(
                              hintText: "Type the user's display name..",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      )),
                  spaceBox(5)
                ],
              ),
            ),
          ),
          spaceBox(10),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchLoadingState) {
                return loadingWidget(loadingWidgetColor: Colors.blue);
              } else if (state is SearchRecomDataState) {
                if (state.locBasedUsersProfiles!.isEmpty ||
                    state.locBasedUsersProfiles == null) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                            "“If you cannot see where you are going, ask someone who has been there before.” J Loren Norris",
                            softWrap: true,
                            maxLines: null,
                            style:
                                TextStyle(color: Colors.white, fontSize: 25)),
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: textValueWidget(
                              "People who are in " +
                                  state.locBasedUsersProfiles![0].city
                                      .toString()
                                      .toUpperCase(),
                              textColor: Colors.blue,
                              fontSize: 20),
                        ),
                        spaceBox(10),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.locBasedUsersProfiles!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(state
                                          .locBasedUsersProfiles![index]
                                          .photoUrl
                                          .toString()),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    textValueWidget(state
                                        .locBasedUsersProfiles![index]
                                        .displayName
                                        .toString())
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ));
                }
              } else if (state is SearchErrorState) {
                return Center(
                  child: textValueWidget(state.errorMessage.toString()),
                );
              }

              return Container();
            },
          ),
          // Expanded(
          //     child: SingleChildScrollView(
          //   child: Column(
          //     children: [],
          //   ),
          // ))
        ],
      ),
      //     child: Column(
      //   children: [
      //     Container(
      //       decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(20),
      //           color: Colors.grey.shade800),
      //       width: size.width,
      //       height: 60,
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           // Icon(
      //           //   Icons.search_rounded,
      //           //   size: 35,
      //           // ),
      //           TextFormField()
      //           // TextFormField(),
      //         ],
      //       ),
      //       // color: Colors.grey.shade800,
      //     ),
      //   ],
      // )),
    ));
  }
}
