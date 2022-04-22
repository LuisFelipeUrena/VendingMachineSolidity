// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;




    /// @notice This Item Struct is used to hold price and name of a product
    /// @dev this struct is defined to make sure only Item data type go into the queue
    /// @return Documents this should return nothing
    /// @inheritdoc	Copies all missing tags from the base function (must be followed by the contract name)
    struct Item {
        string name;
        uint256 price;
    }

contract Slot {
    
    
    /// @notice these variables are tied to each slot.
    uint256 price;
    Item [] public queue;
    uint256 max_items = 15;
    // Item [] public queue = new Item[](max_items);
    uint256 size = queue.length;
    string productName;
    

    /// @notice this checks if the queue reached it's limit
    /// @dev None
    /// @return Documents returns a bool
    function isFull() public view returns(bool) {
        return size == max_items;
    }
    /// @notice same as the function above, made it this way for readability
    function isEmpty() public view returns(bool) {
        return size == 0;
    }

    /// @notice This inserts one Item to the queue
    /// @dev it requires that the queue is not full
    /// @param  _name string as name of the product
    /// @param  _price uint to represent the price in uint type
    function insertProduct(string memory _name, uint _price) public {
        require(isFull() == false,"Slot is full!");
        if (isEmpty() == true) {
            productName = _name;  
        } 
        queue.push(Item(_name, _price));
    }

    function removeProduct() public {
        require(isEmpty() == false, "Nothing to remove");
        queue.pop();
    }


}

/// @title Main implementation of a Vending Machine functionality
/// @author Github: LuisFelipeUrena
/// @notice It enables the user to buy an item from this vending machine, it will add NFT functionality when deployed
/// @dev Nothing to add for now :)

contract VendingMachine {

    // Item agua = Item('Fiji water', 12);
    mapping(string => Slot) shelve;

    constructor() {
        // this should've been done with a for loop but the gas efficiency if this contract was deployed
        // would be poor, it would be a little bit too expensive to run a double for loop in a constructor

        uint public money = 0;
    }

}