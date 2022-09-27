import 'package:flutter/material.dart';
import 'package:photo_sharing_clone_app/search_box/user.dart';

import 'users_specific_posts.dart';

class UsersDesignWidget extends StatefulWidget {

  Users? model;
  BuildContext? context;

  UsersDesignWidget({
    this.model,
    this.context,
});

  @override
  State<UsersDesignWidget> createState() => _UsersDesignWidgetState();
}

class _UsersDesignWidgetState extends State<UsersDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => UsersSpecificPostsScreen(
            userId: widget.model!.id,
            userName: widget.model!.name,
          ))
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 240.0,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.amberAccent,
                  minRadius: 90.0,
                  child: CircleAvatar(
                    radius: 80.0,
                    backgroundImage: NetworkImage(
                      widget.model!.userImage!,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0,),
                Text(
                  widget.model!.name!,
                  style: const TextStyle(
                    color: Colors.pink,
                    fontSize: 20.0,
                    fontFamily: "Bebas",
                  ),
                ),
                const SizedBox(height: 10.0,),
                Text(
                  widget.model!.email!,
                  style: const TextStyle(
                    color: Colors.pink,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
