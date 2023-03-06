import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../common/state_enum.dart';
import '../../../../../common/utils.dart';
import '../../../../../common/widgets/unfocus.dart';
import '../../../../bloc/home/home_bloc.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Unfocus(
      child: Stack(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: state.isSearch ? 1 : .0,
                child: SizedBox(
                  width: width,
                  height: state.isSearch ? 60 : 0,
                  child: Material(
                    color: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Row(
                        children: const [
                          Text("Filter:"),
                          SizedBox(width: 8),
                          _FilterBtn(SearchType.hospital),
                          SizedBox(width: 8),
                          _FilterBtn(SearchType.restaurant)
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FilterBtn extends StatelessWidget {
  final SearchType searchType;
  const _FilterBtn(this.searchType);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              side: state.searchType == searchType
                  ? const BorderSide(color: Colors.blue)
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.blue.withOpacity(.07),
          ),
          onPressed: () =>
              context.read<HomeBloc>().add(HomeChangeSearchType(searchType)),
          child: Text(
            searchType == SearchType.hospital ? "Hospital" : "Restaurant",
            style: const TextStyle(color: Colors.blue),
          ),
        );
      },
    );
  }
}
