import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rf_infinite_test/constants/color.dart';
import 'package:rf_infinite_test/cubits/filter/filter_cubit.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _filterButton(context, ContactFilter.all),
          const SizedBox(width: 10.0),
          _filterButton(context, ContactFilter.favourite),
        ],
      ),
    );
  }

  Widget _filterButton(BuildContext context, ContactFilter filter) {
    return ElevatedButton(
      onPressed: () {
        context.read<FilterCubit>().changeFilter(filter);
      },
      style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0)),
          backgroundColor:
              context.watch<FilterCubit>().state.contactFilter == filter
                  ? MaterialStateProperty.all(green)
                  : MaterialStateProperty.all(Colors.white)),
      child: Text(
        filter == ContactFilter.all ? 'All' : 'Favourite',
        style: TextStyle(
          color: context.watch<FilterCubit>().state.contactFilter == filter
              ? Colors.white
              : Colors.grey,
          fontSize: 12.0,
        ),
      ),
    );
  }
}
