import { useRouter } from 'next/router';
import React, { useContext } from 'react';
import { NFTContext } from '../context/NFTContext';
import Button from './Button';

const ButtonGroup = ({ setActive }) => {
  const { connectWallet, currentAccount } = useContext(NFTContext);

  const router = useRouter();

  return currentAccount ? (
    <Button
      btnName="Create"
      classStyles="mx-2 rounded-xl"
      handleClick={() => {
        setActive('');
        router.push('/create-nft');
      }}
    />
  ) : (
    <Button
      btnName="Connect"
      classStyles="mx-2 rounded-xl"
      handleClick={() => connectWallet()}
    />
  );
};

export default ButtonGroup;
