// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "../Factory/Factory_Transport.sol";

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract TransportSearch is TransportFactory{
    function SearchTransportByAddress(
        address Address
    )
    public
    view
    returns(Transport memory)
    {
        return AddressToTransport[Address];
    }
    
    function SearchTransportByManagerAddress(
        address TransporterAddress
    )
    public
    view
    returns(uint[] memory)
    {
        uint TransportAmount = TransportList.length;
        uint ManagerTransportAmount = 0;
        uint Count = 0;
        
        for(uint i = 0; i < TransportAmount; i++){
            if(TransportList[i].TransporterAddress == TransporterAddress){
                ManagerTransportAmount++;
            }
        }
        
        uint[] memory result = new uint[](ManagerTransportAmount);
        
        for(uint i = 0; i < TransportAmount; i++){
            if(TransportList[i].TransporterAddress == TransporterAddress){
                result[Count] = i;
                Count++;
            }
        }
        
        return result;
    }
    
    function SearchTransportByMerchandiseAddress(
        address MerchandiseAddress
    )
    public
    view
    returns(uint[] memory)
    {
        uint TransportAmount = TransportList.length;
        uint MerchandiseAmount = 0;
        uint Count = 0;
        
        for(uint i = 0; i < TransportAmount; i++){
            if(TransportList[i].MerchandiseAddress == MerchandiseAddress){
                MerchandiseAmount++;
            }
        }
        
        uint[] memory result = new uint[](MerchandiseAmount);
        
        for(uint i = 0; i < TransportAmount; i++){
            if(TransportList[i].MerchandiseAddress == MerchandiseAddress){
                result[Count] = i;
                Count++;
            }
        }
        
        return result;
    }
    
    function SearchTransportByID(
        uint ID
    )
    public
    view
    returns(Transport memory)
    {
        return TransportList[ID];
    }
}