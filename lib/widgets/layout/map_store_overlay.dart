import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'store_explore_card.dart';

class MapStoreOverlay extends StatelessWidget {
  final List<StoreExploreData> stores;
  final bool expanded;
  final VoidCallback onToggleSize;

  const MapStoreOverlay({
    super.key,
    required this.stores,
    required this.expanded,
    required this.onToggleSize,
  });

  static const double _minFactor = 0.42;
  static const double _maxFactor = 0.82;

  @override
  Widget build(BuildContext context) {
    if (stores.isEmpty) {
      return const SizedBox.shrink();
    }
    final screenHeight = MediaQuery.of(context).size.height;
    final targetHeight = screenHeight * (expanded ? _maxFactor : _minFactor);

    return SafeArea(
      top: false,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        height: targetHeight,
        // margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        padding: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 20,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onToggleSize,
              onVerticalDragEnd: (_) => onToggleSize(),
              child: Container(
                width: 52,
                height: 16,
                alignment: Alignment.center,
                child: Container(
                  width: 52,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE1E6F0),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                physics: const BouncingScrollPhysics(),
                itemCount: stores.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final store = stores[index];
                  return StoreExploreCard(
                      store: store, margin: EdgeInsets.zero);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
