import 'package:flutter/material.dart';

class WorkerItem extends StatelessWidget {
  const WorkerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: const EdgeInsets.only(right: 12, top: 20),
          decoration: const BoxDecoration(
              border: Border(
            right: BorderSide(
                width: 1, style: BorderStyle.solid, color: Colors.grey),
          )),
          child: CircleAvatar(
            radius: 20,
            child: Image.network(
              'https://cdn.icon-icons.com/icons2/2643/PNG/512/male_boy_person_people_avatar_icon_159358.png',
            ),
          ),
        ),
        onTap: () {},
        title: Text(
          'Name' * 2,
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.linear_scale),

            Text(
              'Position in The Company',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Number' * 2,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        trailing: GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(top: 26),
            child: Icon(
              Icons.mail_outline_outlined,
              color: Theme.of(context).splashColor,
            ),
          ),
        ),
      ),
    );
  }
}
