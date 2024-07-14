// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Identity {
    struct User {
        string name;
        string email;
        string did;
    }

    mapping(address => User) public users;
    mapping(string => address) public didToAddress;

    event UserRegistered(address userAddress, string did);

    function register(string memory _name, string memory _email, string memory _did) public {
        require(bytes(users[msg.sender].name).length == 0, "User already registered");
        require(didToAddress[_did] == address(0), "DID already registered");
        users[msg.sender] = User(_name, _email, _did);
        didToAddress[_did] = msg.sender;
        emit UserRegistered(msg.sender, _did);
    }

    function getUser(address _userAddress) public view returns (string memory name, string memory email, string memory did) {
        User memory user = users[_userAddress];
        return (user.name, user.email, user.did);
    }

    function getUserByDID(string memory _did) public view returns (address userAddress, string memory name, string memory email, string memory did) {
        address userAddr = didToAddress[_did];
        User memory user = users[userAddr];
        return (userAddr, user.name, user.email, user.did);
    }
}
