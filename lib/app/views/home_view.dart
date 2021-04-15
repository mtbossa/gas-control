import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:gas_mvc/app/components/home_view/container_input.dart';
import 'package:gas_mvc/app/components/home_view/container_values/container_values.dart';
import 'package:gas_mvc/app/constants/constants.dart';
import 'package:gas_mvc/app/controllers/home_controller.dart';
import 'package:gas_mvc/app/helpers/ads_helper.dart';
import 'package:gas_mvc/app/helpers/shared_preferecences_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

import '../components/home_view/input_price.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  BannerAd _banner;
  bool _isBannerLoaded = false;

  InterstitialAd _interstitialAd;
  int _interstitialAdCounter = 0;
  void createNewInterstitialAd() {
    _interstitialAd = InterstitialAd(
      adUnitId: AdsHelper.testInterstitialAdUnitId,
      request: AdRequest(),
      listener: AdListener(
        onAdLoaded: (_) {
          print("Ad loaded");
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('Ad failed to load: $error');
        },
        onAdOpened: (Ad ad) => print('Ad opened.'),
        onAdClosed: (Ad ad) {
          ad.dispose();
          print('Ad closed.');
        },
        onApplicationExit: (Ad ad) => print('Left application.'),
      ),
    );
    _interstitialAd.load();
  }

  HomeController _homeController;

  int _currentIndex; // Current index of result view

  String _dateText = "Outros...";
  String _datePressed = "";

  String remainingAmount = "duas";
  String remainingText = "leituras";

  TextEditingController _newIntValueTextController = TextEditingController();
  TextEditingController _newDecimalValueTextController =
      TextEditingController();
  MoneyMaskedTextController _gasPriceTextController =
      MoneyMaskedTextController();

  @override
  void initState() {
    _banner = BannerAd(
      size: AdSize.banner,
      adUnitId: AdsHelper.testBannerAdUnitId,
      listener: AdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerLoaded = true;
          });
        },
        onAdFailedToLoad: (_, error) {
          print("Ad failed to load with error: $error");
        },
      ),
      request: AdRequest(),
    );
    _banner.load();

    createNewInterstitialAd();

    _interstitialAdCounter =
        UserSimplePreferences.getInterstitialAdCounter() ?? 0;

    _homeController = HomeController(
      newIntValueTextController: _newIntValueTextController,
      newDecimalValueTextController: _newDecimalValueTextController,
      gasPriceTextController: _gasPriceTextController,
    );

    _homeController.conversionValue =
        UserSimplePreferences.getConversionValue() ?? 2.5;

    _homeController.gasPrice = UserSimplePreferences.getGasPrice() ?? 0.0;

    _homeController.exhibitAllContatos().then((_) {
      setState(() {
        print("Done");
      });
    });

    _homeController.initDateFormatting();
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(Icons.attach_money),
              onPressed: () {
                _changeGasPrice(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: PopupMenuButton(
              onSelected: choiceAction,
              itemBuilder: (context) {
                if (_homeController.listLeituras.length <= 0) {
                  return Constants.ChoicesOne.map((String choice) {
                    return PopupMenuItem(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                } else {
                  return Constants.ChoicesTwo.map((String choice) {
                    return PopupMenuItem(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                }
              },
              child: Icon(
                Icons.more_vert,
              ),
            ),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "CONTROLE DE GÁS",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      ContainerValues(
                        listLeituras: _homeController.listLeituras,
                        onChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        currentIndex: _currentIndex,
                        remainingAmount: remainingAmount,
                        remainingText: remainingText,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Adicionar nova leitura",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ContainerInput(
                        newDecimalValueTextController:
                            _newDecimalValueTextController,
                        newIntValueTextController: _newIntValueTextController,
                        gasPriceTextController: _gasPriceTextController,
                        listLeituras: _homeController.listLeituras,
                        dateSelection: _dateSelection,
                        dateText: _dateText,
                        datePressed: _datePressed,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: FloatingActionButton(
                          backgroundColor: Theme.of(context).primaryColor,
                          onPressed: () async {
                            // Gets all the values and returns an result
                            int result = _homeController.getValues();
                            if (result == 0) {
                              setState(() {
                                _homeController.addToDatabase();
                                if (_homeController.listLeituras.length <= 2)
                                  checkIndex();
                              });
                            } else if (result == 1) {
                              _showErroZero(context);
                            } else if (result == 2) {
                              _showErrorDifference(context);
                            } else if (result == 3) {
                              setState(() {
                                resetDateFields();
                                _showErrorDate(context);
                              });
                            }
                            resetDateFields();

                            // For showing the intestitial ad or not
                            _interstitialAdCounter++;
                            await UserSimplePreferences
                                .setInterstitialAdCounter(
                                    _interstitialAdCounter);
                            if (_interstitialAdCounter > 1) {
                              _interstitialAd.show();
                              createNewInterstitialAd();
                              _interstitialAdCounter = 0;
                              await UserSimplePreferences
                                  .setInterstitialAdCounter(
                                      _interstitialAdCounter);
                            }
                          },
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          checkForAd(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _banner?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  Widget checkForAd() {
    if (_isBannerLoaded) {
      return Container(
        color: Colors.white,
        alignment: Alignment.center,
        width: _banner.size.width.toDouble(),
        height: _banner.size.height.toDouble(),
        child: AdWidget(
          ad: _banner,
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  // AlertDialog for adding newAtualGasValue
  _zeroAllValuesDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Zerar valores",
          ),
          content: Container(
            height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Tem certeza que deseja"),
                Text("zerar todos os valores?"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("CANCELAR"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _homeController.zeroValues();
                  checkIndex();
                });
              },
              child: Text(
                "OK",
              ),
            ),
          ],
        );
      },
    );
  }

  // Revert last added value
  _revertLastValueDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Voltar leitura",
          ),
          content: Container(
            height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Tem certeza que deseja"),
                Text("voltar uma leitura?"),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "CANCELAR",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text(
                "OK",
              ),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _homeController.revertLastValue();
                });
              },
            ),
          ],
        );
      },
    );
  }

  _changeConversionValue(BuildContext context) {
    final List<double> items = Constants.conversionChoices;
    var selectedValue;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Alterar coeficiente de conversão de m³ para kg",
          ),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButton(
                    hint: Text("Selecione um número"),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    dropdownColor: Colors.grey[800],
                    value: selectedValue,
                    onChanged: (newValue) {
                      print(newValue);
                      setState(() {
                        selectedValue = newValue;
                      });
                      print(selectedValue);
                    },
                    items: items.map((valueItem) {
                      return DropdownMenuItem(
                        child: Text("$valueItem"),
                        value: valueItem,
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Valor atual: ${_homeController.conversionValue}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            );
          }),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("CANCELAR"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (selectedValue != null) {
                  await UserSimplePreferences.setConversionValue(selectedValue);
                  _homeController.conversionValue = selectedValue;
                }
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
              ),
            ),
          ],
        );
      },
    );
  }

  _changeGasPrice(BuildContext context) {
    final _fMoney = NumberFormat("####0.00", Platform.localeName);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Alterar o preço do kg/gás",
          ),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InputPrice(
                    gasPriceController: _gasPriceTextController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Valor atual: R\$ ${_fMoney.format(_homeController.gasPrice)}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            );
          }),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("CANCELAR"),
            ),
            ElevatedButton(
              onPressed: () async {
                String _gasPriceText = _gasPriceTextController.text;
                double _gasPriceDoubleValue;
                if (_gasPriceText != "") {
                  _gasPriceDoubleValue = double.tryParse(_gasPriceText
                              .replaceAll(new RegExp(r'[,.]'), '')) /
                          100 ??
                      0.0;
                  _homeController.gasPrice = _gasPriceDoubleValue;
                  await UserSimplePreferences.setGasPrice(_gasPriceDoubleValue);
                  _homeController.updateLast().then((_) {
                    setState(() {
                      print("Done");
                    });
                  });
                  _homeController.exhibitAllContatos().then((_) {
                    setState(() {
                      print("Done");
                    });
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
              ),
            ),
          ],
        );
      },
    );
  }

  // Function that does something depeding on choice
  void choiceAction(String choice) {
    if (choice == Constants.voltarLeitura) {
      _revertLastValueDialog(context);
    } else if (choice == Constants.zerarValores) {
      _zeroAllValuesDialog(context);
    } else if (choice == Constants.alterarValor) {
      _changeConversionValue(context);
    }
  }

  void _dateSelection(String dateSelection) {
    if (dateSelection == "Hoje") {
      setState(() {
        _datePressed = "Hoje";
      });

      _homeController.atualDate = DateTime.now();
    } else if (dateSelection == "Ontem") {
      setState(() {
        _datePressed = "Ontem";
      });

      _homeController.atualDate = DateTime.now().subtract(
        Duration(
          days: 1,
        ),
      );
    } else {
      _datePressed = "Outros";
      _showCalendar(context);
    }
  }

  Future<Null> _showCalendar(BuildContext context) async {
    DateTime _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.grey[800],
              onPrimary: Colors.white,
              surface: Colors.grey[800],
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: Colors.grey[600],
          ),
          child: child,
        );
      },
    );
    setState(() {
      if (_pickedDate != null) {
        _homeController.atualDate = _pickedDate;
        _dateText = _homeController.dateFormatCalendar.format(_pickedDate);
      }
    });
  }

  void resetDateFields() {
    _homeController.atualDate = null;
    _datePressed = "";
    _dateText = "Outros ...";
  }

  void checkIndex() {
    if (_homeController.listLeituras.length == 0) {
      remainingAmount = "duas";
      remainingText = "leituras";
    }
    if (_homeController.listLeituras.length == 1) {
      remainingAmount = "uma";
      remainingText = "leitura";
    }
  }

  // AlertDialog for Date Error
  _showErrorDate(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Erro",
          ),
          content: Container(
            height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Nova leitura deve possuir data maior do que a anterior."),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // AlertDialog for Difference Error
  _showErrorDifference(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Erro",
          ),
          content: Container(
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    "Valor da nova leitura deve ser maior do que o valor da leitura anterior."),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // AlertDialog for Date Error
  _showErroZero(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Erro",
          ),
          content: Container(
            height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Novo valor dever ser maior do que zero."),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
