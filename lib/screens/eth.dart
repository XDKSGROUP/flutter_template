import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fulate/api/api.dart';
import 'package:fulate/common/commons.dart';
import 'package:fulate/config/config.dart';

class EthPage extends StatefulWidget {
  @override
  _EthState createState() => _EthState();
}

class _EthState extends State<EthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyGlobal.ethNetWork == 'mainnet'
            ? "正式网"
            : MyGlobal.ethNetWork == 'ropsten'
                ? "测试网"
                : "未知网络"),
        actions: [
          IconButton(
            icon: Icon(Icons.track_changes),
            onPressed: () {
              setState(() {
                if (MyGlobal.ethNetWork == 'mainnet') {
                  MyGlobal.ethNetWork = 'ropsten';
                } else {
                  MyGlobal.ethNetWork = 'mainnet';
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: '助记词'),
            controller: this.mnemonic,
          ),
          MaterialButton(
            onPressed: () => loadAddress(),
            color: Colors.teal,
            textColor: Colors.white,
            child: Text("使用助记词生成地址"),
            splashColor: Colors.blueAccent,
          ),
          Text("Eth地址: ${this.from.text}"),
          Text("余额: ${this.balance.text}"),
          TextFormField(
            decoration: InputDecoration(labelText: '发送给'),
            controller: this.to,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: '金额'),
            controller: this.amount,
          ),
          Text(
              "矿工费: ${(BigInt.parse(this.gasPrice.text) * BigInt.parse(this.gasLimit.text)) / new BigInt.from(10).pow(18)}"),
          MaterialButton(
            onPressed: () => send(),
            color: Colors.teal,
            textColor: Colors.white,
            child: Text(Locate.sendButtonText),
            splashColor: Colors.blueAccent,
          ),
          Text("交易哈希: ${this.txHash.text}"),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    mnemonic = TextEditingController(
        text:
            'then story swamp emotion valve spy improve raccoon inflict sing moment dish');
    to = TextEditingController(
        text: ('0x6B926Ff3674315c5A2B0e0d46151986291143D80').toLowerCase());
    amount = TextEditingController(text: '0.01');
    from = TextEditingController(text: '');
    gasLimit = TextEditingController(text: '21000');
    gasPrice = TextEditingController(text: '0');
    txHash = TextEditingController(text: '');
    balance = TextEditingController(text: '');
  }

  TextEditingController mnemonic;
  TextEditingController to;
  TextEditingController amount;
  TextEditingController from;
  TextEditingController gasPrice;
  TextEditingController gasLimit;
  TextEditingController txHash;
  TextEditingController balance;
  int nonce;

  send() async {
    await createAddress(this.mnemonic.text, this.to.text, this.amount.text);
  }

  createAddress(mnemonic, to, amount) async {
    // int nonce = await EthApi.getNonce(this.from.text);

    String txPack = await MyWallet.transactionETH(
        mnemonic, this.from.text, to, amount, this.gasPrice.text, nonce,
        network: MyGlobal.ethNetWork);

    var result = await EthApi.sendRawTransaction(txPack);
    setState(() {
      txHash = TextEditingController(text: result);
    });
    print(result);
  }

  void loadAddress() async {
    setState(() {
      from = TextEditingController(text: '');
      balance = TextEditingController(text: '');
    });
    await Future.wait<dynamic>([
      MyWallet.getEthAddress(this.mnemonic.text),
      EthApi.gasPrice(),
    ]).then((e) {
      setState(() {
        from = TextEditingController(text: e[0]);
        gasPrice = TextEditingController(text: e[1]);
      });
    });
    Future.wait<dynamic>([
      EthApi.getBalance(this.from.text),
      EthApi.getNonce(this.from.text),
    ]).then((e) {
      setState(() {
        balance = TextEditingController(text: e[0]);
        nonce = TextEditingController(text: e[1]) as int;
      });
    });
  }
}
