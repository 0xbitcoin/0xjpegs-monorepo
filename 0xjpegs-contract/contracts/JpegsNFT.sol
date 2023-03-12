// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

  
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
  
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

import {IMintableNFT} from "./interfaces/IMintableNFT.sol";

import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";
 
 

/*

  ______               _____  _______   ________   ______            
 /      \             |     \|       \ |        \ /      \           
|  $$$$$$\ __    __    \$$$$$| $$$$$$$\| $$$$$$$$|  $$$$$$\  _______ 
| $$$\| $$|  \  /  \     | $$| $$__/ $$| $$__    | $$ __\$$ /       \
| $$$$\ $$ \$$\/  $$__   | $$| $$    $$| $$  \   | $$|    \|  $$$$$$$
| $$\$$\$$  >$$  $$|  \  | $$| $$$$$$$ | $$$$$   | $$ \$$$$ \$$    \ 
| $$_\$$$$ /  $$$$\| $$__| $$| $$      | $$_____ | $$__| $$ _\$$$$$$\
 \$$  \$$$|  $$ \$$\\$$    $$| $$      | $$     \ \$$    $$|       $$
  \$$$$$$  \$$   \$$ \$$$$$$  \$$       \$$$$$$$$  \$$$$$$  \$$$$$$$ 
                                                                     

*/



contract JpegsNFT is ERC721,Ownable,IMintableNFT {
    
    address public minter;

    string public baseUri; 
    mapping(uint256 => string) public uriExtensions;

    uint256 public mintedTokenCount;  
   


    event SetMinter(address minter);
 
    modifier onlyMinter() {
        require(msg.sender == minter, "caller is not the minter.");
        _;
    }


    constructor() ERC721("0xJPEGs", "JPG") Ownable() {}
 

    /**
        This returns true if and only if the next incremental
        tokenId has registered+valid metadata such that the mint()
        method will mint a valid token. 
    */
    function hasMintableNft() public view returns (bool) {
 
        string memory ext = uriExtensions[mintedTokenCount];

        return bytes(ext).length > 0 ;

    }


    function mint(address to)  public onlyMinter  returns (uint256 tokenId) {
        
        require(hasMintableNft(),"There is not an nft available to mint.");

        tokenId = mintedTokenCount++;

        _mint(to, tokenId);
    
        return tokenId;
    }

    function setMinter(address _minter) public onlyOwner {

        minter = _minter;

        emit SetMinter(_minter);
    }


    /**
    example "https://arweave.net/"
    */

    function registerBaseUri( string calldata _baseUri ) public onlyOwner {

        baseUri = _baseUri;
    }


    /**
    example Sk3zkABKYGIdk....exIhVz9jrPCfKeer3I
    */
    function registerUriExtension( uint256 _tokenId, string calldata _ext) public onlyOwner {

        uriExtensions[_tokenId] = _ext; 
    }



    function _baseURI() internal view override returns (string memory) {
        return baseUri;
    }

 

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireMinted(tokenId);

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, uriExtensions[tokenId])) : "";
    }

    
    function supportsInterface(bytes4 interfaceId) public override pure returns (bool){
    
          return interfaceId == 0x7f5828d0 || //supportsInterface.
            interfaceId == 0x7f5828d0 || // owner().
            interfaceId == 0x80ac58cd || // ERC721.
            interfaceId == 0x5b5e139f; // ERC721Metadata.

    }

    



}
