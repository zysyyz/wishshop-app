import "package:intl/intl.dart";
import 'package:flutter/material.dart';
import '../../exports.dart';

class ReviewListItem extends StatelessWidget {
  final Review review;

  ReviewListItem(this.review);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Row(
                children: <Widget> [
                  Container(
                    margin: EdgeInsets.only(right: 12),
                    child: CustomAvatar(review.user?.avatarUrl, size: 28,),
                  ),
                  Text(
                    review.user?.name ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(flex: 1, child: Container(),),
                  Text(
                    DateFormat.yMMMd().format(DateTime.parse((review?.updatedAt))),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  )
                ]
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 38.0),
              child: Text(
                review.content,
                style: TextStyle(
                  fontSize: 14,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        )
      ),
    );
  }
}
