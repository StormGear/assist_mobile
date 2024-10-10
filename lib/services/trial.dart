  //  home: Scaffold(
  //       appBar: AppBar(
  //         title: Obx(
  //           () => Text(
  //               'Dark Mode Demo - Current Mode  ${themeController.isLightTheme.value ? 'Light' : 'Dark'}'),
  //         ),
  //       ),
  //       body: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Obx(
  //               () => Text(
  //                 'Click on switch to change to ${themeController.isLightTheme.value ? 'Dark' : 'Light'} theme',
  //               ),
  //             ),
  //             ObxValue(
  //               (data) => Switch(
  //                 value: themeController.isLightTheme.value,
  //                 onChanged: (val) {
  //                   themeController.isLightTheme.value = val;
  //                   Get.changeThemeMode(
  //                     themeController.isLightTheme.value
  //                         ? ThemeMode.light
  //                         : ThemeMode.dark,
  //                   );
  //                   themeController.saveThemeStatus();
  //                 },
  //               ),
  //               false.obs,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),