// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployMyToken} from "../script/DeployMyToken.s.sol";
import {MyToken} from "../src/MyToken.sol";

contract OurTokenTest is Test {
    MyToken public mytoken;
    uint256 public constant START_BALANCE = 100 ether;
    DeployMyToken public deployMyToken;
    address bob = makeAddr("bob");
    address Div = makeAddr("Div");

    function setUp() public {
        deployMyToken = new DeployMyToken();
        mytoken = deployMyToken.run();

        vm.prank(address(deployMyToken));
        mytoken.transfer(bob, START_BALANCE);
    }

    // Test Bob's initial balance
    function testBobBalance() public {
        assertEq(START_BALANCE, mytoken.balanceOf(bob));
    }

    // Test a simple transfer from Bob to Div
    function testSimpleTransfer() public {
        uint256 transferAmount = 10 ether;

        vm.prank(bob);
        mytoken.transfer(Div, transferAmount);

        assertEq(mytoken.balanceOf(Div), transferAmount);
        assertEq(mytoken.balanceOf(bob), START_BALANCE - transferAmount);
    }

    // Test approval functionality
    function testApproval() public {
        uint256 allowanceAmount = 50 ether;

        vm.prank(bob);
        mytoken.approve(Div, allowanceAmount);

        assertEq(mytoken.allowance(bob, Div), allowanceAmount);
    }

    // Test zero transfer (should not change balances)
    function testZeroTransfer() public {
        uint256 transferAmount = 0;

        vm.prank(bob);
        mytoken.transfer(Div, transferAmount);

        assertEq(mytoken.balanceOf(Div), 0);
        assertEq(mytoken.balanceOf(bob), START_BALANCE);
    }

    // Test reducing allowance below current usage
    // Adjust allowance using approve instead
function testAdjustAllowance() public {
    uint256 initialAllowance = 20 ether;

    vm.prank(bob);
    mytoken.approve(Div, initialAllowance);

    vm.prank(Div);
    mytoken.transferFrom(bob, Div, 10 ether);

    vm.prank(bob);
    mytoken.approve(Div, 5 ether); // Adjust allowance to 5 ether
    assertEq(mytoken.allowance(bob, Div), 5 ether);
}

}
