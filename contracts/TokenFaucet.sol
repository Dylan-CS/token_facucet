// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PestoGreen.sol";

contract TokenFaucet {
    PestoGreen private _token;

    constructor(PestoGreen token_) {
        _token = token_;
    }

    function drip(address recipient, uint256 amount) public {
        _token.transfer(recipient, amount);
    }

    function getTokenAddress() public view returns (address) {
        return address(_token);
    }
}
