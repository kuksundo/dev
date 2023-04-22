import React, { useEffect } from 'react';
import { View, StyleSheet, Text } from 'react-native';
import QRCodeScanner from 'react-native-qrcode-scanner';
import { RNCamera } from 'react-native-camera';

type QRCodeReaderProps = {
  onRead: (data: string) => void;
};

const QRCodeReader: React.FC<QRCodeReaderProps> = ({ onRead }) => {
  const onSuccess = (e: any) => {
    onRead(e.data);
  };

  useEffect(() => {
    return () => {
      // Stop the scanner when unmounting the component
      QRCodeScanner.prototype.stopCamera();
    };
  }, []);

  return (
    <View style={styles.container}>
      <QRCodeScanner
        onRead={onSuccess}
        cameraStyle={styles.camera}
        containerStyle={styles.cameraContainer}
        reactivate={true}
        reactivateTimeout={5000}
        flashMode={RNCamera.Constants.FlashMode.auto}
      />
      <Text style={styles.text}>Scan QR code</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'black',
  },
  cameraContainer: {
    height: '100%',
    width: '100%',
  },
  camera: {
    height: '100%',
    width: '100%',
  },
  text: {
    color: 'white',
    marginTop: 20,
    fontSize: 18,
  },
});

export default QRCodeReader;
