import Image from 'next/image';
import React from 'react';
import images from '../assets';
import ButtonGroup from './ButtonGroup';
import MenuItems from './MenuItems';

const Hamburger = ({ isOpen, setIsOpen, theme, active, setActive }) => (
  <div className="hidden md:flex ml-2">
    {isOpen ? (
      <Image
        src={images.cross}
        objectFit="contain"
        width={20}
        height={20}
        alt="cross"
        onClick={() => setIsOpen(false)}
        className={theme === 'light' ? 'filter invert' : ''}
      />
    ) : (
      <Image
        src={images.menu}
        objectFit="contain"
        width={25}
        height={25}
        alt="menu"
        onClick={() => setIsOpen(true)}
        className={theme === 'light' ? 'filter invert' : ''}
      />
    )}

    {isOpen && (
      <div className="fixed inset-0 top-65 dark:bg-nft-dark bg-white z-10 nav-h flex justify-between flex-col">
        <div className="flex-1 p-4">
          <MenuItems active={active} setActive={setActive} isMobile setIsOpen={setIsOpen} />
        </div>
        <div className="p-4 border-t dark:border-nft-black-1 border-nft-gray-1">
          <ButtonGroup setActive={setActive} />
        </div>
      </div>
    )}
  </div>
);

export default Hamburger;
