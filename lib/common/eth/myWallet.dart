import 'package:bip39/bip39.dart' as bip39;
import 'package:bitcoin_flutter/bitcoin_flutter.dart' as bitcoin_flutter;
import 'package:web3dart/web3dart.dart';
import 'ethTransaction.dart';

class MyWallet {
  /// 创建随机助记词 | Create Random Mnemonic
  static String createRandomMnemonic() {
    String randomMnemonic = bip39.generateMnemonic();
    return randomMnemonic;
  }

  /// 导入助记词，返回[eth地址] | Import mnemonic words and return [eth address]
  static Future<String> getEthAddress(String mnemonic, {int id = 0}) async {
    String ethPath = "m/44'/60'/0'/0/$id";
    EthPrivateKey ethPrivateKey =
        ethMnemonicToPrivateKey(mnemonic, derivePath: ethPath);
    EthereumAddress ethAddr = await ethPrivateKey.extractAddress();
    String ethAddress = ethAddr.toString();

    return ethAddress;
  }

  /// ETH 导入助记词返回私钥 | ETH import mnemonic phrase and return private key
  static EthPrivateKey ethMnemonicToPrivateKey(String mnemonic,
      {String derivePath}) {
    String ethPath = (derivePath != null && derivePath.isNotEmpty)
        ? derivePath
        : "m/44'/60'/0'/0/0";
    bitcoin_flutter.HDWallet hdWalletEth =
        bitcoin_flutter.HDWallet.fromSeed(bip39.mnemonicToSeed(mnemonic))
            .derivePath(ethPath);

    String privateKey = hdWalletEth.privKey;

    EthPrivateKey ethPrivateKey = EthPrivateKey.fromHex(privateKey);
    return ethPrivateKey;
  }

  /// ETH转账 | ETH transfer
  static Future<String> transactionETH(String mnemonic, String fromAddress,
      String toAddress, String amount, String gasPrice, int nonce,
      {String network}) async {
    EthPrivateKey ethPrivateKey = ethMnemonicToPrivateKey(mnemonic);

    Etransaction transaction =
        await EthereumTransaction.createEthereumTransaction(
            fromAddress, toAddress, amount, gasPrice, nonce,
            network: network);

    String txHash = await EthereumTransaction.signEthereumTransaction(
        ethPrivateKey, transaction);

    return txHash;
  }

  /// ERC20USDT转账 | ERC20USDT transfer
  // static Future<String> transactionERC20USDT(
  //   String mnemonic,
  //   String fromAddress,
  //   String toAddress,
  //   String amount,
  //   String gasPrice,
  //   int nonce,
  // ) async {
  //   EthPrivateKey ethPrivateKey = ethMnemonicToPrivateKey(mnemonic);

  //   Etransaction transaction = await EthereumTransaction.createErc20Transaction(
  //       fromAddress, toAddress, amount, gasPrice, nonce);

  //   String txPack = await EthereumTransaction.signEthereumTransaction(
  //       ethPrivateKey, transaction);

  //   return txPack;
  // }
}
