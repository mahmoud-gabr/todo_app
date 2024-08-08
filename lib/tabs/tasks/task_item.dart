import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppTheme.white,
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 62,
            margin: const EdgeInsetsDirectional.only(end: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Play Games',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'this is task description',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: 69,
            height: 34,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ImageIcon(
              const AssetImage('assets/images/Icon-check.png'),
              size: 34,
              color: AppTheme.white,
            ),
          )
        ],
      ),
    );
  }
}
