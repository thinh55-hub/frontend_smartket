import 'package:flutter/material.dart';

import 'map_pill.dart';

class MapTab extends StatefulWidget {
  final List<MapTabItem> items;
  final ValueChanged<int>? onChanged;
  final int initialIndex;

  const MapTab({super.key, required this.items, this.onChanged, this.initialIndex = 0});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  late int _currentIndex = widget.initialIndex;

  void _handleTap(int index) {
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
    widget.onChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: List.generate(widget.items.length, (index) {
        final item = widget.items[index];
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: index == 0 ? 0 : 6),
            child: MapPill(
              label: item.label,
              icon: item.icon,
              selected: index == _currentIndex,
              onTap: () => _handleTap(index),
            ),
          ),
        );
      }),
    );
  }
}

class MapTabItem {
  final String label;
  final IconData icon;

  const MapTabItem({required this.label, required this.icon});
}
