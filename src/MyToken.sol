// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(uint256 _intialSupply) ERC20("MyToken","MT") {
        _mint(msg.sender,_intialSupply);
    }

}