
import 'package:flutter/material.dart';

import '../../exports.dart';

class OrderListItem extends StatelessWidget {
  final Order order;

  const OrderListItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 5),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          new BoxShadow (
            color: const Color(0xfff8f8f8).withAlpha(50),
            offset: new Offset(0.0, 2.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 14, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          topRight: Radius.circular(6.0),
                          bottomLeft: Radius.circular(6.0),
                          bottomRight: Radius.circular(6.0),
                        ),
                        color: Color(0xfff2f2f2),
                      ),
                      child: ClipRRect(
                        borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          topRight: Radius.circular(6.0),
                          bottomLeft: Radius.circular(6.0),
                          bottomRight: Radius.circular(6.0),
                        ),
                        child: CustomImage(
                          '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '2019年6月12日',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4a4a4a),
                            )
                          ),
                          Text(
                            '10:30-14:30',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff4a4a4a),
                            )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (_) => OrderDetailScreen(order)));
          },
        ),
      ),
    );
  }
}
