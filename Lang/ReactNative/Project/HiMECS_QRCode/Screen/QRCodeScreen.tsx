import React, { useState } from 'react';
import { View, Text } from 'react-native';
import QRCodeReader from './QRCodeReader';

const App = () => {
  const [qrCodeData, setQRCodeData] = useState('');

  const handleQRCodeRead = (data: string) => {
    setQRCodeData(data);
  };

  return (
    <View style={{ flex: 1 }}>
      {qrCodeData ? (
        <Text>{qrCodeData}</Text>
      ) : (
        <QRCodeReader onRead={handleQRCodeRead} />
      )}
    </View>
  );
};

export default App;
