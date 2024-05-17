import 'package:flutter/material.dart';

import '../utils/global_variabes.dart';
import 'custom_search_bar.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.size,
    required this.title,
    required this.tabs,
    required this.searchfor,
    required this.onPressed,
    required this.showCreate,
    this.showGroup = false
  });

  final Size size;
  final bool showCreate;
  final bool showGroup;
  final String title;
  final List<Widget> tabs;
  final String searchfor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 20.0,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.02),
                  ),
                  if(showCreate)
                  ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            WidgetStateProperty.all(Colors.white),
                        backgroundColor: WidgetStateProperty.all(
                            GlobalVariables.kPrimaryColor),
                        textStyle: WidgetStatePropertyAll(
                          TextStyle(
                              fontSize: size.height * 0.012,
                              fontWeight: FontWeight.bold),
                        ),
                        iconSize:
                        WidgetStateProperty.all(size.height * 0.02)),
                    onPressed: onPressed,
                    child: Row(
                      children: [
                        const Icon(Icons.add),
                        const SizedBox(width: 8.0),
                        showGroup
                        ? const Text('Create Group')
                        : const Text('Create Event'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              CustomSearchBar(
                searchFor: searchfor,
                backgroundColor: GlobalVariables.kPrimaryColor,
                fillColor: Colors.white,
                iconColor: GlobalVariables.kPrimaryColor,
                iconSize: 18,
                textColor: Colors.black,
                textSize: 15,
              )
            ],
          ),
        ),
      ),
      bottom: TabBar(
          indicatorColor: GlobalVariables.kPrimaryColor,
          labelColor: GlobalVariables.kPrimaryColor,
          tabs: tabs),
    );
  }
}
