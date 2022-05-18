//SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NFT1155 is ERC1155 {
    string public baseUri = "https://gateway.pinata.cloud/ipfs/QmTegVT2RPB2yx7tfvF48yrCrsEuhB32kZN67PYdo6AAuR/";
    address public owner;
    mapping(uint256 => bool) idList;

    constructor () ERC1155(baseUri) {
        owner = msg.sender;
    }

    function batchMint (uint256[] memory _ids, uint256[] memory _amounts) public checkLength(_ids, _amounts) {
        _mintBatch(msg.sender, _ids, _amounts, "");

        for(uint256 i = 0; i < _ids.length; i++){
            idList[_ids[i]] = true;
        }
    }

    function checkMintStatus (uint256 _id) public view returns (bool ){
        return idList[_id];
    }

    function getUri (uint256 _id) public view returns (string memory){
        return string(
            abi.encodePacked(
                baseUri,
                Strings.toString(_id),
                ".json"
            )
        );
    }

    modifier checkLength (uint256[] memory _ids, uint256[] memory _amounts){
        require(_ids.length == _amounts.length, "Data Length Don't Match");
        _;
    }
   
}