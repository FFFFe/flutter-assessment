import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rf_infinite_test/cubits/search/search_cubit.dart';
import 'package:rf_infinite_test/utils/debounce.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({super.key});

  final debounce = Debounce(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      color: Colors.grey.shade300,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search contact...',
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          fillColor: Colors.white,
          filled: true,
          suffixIcon: const Icon(Icons.search),
        ),
        onChanged: (String? searchTerm) {
          if (searchTerm != null) {
            debounce.run(() {
              context.read<SearchCubit>().searchContact(searchTerm);
            });
          }
        },
      ),
    );
  }
}
