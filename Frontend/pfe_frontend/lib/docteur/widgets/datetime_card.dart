import 'package:flutter/material.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/docteur/utils/constant.dart';

class DateTimeCard extends StatelessWidget {
  final String Date;
  final String starttime;
  final String endtime;
  
  const DateTimeCard({
    Key? key,
    required this.Date,
    required this.starttime,
    required this.endtime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AdminColorEight,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Colors.black,
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                this.Date,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.access_alarm,
                color: Colors.black,
                size: 17,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                this.starttime+' ~ ' +this.endtime,
                style: TextStyle(
                  color:  Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


class ConsultationCard extends StatelessWidget {
  
  
  const ConsultationCard({

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg03),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Color(MyColors.primary),
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Consultation n#',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.access_alarm,
                color: Color(MyColors.primary),
                size: 17,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '11:00 ~ 12:10',
                style: TextStyle(
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}