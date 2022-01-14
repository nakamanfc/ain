// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "../Essential/Essential_Event.sol";
import "../Essential/Essential_Encode.sol";
import "../Essential/Essential_Constant.sol";
import "../Stake/Stake_Staking.sol";

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract GenesisFactory is Event, Encode, Constant{
    
    struct Genesis {
        uint        ID;
        string      CompanyName;
        string      ProductName;
        string      Image;
        string      Code;
        uint32      Weight;
        uint32      Timestamp;
        address     ManagerAddress;
        address     GenesisAddress;
    }
   
    StakePool                   private _Stake = StakePool(StakeContractAddress);
    Genesis[]                   public GenesisList;
    mapping(address => Genesis) public AddressToGenesis;
    
    function CreateGenesis(
        string memory CompanyName,
        string memory ProductName,
        string memory Image,
        string memory Code,
        uint32        Weight
    ) 
    external
    {
        require(_Stake.StakeForFunction("Genesis",msg.sender) == true);
        address GenesisAddress = CreateAddress(ProductName, Image,  uint32(block.timestamp), msg.sender, GenesisList.length);
        Genesis memory NewGenesis = Genesis(GenesisList.length, CompanyName, ProductName, Image, Code, Weight,  uint32(block.timestamp), msg.sender, GenesisAddress);
        GenesisList.push(NewGenesis);
        AddressToGenesis[GenesisAddress] = NewGenesis;
        emit NewEvent(msg.sender,GenesisAddress);
    }
}