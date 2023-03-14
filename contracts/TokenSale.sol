// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function balanceOf(address account) external view returns (uint256);

    function totalSupply() external view returns (uint256);

    function decimals() external view returns (uint8);
}

contract TokenSale {
    address public owner;
    IERC20 public token;
    uint256 public tokenPrice;
    uint256 public tokensSold;
    uint256 public minPurchase;
    uint256 public maxPurchase;

    event Sold(address buyer, uint256 amount);

    constructor(
        IERC20 _token,
        uint256 _tokenPrice,
        uint256 _minPurchase,
        uint256 _maxPurchase
    ) {
        owner = msg.sender;
        token = _token;
        tokenPrice = _tokenPrice;
        minPurchase = _minPurchase;
        maxPurchase = _maxPurchase;
    }

    function buyTokens(uint256 _tokenAmount) public payable {
        require(
            msg.value * tokenPrice== _tokenAmount,
            "Amount of ether sent is not correct"
        );
        require(
            token.balanceOf(address(this)) >= _tokenAmount,
            "Not enough tokens in contract"
        );
        require(
            _tokenAmount >= minPurchase,
            "Purchase amount is below minimum"
        );
        require(
            _tokenAmount <= maxPurchase,
            "Purchase amount is above maximum"
        );
        require(
            token.transfer(msg.sender, _tokenAmount),
            "Failed to transfer tokens"
        );

        tokensSold += _tokenAmount;

        emit Sold(msg.sender, _tokenAmount);
    }

    function withdraw() public {
        require(msg.sender == owner, "Only the owner can withdraw");
        uint256 balance = address(this).balance;
        payable(owner).transfer(balance);
    }

    function setTokenPrice(uint256 _tokenPrice) public {
        require(msg.sender == owner, "Only the owner can set the token price");
        tokenPrice = _tokenPrice;
    }

    function setMinPurchase(uint256 _minPurchase) public {
        require(
            msg.sender == owner,
            "Only the owner can set the minimum purchase amount"
        );
        minPurchase = _minPurchase;
    }

    function setMaxPurchase(uint256 _maxPurchase) public {
        require(
            msg.sender == owner,
            "Only the owner can set the maximum purchase amount"
        );
        maxPurchase = _maxPurchase;
    }

    function getTokenBalance() public view returns (uint256) {
        return token.balanceOf(address(this));
    }
}
