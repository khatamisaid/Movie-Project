import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prakmobile/util/constants.dart';
import 'package:prakmobile/view/detail.dart';

class CardView extends StatelessWidget {
  final Map<String, dynamic> data;
  const CardView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(
        const Detail(),
        arguments: {
          "id": data["id"],
          "isMovie": data['title'] != null ? 'movie' : 'tv'
        },
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        height: 300,
        width: (MediaQuery.of(context).size.width / 2) - 20,
        child: Column(
          children: [
            Image(
              image: NetworkImage(
                URLgetImageTmdb + data['poster_path'],
              ),
              colorBlendMode: BlendMode.multiply,
              fit: BoxFit.cover,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    data['title'] ?? data['name'],
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Text(
                      data['vote_average'].toString(),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
