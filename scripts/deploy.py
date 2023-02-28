from brownie import PestoGreen, TokenFaucet, accounts
from scripts.helpful_scripts import get_account


def main():
    account = get_account()
    # 部署代币合约
    token = PestoGreen.deploy(
        "PCoin", "PCoin", {'from': account}, publish_source=True)

    # 部署Token Faucet合约并传入代币地址
    faucet = TokenFaucet.deploy(
        token.address, {'from': account}, publish_source=True)

    # 转移一些代币到Token Faucet合约地址
    token.transfer(faucet.address, 1000 * 10 **
                   token.decimals(), {'from': account})
