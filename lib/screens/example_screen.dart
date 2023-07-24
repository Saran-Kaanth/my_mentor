import 'package:flutter/material.dart';

class Cards extends StatefulWidget {
  const Cards({Key? key}) : super(key: key);

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  Widget? selectedOption;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cards",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Text("Hello"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      setState(() {
                        selectedOption = optiona();
                      });
                    },
                    child: optionCards(
                        "A", "assets/images/google.png", context, "1")),
                InkWell(
                    onTap: () {
                      setState(() {
                        selectedOption = optionb();
                      });
                    },
                    child: optionCards(
                        "B", "assets/images/google.png", context, "2")),
                InkWell(
                    onTap: () {
                      setState(() {
                        selectedOption = optionc();
                      });
                    },
                    child: optionCards(
                        "C", "assets/images/google.png", context, "3")),
              ],
            ),

            // options
            if (selectedOption != null) selectedOption!
          ],
        ),
      ),
    );
  }

  Widget optionCards(
      String text, String assetImage, BuildContext context, String cardId) {
    return Container(
      width: 100,
      height: 100,
      decoration: const ShapeDecoration(
        color: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 13),
              child: IconButton(
                onPressed: null,
                icon: Icon(Icons.file_copy),
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'CeraPro',
                color: Color.fromRGBO(0, 0, 0, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget optiona() {
    return Container();
  }

  Widget optionb() {
    return Container();
  }

  Widget optionc() {
    return Container();
  }
}
