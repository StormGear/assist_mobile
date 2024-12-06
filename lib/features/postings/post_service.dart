import 'package:assist/common_widgets/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PostService extends StatefulWidget {
  const PostService({super.key});

  @override
  State<PostService> createState() => _PostServiceState();
}

class _PostServiceState extends State<PostService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Post a Service",
          style: TextStyle(
              color: primaryColor,
              fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
              fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  title: Text('Category'),
                  subtitle:
                      Text("Select a category under which your service falls"),
                  trailing: Icon(Icons.arrow_forward_ios, color: primaryColor),
                  tileColor: primaryColor.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
              Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  title: Text('Region'),
                  subtitle: Text("Select your region of primary operation"),
                  trailing: Icon(Icons.arrow_forward_ios, color: primaryColor),
                  tileColor: primaryColor.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
              Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Add a minimum of 3 photos",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Gap(10),
                    Image.asset('assets/images/postings/add_photo.png'),
                  ],
                ),
              ),
              Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: primaryColor.withOpacity(0.1),
                    hintText: 'Business Name',
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Text('Select keywords that best describe your service'),
                  ],
                ),
              ),
              Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  title: Text('Select Keywords'),
                  subtitle: Text("Keywords help users find your service"),
                  trailing: Icon(Icons.arrow_forward_ios, color: primaryColor),
                  tileColor: primaryColor.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
              Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    fillColor: primaryColor.withOpacity(0.1),
                    hintText: 'Description',
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
