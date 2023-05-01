import 'package:flutter/material.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: const BoxDecoration(
            border: Border(
          right: BorderSide(
              width: 1, style: BorderStyle.solid, color: Colors.grey),
        )),
        child: const CircleAvatar(
          radius: 20,
          child: Icon(
            Icons.person,
            size: 40,
          ),
        ),
      ),
      onTap: () {},
      onLongPress: () {},
      title: Text(
        'Commenter Name',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Flexible(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            'Comment',
            maxLines: 4,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.grey.shade400),
          ),
        ),
      ),
    );
  }
}
