import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  final String commentBody;
  final String commenterName;
  final String commenterImage;
  final String commentId;
  final String userId;
 // final Timestamp time;

  const CommentItem({
    Key? key,
    required this.userId,
    required this.commenterName,
    required this.commentBody,
    required this.commenterImage,
    required this.commentId,
   // required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: const BoxDecoration(
            border: Border(
          right: BorderSide(
              width: 1, style: BorderStyle.solid, color: Colors.grey),
        )),
        child:  CircleAvatar(
          radius: 25,
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                      commenterImage,
                    ))),
          ),
        ),
      ),
      onTap: () {},
      onLongPress: () {},
      title: Text(
       commenterName,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          commentBody,
          maxLines: 4,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
