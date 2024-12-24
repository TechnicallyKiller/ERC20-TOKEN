// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.10;

import {Script} from "lib/forge-std/src/Script.sol";
import {MyToken} from "../src/MyToken.sol";

contract DeployMyToken is Script{
    uint256 private INTIAL_SUPPLY = 1000;
    function run() external returns(MyToken){
        vm.startBroadcast();
        MyToken my = new MyToken(INTIAL_SUPPLY);
        vm.stopBroadcast();
        return my;


    }
}