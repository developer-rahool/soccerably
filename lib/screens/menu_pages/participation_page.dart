import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import '../../const.dart';
import '../../controller/tournament_country_provider.dart';

class CountryTournamentPage extends StatefulWidget {
  String? tour;
  CountryTournamentPage({super.key, this.tour});

  @override
  State<CountryTournamentPage> createState() => _CountryTournamentPageState();
}

class _CountryTournamentPageState extends State<CountryTournamentPage> {
  TournamentByCountryProvider data = TournamentByCountryProvider();
  String tournament = "";
  List<String> teams = [];
  @override
  void initState() {
    data = context.read<TournamentByCountryProvider>();
    load();
    super.initState();
  }

  load() async {
    data.fetchCountriesByTournaments(widget.tour!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlackColor,
      appBar: AppBarWidget(title: "Participations"),
      body: Consumer<TournamentByCountryProvider>(
          builder: (context, provider, child) {
        return Padding(
          padding: mainPadding,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: provider.isLoading
                    ? const Center(child: LoaderWidget())
                    : provider.filteredTournaments.isEmpty
                        ? const Center(
                            child: Text("No Records",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                          )
                        : SingleChildScrollView(
                            child: SizedBox(
                              height: screenHeight(context) * 0.75,
                              width: double.infinity,
                              child: ListView.builder(
                                itemCount: provider.filteredTournaments.length,
                                itemBuilder: (context, index) {
                                  tournament =
                                      provider.filteredTournaments[index].id!;
                                  teams = provider
                                      .filteredTournaments[index].teams!;
                                  return MainContainer(
                                    child: ListTile(
                                      title: Text('${tournament}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                      subtitle: Text(
                                          "Countries:\n${teams.join(',\n')}"),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                          text: "Copy",
                          onPressed: () {
                            toast(context);
                            copyText(
                                "Tournament: ${tournament}, Countries: ${teams.join(',\n')}");
                            Navigator.pop(context);
                          }),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: CustomButton(
                          text: "Share",
                          onPressed: () {
                            Share.share(
                                "Tournament: ${tournament}, Countries: ${teams.join(',\n')}");
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
