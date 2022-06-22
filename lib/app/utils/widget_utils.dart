import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:intl/intl.dart';

 InputDecoration InputDecorationValues(
    {String hintText = "", IconData prefixIcon = Icons.file_present}) {
  return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      hintText: hintText,
      errorStyle: const TextStyle(
          fontWeight:
          FontWeight.w400,
          fontSize: 13,
          fontFamily:
          'Montserrat Bold',
          color: AppColors
              .color7),
      border: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.appPrimaryColor)),
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.appPrimaryColor)),
      enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.appPrimaryColor)),
    errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
        borderRadius: BorderRadius.circular(3.0)));
}

InputDecoration InputDecorationValues02(
    {String hintText = "", IconData prefixIcon = Icons.file_present}) {
  return InputDecoration(
      isDense: true,
      fillColor: AppColors.whiteColor,
      counterText: "",
      filled: true,
      errorStyle: const TextStyle(
          fontWeight:
          FontWeight.w400,
          fontSize: 13,
          fontFamily:
          'Montserrat Bold',
          color: AppColors
              .color7),
      focusColor: Colors.transparent,
      contentPadding: const EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),
      hintText: hintText,
      border: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, color: Colors.transparent,),
          borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, color: Colors.transparent),
          borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
          borderRadius: BorderRadius.circular(10.0)),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
          borderRadius: BorderRadius.circular(3.0)),
  );
}


InputDecorationTheme InputDecorationThemeValues02() {
  return InputDecorationTheme(
    isDense: true,
    fillColor: Colors.transparent,
    filled: false,

    errorStyle: const TextStyle(
        fontWeight:
        FontWeight.w400,
        fontSize: 13,
        fontFamily:
        'Montserrat Bold',
        color: AppColors
            .color7),
    focusColor: Colors.transparent,
    contentPadding: const EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),
    border: UnderlineInputBorder(
        borderSide: const BorderSide(width: 0, color: Colors.transparent,),
        borderRadius: BorderRadius.circular(10)),
    enabledBorder: UnderlineInputBorder(
        borderSide: const BorderSide(width: 0, color: Colors.transparent),
        borderRadius: BorderRadius.circular(10)),
    focusedBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
        borderRadius: BorderRadius.circular(10.0)),
    errorBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
        borderRadius: BorderRadius.circular(3.0)),
  );
}

InputDecoration InputDecorationValues03(
    {String hintText = "", IconData prefixIcon = Icons.file_present, required Widget surfixIcon}) {
  return InputDecoration(
    isDense: true,
    fillColor: Colors.transparent,
    filled: false,
    suffixIcon: surfixIcon,
    errorStyle: const TextStyle(
        fontWeight:
        FontWeight.w400,
        fontSize: 13,
        fontFamily:
        'Montserrat Bold',
        color: AppColors
            .color7),
    focusColor: Colors.transparent,
    contentPadding: const EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),
    hintText: hintText,
    border: OutlineInputBorder(
        borderSide: const BorderSide(width: 0, color: Colors.transparent,),
        borderRadius: BorderRadius.circular(10)),
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 0, color: Colors.transparent),
        borderRadius: BorderRadius.circular(10)),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
        borderRadius: BorderRadius.circular(10.0)),
    errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
        borderRadius: BorderRadius.circular(3.0)),
  );

}

InputDecoration InputDecorationNoPrefixValues(
    {String hintText = "", IconData prefixIcon = Icons.file_present}) {
  return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      hintText: hintText,
      hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 13,
          fontFamily: 'Montserrat Regular',
          color: AppColors.color10),
      counterText: "",
      border: OutlineInputBorder(
          borderSide: const BorderSide(width: 32.0),
          borderRadius: BorderRadius.circular(6.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 32.0),
          borderRadius: BorderRadius.circular(6.0)));
}

class DispatchCard_01 extends StatelessWidget {
  final String id;
  final String title;
  final String pickup;
  final String dropoff;

  const DispatchCard_01(
      {Key? key,
      required this.id,
      required this.title,
      required this.pickup,
      required this.dropoff})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      width: DeviceUtils.getScaledWidth(context, scale: 0.8),
      padding: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledHeight(context, scale: 0.02),
          horizontal: DeviceUtils.getScaledWidth(context, scale: 0.03)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: DeviceUtils.getScaledWidth(context, scale: 0.09),
            height: DeviceUtils.getScaledHeight(context, scale: 0.007),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.color13),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.01),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Text(
                    id,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        fontFamily: 'Montserrat Bold',
                        color: AppColors.appColor0),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              SizedBox(
                width: DeviceUtils.getScaledWidth(context, scale: 0.04),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Montserrat ExtraBold',
                      color: AppColors.appPrimaryColor),
                ),
              ),
            ],
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.02),
          ),
          TimelineTile(
            afterLineStyle:
                const LineStyle(color: AppColors.secondaryColor, thickness: 1),
            indicatorStyle: const IndicatorStyle(
                drawGap: true, width: 5, color: AppColors.secondaryColor),
            alignment: TimelineAlign.manual,
            isFirst: true,
            lineXY: 0.25,
            endChild: Container(
              margin: const EdgeInsets.only(bottom: 15.0, left: 5.0),
              child: Text(
                pickup,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  fontFamily: 'Montserrat Bold',
                  color: AppColors.color12,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            startChild: Container(
              margin: const EdgeInsets.only(bottom: 15.0, right: 5.0),
              child: const Text(
                'Pick Up ',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  fontFamily: 'Montserrat Bold',
                  color: AppColors.color12,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          TimelineTile(
            beforeLineStyle:
                const LineStyle(color: AppColors.secondaryColor, thickness: 1),
            indicatorStyle:
                const IndicatorStyle(width: 5, color: AppColors.secondaryColor),
            alignment: TimelineAlign.manual,
            isLast: true,
            lineXY: 0.25,
            endChild: Container(
              margin: const EdgeInsets.only(top: 0.0, left: 5.0),
              child: Text(
                dropoff,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: 'Montserrat Bold',
                    color: AppColors.color12),
                textAlign: TextAlign.left,
              ),
            ),
            startChild: Container(
              margin: const EdgeInsets.only(top: 0.0, right: 5.0),
              child: const Text(
                'Drop-off ',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                    fontFamily: 'Montserrat Bold',
                    color: AppColors.color12),
                textAlign: TextAlign.right,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DispatchCard_02 extends StatelessWidget {
  final String id;
  final String title;
  final String pickup;
  final String dropoff;
  final Color panelColor;

  const DispatchCard_02(
      {Key? key,
      required this.id,
      required this.title,
      required this.pickup,
      required this.dropoff,
      required this.panelColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: panelColor,
        borderRadius: BorderRadius.circular(15),
      ),
      width: DeviceUtils.getScaledWidth(context, scale: 0.9),
      child: Container(
        width: DeviceUtils.getScaledWidth(context, scale: 0.85),
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              bottomLeft: Radius.circular(0),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15)),
        ),
        padding: EdgeInsets.only(
          top: DeviceUtils.getScaledHeight(context, scale: 0.01),
          bottom: DeviceUtils.getScaledHeight(context, scale: 0.02),
        ),
        margin: EdgeInsets.only(
            left: DeviceUtils.getScaledWidth(context, scale: 0.03)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.01),
            ),
            Row(
              children: [
                 Expanded(
                  flex: 1,
                  child: id.length > 0 ? Text(
                    'ID ${id.substring(18, id.length)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        fontFamily: 'Montserrat Bold',
                        color: AppColors.appColor0),
                    textAlign: TextAlign.right,
                  ) : const Text(''),
                ),
                SizedBox(
                  width: DeviceUtils.getScaledWidth(context, scale: 0.04),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: 'Montserrat ExtraBold',
                        color: AppColors.appPrimaryColor),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.02),
            ),
            TimelineTile(
              afterLineStyle:
                  const LineStyle(color: AppColors.secondaryColor, thickness: 1),
              indicatorStyle: const IndicatorStyle(
                  drawGap: true, width: 5, color: AppColors.secondaryColor),
              alignment: TimelineAlign.manual,
              isFirst: true,
              lineXY: 0.25,
              endChild: Container(
                margin: const EdgeInsets.only(bottom: 15.0, left: 5.0),
                child: Text(
                  pickup,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: 'Montserrat Bold',
                    color: AppColors.color12,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              startChild: Container(
                margin: const EdgeInsets.only(bottom: 15.0, right: 5.0),
                child: const Text(
                  'Pick Up ',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: 'Montserrat SemiBold',
                    color: AppColors.color12,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            TimelineTile(
              beforeLineStyle:
                  const LineStyle(color: AppColors.secondaryColor, thickness: 1),
              indicatorStyle:
                  const IndicatorStyle(width: 5, color: AppColors.secondaryColor),
              alignment: TimelineAlign.manual,
              isLast: true,
              lineXY: 0.25,
              endChild: Container(
                margin: const EdgeInsets.only(top: 0.0, left: 5.0),
                child: Text(
                  dropoff,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      fontFamily: 'Montserrat Bold',
                      color: AppColors.color12),
                  textAlign: TextAlign.left,
                ),
              ),
              startChild: Container(
                margin: const EdgeInsets.only(top: 0.0, right: 5.0),
                child: const Text(
                  'Drop-off ',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      fontFamily: 'Montserrat SemiBold',
                      color: AppColors.color12),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.01),
            ),
          ],
        ),
      ),
    );
  }
}




class DispatchCard_03 extends StatelessWidget {
  final int index;

  const DispatchCard_03({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(15),
      ),
      width: DeviceUtils.getScaledWidth(context, scale: 0.9),
      child: Container(
        width: DeviceUtils.getScaledWidth(context, scale: 0.85),
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              bottomLeft: Radius.circular(0),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15)),
        ),
        padding: EdgeInsets.only(
          top: DeviceUtils.getScaledHeight(context, scale: 0.01),
          bottom: DeviceUtils.getScaledHeight(context, scale: 0.02),
          right: DeviceUtils.getScaledWidth(context, scale: 0.03),
          left: DeviceUtils.getScaledWidth(context, scale: 0.03),
        ),
        margin: EdgeInsets.only(
            left: DeviceUtils.getScaledWidth(context, scale: 0.03)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.01),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      BaseController.tickets[index]['_id'].toString().substring(
                          BaseController.tickets[index]['_id']
                              .toString()
                              .length -
                              7),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          fontFamily: 'Montserrat ExtraBold',
                          color: AppColors.appColor0),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(
                  width: DeviceUtils.getScaledWidth(context, scale: 0.01),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    BaseController.tickets[index]['subject'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        fontFamily: 'Montserrat ExtraBold',
                        color: AppColors.appPrimaryColor),
                  ),
                ),
                SizedBox(
                  width: DeviceUtils.getScaledWidth(context, scale: 0.01),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    BaseController.tickets[index]['status'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        fontFamily: 'Montserrat Regular',
                        color: AppColors.appColor0),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.02),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                BaseController.tickets[index]['detailed_description'],
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontFamily: 'Montserrat SemiBold',
                  color: AppColors.appColor0,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.01),
            ),
          ],
        ),
      ),
    );
  }
}

class DispatchCard_04 extends StatelessWidget {
  final String text;
  final String title;
  final String time;

  const DispatchCard_04({
    Key? key,
    required this.text,
    required this.title,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceUtils.getScaledWidth(context, scale: 0.9),
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10)),
      ),
      padding: EdgeInsets.only(
        top: DeviceUtils.getScaledHeight(context, scale: 0.01),
        bottom: DeviceUtils.getScaledHeight(context, scale: 0.02),
        right: DeviceUtils.getScaledWidth(context, scale: 0.03),
        left: DeviceUtils.getScaledWidth(context, scale: 0.03),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.01),
          ),
          Container(
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  fontFamily: 'Montserrat ExtraBold',
                  color: AppColors.appColor0),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.01),
          ),
          Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                fontFamily: 'Montserrat SemiBold',
                color: AppColors.appColor0),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.02),
          ),
        ],
      ),
    );
  }
}


class DispatchCard_05 extends StatelessWidget {
  final Map specimen;

  DispatchCard_05({Key? key, required this.specimen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceUtils.getScaledWidth(context, scale: 0.95),
      decoration: BoxDecoration(
        color: AppColors.appColor4,
        borderRadius: BorderRadius.circular(7),
      ),
      padding: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledHeight(context, scale: 0.01),
          horizontal: DeviceUtils.getScaledWidth(context, scale: 0.03)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Patient Name",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    fontFamily: 'Montserrat ExtraBold',
                    color: AppColors.appColor0),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                width: DeviceUtils.getScaledWidth(context, scale: 0.03),
              ),
              Flexible(
                child: Text(
                  '${specimen['name_of_patient']}',
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Montserrat SemiBold',
                      color: AppColors.appColor0),
                ),
              ),
            ],
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.012),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Specimen type",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    fontFamily: 'Montserrat ExtraBold',
                    color: AppColors.appColor0),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                width: DeviceUtils.getScaledWidth(context, scale: 0.03),
              ),
              Flexible(
                child: Text(
                  '${specimen['specimen_type']}',
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Montserrat SemiBold',
                      color: AppColors.color7),
                ),
              ),
            ],
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.012),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "No of bottles",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    fontFamily: 'Montserrat ExtraBold',
                    color: AppColors.appColor0),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                width: DeviceUtils.getScaledWidth(context, scale: 0.03),
              ),
              Flexible(
                child: Text(
                  '${specimen['no_of_bottles']}',
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Montserrat SemiBold',
                      color: AppColors.appColor0),
                ),
              ),
            ],
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.012),
          )
        ],
      ),
    );
  }
}



class DispatchCard_06 extends StatelessWidget {
  var comment;
  DispatchCard_06({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime? now = DateTime.tryParse(comment['created_at'].toString());
    final DateFormat formatter = DateFormat('MMMM-dd - hh:mm');
    final String formatted = formatter.format(now!);

    return Container(
      width: DeviceUtils.getScaledWidth(context, scale: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Image.asset(
                'assets/images/profile.png',
                height: 40.0,
                width: 40.0,
              ),
            ),
          ),
          SizedBox(
            width: DeviceUtils.getScaledWidth(context, scale: 0.02),
          ),
          Container(
            width: DeviceUtils.getScaledWidth(context, scale: 0.73),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(9)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment['message'],
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      fontFamily: 'Montserrat Bold',
                      color: AppColors.appColor0),
                ),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.012),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        formatted,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.color12),
                      ),
                    ),
                    SizedBox(
                      width: DeviceUtils.getScaledWidth(context, scale: 0.01),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                          comment['messenger_name'],
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              fontFamily: 'Montserrat Bold',
                              color: AppColors.appPrimaryColor)
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DispatchCard_07 extends StatelessWidget {
  var comment;

  DispatchCard_07({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime? now = DateTime.tryParse(comment['created_at'].toString());
    final DateFormat formatter = DateFormat('MMMM-dd - hh:mm');
    final String formatted = formatter.format(now!);

    return Container(
      width: DeviceUtils.getScaledWidth(context, scale: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: DeviceUtils.getScaledWidth(context, scale: 0.73),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(9)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment['message'],
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      fontFamily: 'Montserrat Bold',
                      color: AppColors.appColor0),
                ),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.012),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        formatted,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.color12),
                      ),
                    ),
                    SizedBox(
                      width: DeviceUtils.getScaledWidth(context, scale: 0.01),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        comment['messenger_name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appPrimaryColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: DeviceUtils.getScaledWidth(context, scale: 0.02),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Image.asset(
                'assets/images/profile.png',
                height: 40.0,
                width: 40.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class Analytic extends StatelessWidget {
  String value;
  String title;

  Analytic({Key? key, required this.value, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceUtils.getScaledWidth(context, scale: 0.25),
      padding: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledHeight(context, scale: 0.015)),
      decoration: BoxDecoration(
          color: AppColors.appPrimaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 22,
                fontFamily: 'Montserrat ExtraBold',
                color: AppColors.whiteColor),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.01),
          ),
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                fontFamily: 'Montserrat Regular',
                color: AppColors.whiteColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

ToastWidget(context, text, type, duration) {
  showToastWidget(
      Container(
        margin: EdgeInsets.only(bottom: DeviceUtils.getScaledHeight(context, scale: 0.105)),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: DeviceUtils.getScaledWidth(context, scale: 0.04),
            vertical: DeviceUtils.getScaledHeight(context, scale: 0.015),
          ),
          margin: EdgeInsets.symmetric(
              horizontal: DeviceUtils.getScaledWidth(context, scale: 0.04)),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: (type == 'warning')
                ? AppColors.secondaryColor
                : (type == 'success')
                    ? AppColors.appColor2_1
                    : (type == 'danger')
                        ? AppColors.color7
                        : AppColors.color12,
          ),
          child: Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                fontFamily: 'Montserrat Regular',
                color: AppColors.whiteColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      context: context,
      position: StyledToastPosition.bottom,
      axis: Axis.vertical,
      startOffset: Offset.fromDirection(140),
      isIgnoring: false,
      animDuration: const Duration(milliseconds: 200),
      duration: Duration(seconds: duration),
      animation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
      isHideKeyboard: true);
}
