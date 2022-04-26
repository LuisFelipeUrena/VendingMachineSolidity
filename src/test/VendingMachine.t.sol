// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.10;
import 'ds-test/test.sol';
import '../VendingMachine.sol';

contract VendingMachineTest is DSTest{
    Slot public TSlot;

    function setup() public {
        TSlot = new Slot();  
    }

    function test_insert_item() public {
        string memory name_ = 'Soda';
        uint price_ = 22;
        bool InsertPass = TSlot.insertProduct(name_, price_);
        assertTrue(InsertPass);
    }


}




