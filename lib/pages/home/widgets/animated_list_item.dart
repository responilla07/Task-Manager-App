import 'package:flutter/material.dart';
import 'package:task_manager/pages/models/task.dart';
import 'package:task_manager/utils/theme.dart';

class AnimatedListItem extends StatelessWidget {
  final TaskModel taskModel;
  final VoidCallback? onClicked;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onMarkSelected;
  final Animation<double> animation;

  const AnimatedListItem({
    super.key,
    required this.taskModel,
    this.onClicked,
    this.onDelete,
    this.onEdit,
    this.onMarkSelected,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) => buildItem();

  Widget buildItem() {
    return GestureDetector(
      onTap: onClicked,
      child: SizeTransition(
        sizeFactor: animation,
        key: key,
        child: Card(
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          shadowColor: AppColors.secondaryL,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskModel.title.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'ValeraRound',
                      color: AppColors.logoPrimary,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: taskModel.status == TaskStatus.completed.name
                          ? AppColors.green
                          : AppColors.orage,
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    child: Text(
                      taskModel.status.toLowerCase(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
              subtitle: Text(
                taskModel.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.grey,
                ),
              ),
              trailing: _selectMore(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectMore() {
    return PopupMenuButton(
      itemBuilder: (ctx) => [
        _buildPopupMenuItem(
            icon: Icons.edit,
            txt: 'Edit',
            onTap: onEdit,
            color: AppColors.orage),
        _buildPopupMenuItem(
          icon: Icons.delete,
          txt: 'Delete',
          onTap: onDelete,
          color: AppColors.red,
        ),
        _buildPopupMenuItem(
          icon: taskModel.status == TaskStatus.completed.stat
              ? Icons.close
              : Icons.check,
          txt:
              'Mark as ${(taskModel.status == TaskStatus.completed.stat) ? 'incomplete' : 'completed'}',
          onTap: onMarkSelected,
          color: taskModel.status == TaskStatus.completed.stat
              ? AppColors.orage
              : AppColors.green,
        ),
      ],
      tooltip: 'options',
      splashRadius: 18,
    );
  }

  PopupMenuItem _buildPopupMenuItem({
    required IconData icon,
    required String txt,
    required Color color,
    void Function()? onTap,
  }) {
    return PopupMenuItem(
      onTap: null,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          color: Colors.transparent,
          child: Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 8),
              Text(txt, style: TextStyle(color: color)),
            ],
          ),
        ),
      ),
    );
  }
}
