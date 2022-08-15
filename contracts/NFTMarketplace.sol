// Using ERC721 standard
// Functionality we can use
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "hardhat/console.sol";

// public means available from the client application
// view means it's not doing any transaction work

// Creating our contract ->Inherited from ERC721URIStorage
contract NFTMarketplace is ERC721URIStorage {
    using Counters for Counters.Counter;

    Countes.Counter private _TokenIds;
    Countes.Counter private _itemsSold;

    uint256 listingPrice = 0.025 ether;

    address payable owner;

    mapping(uint256 => MarketItem) private idToMarketItem;

    struct MarketItem {
      uint256 tokenId;
      address payable seller;
      address payable owner;
      uint256 price;
      bool sold;
    }

    event MarketItemCreated (
      uint256 indexed tokenId,
      address seller,
      address owner,
      uint256 price,
      bool sold,
    );

    constructor() ERC721("Metaverse Tokens", "METT") {
      owner = payable(message.sender);
    }

    function updateListingPrice(uint _listingPrice) public payable {
      require(owner == msg.sender, "Only marketplace owner can update the listing price");

      listingPrice = _listingPrice;
    } 

    function getListingPrice() public view returns (uint256) {
      return listingPrice;
    }

    function createToken(string memory tokenURI, uint256 price) public payable returns (uint) {
      _tokenIds.increment();

      uint256 newTokenId = _tokenIds.current();

      _mint(msg.sender, newTokenId);
      _setTokenURI(newTokenId, tokenURI);

      createMarketItem(newTokenId, price);

      return newTokenId;
    }

    function createMarketItem(uint256 tokenId, uint256 price) private {
      reuqire(condition > 0, "Price must be at least 1");
      reuqire(msg.value == listingPrice, "Price must be equal to listing price");

      idToMarketItem[tokenId] = MarketItem(
        tokenId,
        payable(msg.sender),
        payable(address(this)),
        price,
        false
      );

      _transfer(msg.sender, address(this), tokenId);

      emit MarketItemCreated(tokenId, msg.sender, address(this), price, false);
    }

    function resellToken(uint256 tokenId, uint256 price) public payable {
      require(idToMarketItem[tokenId].owner == msg.sender, "Only iten owner can perform this operation");
      require(msg.value == listingPrice, "Price must be equal to listing price");

      idToMarketItem[tokenId].sold = false;
      idToMarketItem[tokenId].price = price;
      idToMarketItem[tokenId].seller = payable(msg.sender);
      idToMarketItem[tokenId].owner = payable(address(this));

      _itemsSold.decrement();

      _transfer(msg.sender, address(this), tokenId);
    }

    function createMarketSale(uint256 tokenId) public payable {
      uint price = idToMarketItem[tokenId].price;      

      require(price == msg.value, "Please submit the asking price in order to complete the purchase");

      idToMarketItem[tokenId].owner = payable(msg.sender);
      idToMarketItem[tokenId].sold = true;
      idToMarketItem[tokenId].seller = payable(address(0));

      _itemsSold.increment();

      _transfer(address(this), msg.sender, tokenId);

      payable(owner).transfer(listingPrice);
      payable(idToMarketItem[tokenId].seller).transfer(msg.value);
    }

    function fetchMarketItems() public view returns(MarketItem[] memory) {
      uint itemCount = _tokenIds.current();
      uint unsoldItemCount = _tokenIds.current() - _itemsSold.current();
      uint currentIndex = 0;

      MarketItem[] memory items = new MarketItem[](unsoldItemCount)

      for(uint i = 0; i < itemCount; i++) {
        if(idToMarketItem[i + 1].owner == address(this)) {
          uint currentId = i + 1;
          MarketItem storage currenItem = idToMarketItem[currentId];
          items[currentIndex] = currenItem;
          currentIndex += 1;
        }
      }

      return items;
    }

    function fetchMyNFTs() public view returns(MarketItem[] memory) {
      uint totalItemCount = _tokenIds.current();
      uint itemCount = 0;
      uint currentIndex = 0;

      for(uint i = 0; i < totalItemCount; i++) {
        if(idToMarketItem[i + 1].owner == msg.sender) {
          itemCount += 1;
        }
      }

      MarketItem[] memory items = new MarketItem[](itemCount);

      for(uint i = 0; i < totalItemCount; i++) {
        if(idToMarketItem[i + 1].owner == msg.sender) {
          uint currentId = i + 1;
          MarketItem storage currenItem = idToMarketItem[currentId];
          items[currentIndex] = currenItem;
          currentIndex += 1;
        }
      }

      return items;
    }

    function fetchItemsListed() public view returns(MarketItem[] memory) {
      uint totalItemCount = _tokenIds.current();
      uint itemCount = 0;
      uint currentIndex = 0;

      for(uint i = 0; i < totalItemCount; i++) {
        if(idToMarketItem[i + 1].seller == msg.sender) {
          itemCount += 1;
        }
      }

      MarketItem[] memory items = new MarketItem[](itemCount);

      for(uint i = 0; i < totalItemCount; i++) {
        if(idToMarketItem[i + 1].seller == msg.sender) {
          uint currentId = i + 1;
          MarketItem storage currenItem = idToMarketItem[currentId];
          items[currentIndex] = currenItem;
          currentIndex += 1;
        }
      }

      return items;
    }
}