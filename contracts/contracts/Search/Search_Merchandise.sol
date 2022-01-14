// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "../Factory/Factory_Merchandise.sol";

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract MerchandiseSearch is MerchandiseFactory{
    function SearchMerchandiseByAddress(
        address Address
    )
    public
    view
    returns(Merchandise memory)
    {
        return AddressToMerchandise[Address];
    }
    
    function SearchMerchandiseByManagerAddress(
        address ManagerAddress
    )
    public
    view
    returns(uint[] memory)
    {
        uint MerchandiseAmount = MerchandiseList.length;
        uint ManagerMerchandiseAmount = 0;
        uint Count = 0;
        
        for(uint i = 0; i < MerchandiseAmount; i++){
            if(MerchandiseList[i].ManagerAddress == ManagerAddress){
                ManagerMerchandiseAmount++;
            }
        }
        
        uint[] memory result = new uint[](ManagerMerchandiseAmount);
        
        for(uint i = 0; i < MerchandiseAmount; i++){
            if(MerchandiseList[i].ManagerAddress == ManagerAddress){
                result[Count] = i;
                Count++;
            }
        }
        
        return result;
    }
    
    function SearchMerchandiseByID(
        uint ID
    )
    public
    view
    returns(Merchandise memory)
    {
        return MerchandiseList[ID];
    }
}