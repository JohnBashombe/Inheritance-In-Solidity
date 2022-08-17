// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract ERC20Token {
    string public name;
    mapping(address => uint256) public balances;

    constructor(string memory _name) {
        name = _name;
    }

    function mint() public virtual {
        balances[tx.origin]++;
    }
}

contract MyToken is ERC20Token {
    string public symbol;
    address[] public owners;
    uint256 public ownerCount;

    address owner;

    event success(address addr, uint256 ownersCount);

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "You are not allowed to performed this operation."
        );
        _;
    }

    constructor(string memory _name, string memory _symbol) ERC20Token(_name) {
        symbol = _symbol;
        owner = msg.sender;
    }

    function mint() public override onlyOwner {
        super.mint();
        ownerCount++;
        owners.push(msg.sender);

        emit success(msg.sender, ownerCount);
    }
}
