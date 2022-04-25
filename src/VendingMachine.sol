// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;
import "openzeppelin-contracts/contracts/access/Ownable.sol";



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

contract VendingMachine is Ownable {
    mapping(string => Slot) shelve;
    mapping (address => uint256) balances;

    event LogDeposit(address accAddress, uint amount);
    event stockShelve(uint amount, string name);

    constructor() {
        
        /// @notice i tried to do this by creating a nested for loop, but i think this is more gas efficient...
        shelve['a1'] = new Slot();
        shelve['a2'] = new Slot();
        shelve['a3'] = new Slot();
        shelve['a4'] = new Slot();
        shelve['b1'] = new Slot();
        shelve['b2'] = new Slot();
        shelve['b3'] = new Slot();
        shelve['b4'] = new Slot();
        shelve['c1'] = new Slot();
        shelve['c2'] = new Slot();
        shelve['c3'] = new Slot();
        shelve['c4'] = new Slot();
        shelve['d1'] = new Slot();
        shelve['d2'] = new Slot();
        shelve['d3'] = new Slot();
        shelve['d4'] = new Slot();


    }

    function Deposit(uint _amount) public payable returns (uint){
        require((balances[msg.sender] + msg.value) >= balances[msg.sender]);
        balances[msg.sender] += msg.value;
        emit LogDeposit(msg.sender, _amount);
        return balances[msg.sender];
    }

    function stockSlot(string memory _slotId, Item [] memory _products) public OnlyOwner returns(uint256) {
        // shelve[_slotId].insertProduct();
        require(_products.lenght > 0, "List of Items can not be empty");

        for (i = 0; i < shelve[_slotId].size; i ++) {
            shelve[_slotId].insertProduct(_products[i].name,_products[i].price);
        }
        emit stockShelve(_products.lenght, _products[0].name);
        return shelve[_slotId].size;

    }

    /// todo create Buy item function

}