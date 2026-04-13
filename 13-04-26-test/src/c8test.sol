// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract VictimTest {

bool internal locked;

modifier nonReentrant() {
    require(!locked, "No reentrancy");
    locked = true;
    _;
    locked = false;
}

  mapping(address => uint256) public balances;

function deposit() public payable {
    balances[msg.sender] += msg.value;
}

function withdraw(uint256 amount) public nonReentrant {
    require(balances[msg.sender] >= amount, "Insufficient balance");

    balances[msg.sender] -= amount;

    (bool success, ) = msg.sender.call{value: amount}("");
    require(success, "Transfer failed");
}

}
