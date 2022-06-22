

import 'package:flutter/material.dart';

import '../../../model/place_service.dart';
import '../../../utils/device_utils.dart';
import '../../theme/app_colors.dart';

class AddressSearch extends SearchDelegate<Suggestions> {
  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  late final sessionToken;
  late PlaceApiProvider apiClient;

  @override
  // TODO: implement searchFieldStyle
  TextStyle? get searchFieldStyle => const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      fontFamily: 'Montserrat Regular',
      color: AppColors.appColor3);

  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Search';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(
          Icons.clear,
          color: AppColors.color7,
          size: 20,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith(
      inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
        isDense: true,
        fillColor: Colors.transparent,
        filled: false,
        focusColor: Colors.transparent,
        contentPadding: const EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),
        border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(10)),
      ),
      primaryColor: Colors.transparent,
      textTheme: const TextTheme(
        headline6: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            fontFamily: 'Montserrat SemiBold',
            color: AppColors.appColor0),
      ),
    );
    return theme;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(
        Icons.arrow_back,
        color: AppColors.appColor0,
        size: 20,
      ),
      onPressed: () {
        close(context, Suggestions('', ''));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Suggestions>>(
      future: query == ""
          ? null
          : apiClient.fetchSuggestions(
          query, Localizations.localeOf(context).languageCode),
      builder: (context, snapshot) => query == ''
          ? Container(
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          'Enter your address',
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              fontFamily: 'Montserrat SemiBold',
              color: AppColors.appColor0),
        ),
      )
          : snapshot.hasData
          ? Padding(
        padding: EdgeInsets.symmetric(
            vertical:
            DeviceUtils.getScaledHeight(context, scale: 0.01)),
        child: ListView.builder(
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.symmetric(
                vertical: DeviceUtils.getScaledHeight(context,
                    scale: 0.005),
                horizontal:
                DeviceUtils.getScaledWidth(context, scale: 0.02)),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: AppColors.appColor3, width: 0.7))),
            child: ListTile(
              horizontalTitleGap: 10,
              minLeadingWidth: 15,
              leading: const Icon(
                Icons.location_on_outlined,
              ),
              title: Text(
                (snapshot.data![index]).description,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    fontFamily: 'Montserrat SemiBold',
                    color: AppColors.appColor0),
              ),
              onTap: () {
                close(context, snapshot.data![index]);
              },
            ),
          ),
          itemCount: snapshot.data!.length,
        ),
      )
          : const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Searching...',
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              fontFamily: 'Montserrat Bold',
              color: AppColors.appColor0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
