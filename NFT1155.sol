//SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract NFT1155 is ERC1155 {
    address public owner;

    constructor () ERC1155("") {
        owner = msg.sender;
    }

    function batchMint (uint256[] memory _ids, uint256[] memory _amounts) public checkLength(_ids, _amounts) {
        _mintBatch(msg.sender, _ids, _amounts, "");
    }

    modifier checkLength (uint256[] memory _ids, uint256[] memory _amounts){
        require(_ids.length == _amounts.length, "Data Length Don't Match");
        _;
    }
   
}