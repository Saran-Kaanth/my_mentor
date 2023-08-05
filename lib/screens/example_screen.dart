import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExampleScreen extends StatefulWidget {
  @override
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen>
    with SingleTickerProviderStateMixin {
  // Controller for the TabBar
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize the TabController with the number of tabs
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Tab Navigation'),
        //   centerTitle: true,
        // ),
        // TabBar to show the tabs
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              color: Colors.white,
            ),
            TabBar(
              labelStyle: GoogleFonts.mavenPro(),
              controller: _tabController,
              onTap: (value) => print(value),
              tabs: [
                Tab(icon: Icon(Icons.home), text: "tab 1"),
                Tab(text: 'Tab 2'),
                Tab(text: 'Tab 3'),
              ],
            ),
            // TabBarView to show the content of each tab
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      color: Colors.white,
                    ),
                  ),
                  Center(child: Text('Content of Tab 2')),
                  Center(child: Text('Content of Tab 3')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the TabController when not needed anymore
    _tabController.dispose();
    super.dispose();
  }
}
