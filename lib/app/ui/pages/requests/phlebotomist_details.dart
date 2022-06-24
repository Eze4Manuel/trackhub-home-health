import 'package:flutter/material.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';

class PhlebotomistDetails extends StatefulWidget {
  int index;

  PhlebotomistDetails({required this.index, Key? key}) : super(key: key);

  @override
  State<PhlebotomistDetails> createState() => _PhlebotomistDetailsState();
}

class _PhlebotomistDetailsState extends State<PhlebotomistDetails> {
  @override
  Widget build(BuildContext context) {
    print(BaseController.assignedPhlebotomist);
    return Container(
      child: Column(
        children: [
          Container(
            width: 50,
            height: 6,
            decoration: const BoxDecoration(
                color: AppColors.color3,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: const Text(''),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.02),
          ),
          const Text(
            'Phlebotomist Details',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              fontFamily: 'Montserrat ExtraBold',
              color: AppColors.appColor3,
            ),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.04),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              BaseController.dispatches[widget.index]['dropoff_name'],
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontFamily: 'Montserrat ExtraBold',
                color: AppColors.appColor3,
              ),
            ),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.01),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              BaseController.dispatches[widget.index]['dropoff_address'],
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                fontFamily: 'Montserrat ExtraBold',
                color: AppColors.appColor3,
              ),
            ),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.02),
          ),
          ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(208.0),
                child:
                    BaseController.assignedPhlebotomist['image_url']!= null
                        ? Container(
                            color: AppColors.tertiaryColor,
                            child: Image.network(
                              BaseController.assignedPhlebotomist['image_url'],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            color: AppColors.tertiaryColor,
                            child: Image.asset(
                              'assets/images/profile.png',
                              width: 50,
                              height: 50,
                              color: AppColors.color12,
                            ),
                          )),
            trailing: Text(
              BaseController.assignedPhlebotomist['rating'] ?? '3.5',
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                fontFamily: 'Montserrat ExtraBold',
                color: AppColors.appColor0,
              ),
            ),
            title: Text(
              '${BaseController.assignedPhlebotomist['first_name'] + " " +BaseController.assignedPhlebotomist['last_name'] }',
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                fontFamily: 'Montserrat ExtraBold',
                color: AppColors.appPrimaryColor,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.01),
                ),
                Text(
                  BaseController.assignedPhlebotomist['phone_number'] ,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    fontFamily: 'Montserrat ExtraBold',
                    color: AppColors.appColor3,
                  ),
                ),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.01),
                ),
                Text(
                  BaseController.assignedPhlebotomist['bio'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: 'Montserrat ExtraBold',
                    color: AppColors.appColor3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
