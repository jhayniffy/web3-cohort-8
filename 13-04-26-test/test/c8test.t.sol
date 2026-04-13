// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Test} from "forge-std/Test.sol";
import {VictimTest} from "../src/c8test.sol";

contract VictimTest is Test {
    Victim public victim;
ion setUp() public {
        victim = new Victim();
        vm.deal(address(this), 10 ether);
        victim.deposit{value: 1 ether}();
    }

    function testAttackFails() public {
        Attack attacker = new Attack(address(victim));
        vm.deal(address(attacker), 1 ether);
        vm.expectRevert();
        attacker.attack{value: 1 ether}();
        assertEq(victim.balances(address(attacker)), 0);
    }

    receive() external payable {}
}
    