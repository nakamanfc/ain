// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "../Factory/Factory_Genesis.sol";

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract GenesisSearch is GenesisFactory{
    function SearchGenesisByAddress(
        address Address
    )
    public
    view
    returns(Genesis memory)
    {
        return AddressToGenesis[Address];
    }
    
    function SearchGenesisByManagerAddress(
        address ManagerAddress
    )
    public
    view
    returns(uint[] memory)
    {
        uint GenesisAmount = GenesisList.length;
        uint ManagerGenesisAmount = 0;
        uint Count = 0;
        
        for(uint i = 0; i < GenesisAmount; i++){
            if(GenesisList[i].ManagerAddress == ManagerAddress){
                ManagerGenesisAmount++;
            }
        }
        
        uint[] memory result = new uint[](ManagerGenesisAmount);
        
        for(uint i = 0; i < GenesisAmount; i++){
            if(GenesisList[i].ManagerAddress == ManagerAddress){
                result[Count] = i;
                Count++;
            }
        }
        
        return result;
    }
    
    function SearchGenesisByID(
        uint ID
    )
    public
    view
    returns(Genesis memory)
    {
        return GenesisList[ID];
    }
}