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
contract MerchandiseFactory is Event, Encode, Constant{
    struct Merchandise {
        uint        ID;
        string      CompanyName;
        string      ProductName;
        string      Image;
        string      Code;
        uint32      Weight;
        uint32      Timestamp;
        address     ManagerAddress;
        address     MerchandiseAddress;
        address     PrevProcessAddress;
    }

    StakePool                       private _Stake = StakePool(StakeContractAddress);
    Merchandise[]                   public MerchandiseList;
    mapping(address => Merchandise) public AddressToMerchandise;
    
    function CreateMerchandise(
        string memory CompanyName,
        string memory ProductName,
        string memory Image,
        string memory Code,
        uint32        Weight,
        address       PrevProcessAddress
    ) 
    public
    {
        require(_Stake.StakeForFunction("Merchandise",msg.sender) == true);
        address MerchandiseAddress = CreateAddress(ProductName, Image, uint32(block.timestamp), msg.sender, MerchandiseList.length);
        Merchandise memory NewMerchandise = Merchandise(MerchandiseList.length, CompanyName, ProductName, Image, Code, Weight, uint32(block.timestamp), msg.sender, MerchandiseAddress, PrevProcessAddress);
        MerchandiseList.push(NewMerchandise);
        AddressToMerchandise[MerchandiseAddress] = NewMerchandise;
        emit NewEvent(msg.sender, MerchandiseAddress);
    }
}