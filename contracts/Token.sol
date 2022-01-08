pragma solidity ^0.8.3;

import "hardhat/console.sol";

contract Token {
  string public name = "Watermelon Game Token";
  string public symbol = "WAT";
  uint public totalSupply = 100000000;
  address public owner;
  mapping(address => uint) balances;

  constructor() {
    balances[msg.sender] = totalSupply;
    owner = msg.sender;
  }

  function transfer(address to, uint amount) external {
    require(balances[msg.sender] >= amount, "Not enough tokens");
    balances[msg.sender] -= amount;
    balances[to] += amount;
  }

  function balanceOf(address account) external view returns (uint) {
    return balances[account];
  }
}