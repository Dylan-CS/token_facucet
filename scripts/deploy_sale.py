from brownie import TokenSale, accounts, PestoGreen
from scripts.helpful_scripts import get_account


def main():
    account = get_account()
    # 部署代币合约
    TokenSale.deploy(
        "0x9830082B8Fba4680382Bb2a1d5316291bbf1d046", "100", 1 * 10 ** 18, 100 * 10 ** 18,
        {'from': account}, publish_source=True)
