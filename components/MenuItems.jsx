import Link from 'next/link';

const linkItems = ['Explore NFTs', 'Listed NFTs', 'My NFTs'];

const MenuItems = ({ isMobile, active, setActive }) => {
  const generatLink = (i) => {
    switch (i) {
      case 0:
        return '/';
      case 1:
        return '/created-nfts';
      case 2:
        return '/my-nfts';
      default:
        return '/';
    }
  };

  return (
    <ul className={`list-none flexCenter flex-grow ${isMobile && 'flex-col h-full'}`}>
      {linkItems.map((item, i) => (
        <li key={i} onClick={() => { setActive(item); }} className={`flex flex-row items-center font-poppins font-semibold text-base dark:hover:text-white hover:text-nft-dark mx-3 ${active === item ? 'dark:text-white text-black' : 'dark:text-nft-gray-3 text-nft-gray-2}'}`}>
          <Link href={generatLink(i)}>{item}</Link>
        </li>
      ))}
    </ul>
  );
};

export default MenuItems;
