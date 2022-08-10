import { useRouter } from 'next/router';
import React from 'react';
import Button from './Button';

const ButtonGroup = ({ setActive, setIsOpen }) => {
  const router = useRouter();

  const isConnected = true;

  return isConnected ? (
    <Button
      btnName="Create"
      classStyles="mx-2 rounded-xl"
      handleClick={() => {
        setActive('');
        setIsOpen(false);
        router.push('/create-nft');
      }}
    />
  ) : (
    <Button
      btnName="Connect"
      classStyles="mx-2 rounded-xl"
      handleClick={() => {}}
    />
  );
};

export default ButtonGroup;
