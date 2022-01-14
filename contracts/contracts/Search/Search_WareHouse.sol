// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "../Factory/Factory_WareHouse.sol";

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract WareHouseSearch is WareHouseFactory{
    function SearchWareHouseByAddress(
        address Address
    )
    public
    view
    returns(WareHouse memory)
    {
        return AddressToWareHouse[Address];
    }
    
    function SearchWareHouseByManagerAddress(
        address ManagerAddress
    )
    public
    view
    returns(uint[] memory)
    {
        uint WareHouseAmount = WareHouseList.length;
        uint ManagerWareHouseAmount = 0;
        uint Count = 0;
        
        for(uint i = 0; i < WareHouseAmount; i++){
            if(WareHouseList[i].ManagerAddress == ManagerAddress){
                ManagerWareHouseAmount++;
            }
        }
        
        uint[] memory result = new uint[](ManagerWareHouseAmount);
        
        for(uint i = 0; i < WareHouseAmount; i++){
            if(WareHouseList[i].ManagerAddress == ManagerAddress){
                result[Count] = i;
                Count++;
            }
        }
        
        return result;
    }
    
    function SearchWareHouseByID(
        uint ID
    )
    public
    view
    returns(WareHouse memory)
    {
        return WareHouseList[ID];
    }
}