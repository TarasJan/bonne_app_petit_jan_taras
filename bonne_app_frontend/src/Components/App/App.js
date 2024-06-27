import './App.css';
import { PrimeReactProvider } from 'primereact/api';

import Header from '../Header/Header';
import { Divider } from 'primereact/divider';
import Footer from '../Footer/Footer';
import FoodFinder from '../FoodFinder/FoodFinder';

function App() {
  return (
    <PrimeReactProvider>
      <div className="App">
        <Header/>
        <Divider />
        <FoodFinder/>
        <Footer />
      </div>
    </PrimeReactProvider>
  );
}

export default App;
