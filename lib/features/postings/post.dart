import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'The posting page allows you to place your business or services you render on Assist.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),

          Gap(50),
          // Text(
          //   'You can also view the services that are available on Assist and request for them.',
          //   style: Theme.of(context).textTheme.bodyMedium,
          // ),
          GestureDetector(
            onTap: () {
              Get.toNamed('/post-service');
            },
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/categories/services.jpg',
                      fit: BoxFit.fill,
                      cacheHeight:
                          (100 * MediaQuery.of(context).devicePixelRatio)
                              .toInt(),
                    ),
                  ),
                ),
                Gap(10),
                Text(
                  'Render Services',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Gap(10),
                Text(
                  'Post your own business or services you render',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          ),
          Gap(70),
          GestureDetector(
            onTap: () {
              Get.toNamed('/post-product');
            },
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/categories/sale.jpg',
                      fit: BoxFit.cover,
                      cacheHeight:
                          (100 * MediaQuery.of(context).devicePixelRatio)
                              .toInt(),
                    ),
                  ),
                ),
                Gap(10),
                Text(
                  'Purchase and Sales',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Gap(10),
                Text(
                  'Post items or products you want to sell',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
