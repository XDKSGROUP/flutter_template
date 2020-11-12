import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:fulate/api/api.dart';
import 'package:wallet_hd/wallet_hd.dart';

class EthPage extends StatefulWidget {
  @override
  _EthState createState() => _EthState();
}

class _EthState extends State<EthPage> {
  @override
  Widget build(BuildContext context) {
    createAddress();
    return Container();
  }

  createAddress() async {
    String mnemonic =
        "then story swamp emotion valve spy improve raccoon inflict sing moment dish";
    Map<String, String> mapAddr = await WalletHd.getAccountAddress(mnemonic,
        derivePath: "m/44'/60'/0'/0/0");
    String ethAddr = mapAddr["ETH"];
    String to = "0x6b926ff3674315c5a2b0e0d46151986291143d81";

    testTransactionETH(mnemonic, ethAddr, to, '0.01');
  }

  Future testTransactionETH(
    String mnemonic,
    String fromAddress,
    String toAddress,
    String amount,
  ) async {
    String gasPrice = await EthApi.gasPrice();
    int nonce = await EthApi.getNonce(fromAddress);

    String txPack = await WalletHd.transactionETH(
        mnemonic, fromAddress, toAddress, amount, gasPrice, nonce);
    var result = await EthApi.sendRawTransaction(txPack);
    print(result);
  }
}
