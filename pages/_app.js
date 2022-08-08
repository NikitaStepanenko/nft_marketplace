import { ThemeProvider } from 'next-themes';
import Script from 'next/script';

import { Footer, Navbar } from '../components';

import '../styles/globals.css';

const MyApp = ({ Component, pageProps }) => (
  <ThemeProvider attribute="class" enableSystem={false}>
    <div className="dark:bg-nft-dark bg-white min-h-screen">
      <Navbar />
      <Component {...pageProps} />
      <Footer />
      <Script src="https://kit.fontawesome.com/8a40a6fca5.js" crossOrigin="anonymous" />
    </div>
  </ThemeProvider>
);

export default MyApp;
