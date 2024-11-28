import 'package:assist/common_widgets/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(10),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Text(
              "I'd need help with...",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Gap(10),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            child: _buildSearchField(context),
          ),
          Gap(20),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Text(
              "Select a category",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Gap(10),
          _buildHorizontalScrollableGrid(context),
          Gap(20),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Text(
              "Popular services",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Gap(10),
          _buildHorizontalScrollableGrid(context),
          Gap(20),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Text(
              "Recommended for you",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Gap(10),
          _buildHorizontalScrollableGrid(context),
          Gap(20),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Text("Looking for something else?"),
          ),
          Gap(20),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            child: _buildCategories(context, items: [
              'Plumbing',
              'Electrician',
              'Carpentry',
              'Cleaning',
              'Painting'
            ]),
          ),
          Gap(20),
        ],
      ),
    );
  }
}

Widget _buildSearchField(BuildContext context) {
  return TextField(
    onTap: () {
      Get.toNamed('/search');
    },
    readOnly: true,
    decoration: InputDecoration(
      hintText: 'Try "Plumbing" or "Electrician"',
      prefixIcon: Icon(
        Icons.search,
        color: Theme.of(context).primaryColor,
      ),
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

Widget _buildHorizontalScrollableGrid(BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Row(
        children: List.generate(10, (index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 150,
                height: 150,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    'Item $index',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
              Gap(10),
              Text('Item $index',
                  style: Theme.of(context).textTheme.labelLarge),
            ],
          );
        }),
      ),
    ),
  );
}

Widget _buildCategories(BuildContext context, {List<String> items = const []}) {
  return GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 10,
      childAspectRatio: 4,
    ),
    itemCount: items.length,
    itemBuilder: (context, index) {
      String item = items[index];
      return LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.blueAccent),
            ),
            child: Center(
              child: Text(
                item,
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      );
    },
  );
}
