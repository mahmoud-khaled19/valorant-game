import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkerItem extends StatelessWidget {
  final String name;
  final String image;
  final String position;
  final String userId;
  final String email;
  final String phone;

   const WorkerItem({
    required this.image,
    required this.name,
    required this.position,
    required this.userId,
    required this.email,
    required this.phone,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).dividerColor,
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
            backgroundColor:
            Theme.of(context).scaffoldBackgroundColor,
            radius: 20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                        image,
                      ))),
            ),
          ),
        ),
        title: Text(
          name,
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.linear_scale),
            Text(
              position,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              phone,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        trailing: GestureDetector(
          onTap: ()async {
            final Uri url = Uri.parse('mailto:$email');
            await launchUrl(url, mode: LaunchMode.externalApplication);
          },
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
