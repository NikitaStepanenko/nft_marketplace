import { ThemeProvider } from 'next-themes';
import Script from 'next/script';

import { Footer, Navbar } from '../components';
import { NFTProvider } from '../context/NFTContext';

import '../styles/globals.css';

const MyApp = ({ Component, pageProps }) => (
  <NFTProvider>
    <ThemeProvider attribute="class" enableSystem={false}>
      <div className="dark:bg-nft-dark bg-white min-h-screen">
        <Navbar />
        <div className="pt-65">
          <Component {...pageProps} />
        </div>
        <Footer />
        <Script src="https://kit.fontawesome.com/8a40a6fca5.js" crossOrigin="anonymous" />
      </div>
    </ThemeProvider>
  </NFTProvider>
);

export default MyApp;
