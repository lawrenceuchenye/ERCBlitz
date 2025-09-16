// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract ECR20{
    string public totalSupply;
    string public name;
    string public symbol;
    uint8 public decimals;
    
    mapping(address=>uint256) public balanceOf;
    mapping(address => (address=>uint256)) allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);


    constructor(uint256 _totalSupply,uint8 _decimals,string _tokenName,string _tokenSymbol,string _tokenName){
      totalSupply=_totalSuppy;
      decimals=_decimals;
      name=_tokenName;
      symbol=_tokenSymbol;
    }
}