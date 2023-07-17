// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {VaultFactory} from "../src/levels/08-VaultFactory.sol";
import {Vault} from "../src/levels/08-Vault.sol";

contract VaultSolution is BaseTest {

    function solution(address payable target_) override internal {
        Vault target = Vault(target_);
        bytes32 password = vm.load(address(target), bytes32(uint256(1)));
        target.unlock(password);
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new VaultFactory()));
    }
}
