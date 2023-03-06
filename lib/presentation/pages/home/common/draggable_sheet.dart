import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/common/base_url.dart';
import 'package:maps/common/utils.dart';
import 'package:maps/data/datasources/position/result_helper.dart';
import '../../../bloc/places/places_bloc.dart';
import '../../../bloc/home/home_bloc.dart';

class DraggableSheet extends StatelessWidget {
  final GlobalKey _widgetKey = GlobalKey(debugLabel: UniqueKey().toString());
  final DraggableScrollableController draggableCtrl;

  DraggableSheet(this.draggableCtrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.isShowDraggable) showDraggableSheet(context);
      },
      builder: (context, state) {
        return Stack(
          children: [
            if (state.isShowDraggable)
              DraggableScrollableSheet(
                controller: draggableCtrl,
                snap: true,
                minChildSize: .0,
                builder: (_, ctrl) => DraggableContent(_widgetKey, ctrl),
                initialChildSize: .0,
                maxChildSize: .7,
              ),
          ],
        );
      },
    );
  }

  /// displays the Draggable Sheet
  void showDraggableSheet(BuildContext context) {
    onLoad(() {
      final box = _widgetKey.currentContext?.findRenderObject() as RenderBox;
      final size = draggableCtrl.pixelsToSize(box.size.height);
      draggableCtrl.animateTo(
        size.isNaN ? .2 : size,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }
}

class DraggableContent extends StatelessWidget {
  final ScrollController scrollController;
  final GlobalKey widgetKey;
  const DraggableContent(this.widgetKey, this.scrollController, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        key: widgetKey,
        margin: const EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20)],
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            _draggableIndicator,
            _body,
          ],
        ),
      ),
    );
  }

  Widget get _draggableIndicator => Container(
        alignment: Alignment.center,
        height: 50,
        child: Container(
          width: 50,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(99),
          ),
        ),
      );

  Widget get _body {
    return BlocBuilder<PlacesBloc, PlacesState>(
      builder: (context, state) {
        return BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.white,
              child: Column(children: _content(context)),
            );
          },
        );
      },
    );
  }

  List<Widget> _content(BuildContext context) {
    final place = ResultHelper().data(context);
    final isOpen = place?.openingHours?.openNow ?? false;
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${place?.name}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${place?.rating}",
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(width: 4),
                    starBuilder(place?.rating ?? .0),
                    Text(
                      "(${place?.userRatingsTotal})",
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                Text("${place?.vicinity}"),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              color: isOpen ? Colors.green : Colors.red,
            ),
            child: Text(
              isOpen ? "Open Now" : "Closed Now",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
      if ((place?.photos ?? []).isNotEmpty) const SizedBox(height: 16),
      SizedBox(
        height: (place?.photos ?? []).isEmpty ? 0 : 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: place?.photos?.length,
          itemBuilder: (context, index) {
            final item = place?.photos?[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                urlPhoto("${item?.photoReference}"),
                width: width - 32,
                height: 200,
                fit: BoxFit.fitWidth,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    width: width - 32,
                    height: 200,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      value: progress.expectedTotalBytes != null
                          ? progress.cumulativeBytesLoaded /
                              progress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 16),
    ];
  }

 /// display stars based on rating
  Widget starBuilder(double rating) {
    final ratingInt = rating.toInt();
    final numComma = int.parse("$rating".split(".").last);

    return Row(
      children: [
        ...List.generate(
          ratingInt,
          (i) => const Icon(
            Icons.star,
            size: 16,
            color: Colors.amber,
          ),
        ),
        ...List.generate(
          5 - ratingInt,
          (i) => Icon(
            numComma > 2
                ? i == 0
                    ? (numComma - 5 < 3)
                        ? Icons.star_half
                        : Icons.star
                    : Icons.star_border
                : Icons.star_border,
            size: 16,
            color: Colors.amber,
          ),
        ),
      ],
    );
  }
}
