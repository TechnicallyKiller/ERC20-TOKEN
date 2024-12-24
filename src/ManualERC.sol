// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.10;
contract ManualERC {
    mapping (address => uint) balanceA;
    string public name="Manual token";

//  function name() public view returns(string memory){
//     return "Manual Token";

//  }
 function decimals() public view returns (uint8){
    return 18;
 }
 function totalSupply() public view returns (uint256){
    return 100 ether;


 }
 function balanceOf(address _owner) public view returns (uint256 balance){
    return balanceA[_owner];
 }

 function transfer(address _to, uint256 _value) public returns (bool success){
    uint256 previousBalance = balanceOf(_to)+ balanceOf(msg.sender);
    balanceA[msg.sender]-=_value;
    balanceA[_to]+=_value;
    require(balanceA[_to]+balanceA[msg.sender]==previousBalance);

 }

}