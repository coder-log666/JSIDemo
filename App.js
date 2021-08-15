/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */
import React from 'react';
import type {Node} from 'react';
import {Text, View, Button} from 'react-native';

const App: () => Node = () => {
  const [result, setResult] = React.useState();

  global.jsMethod = () => {
    alert('hello jsMethod');
  };

  global.jsMultiply = (x, y) => {
    alert('x * y = ' + x * y);
  };

  const press = () => {
    // setResult(global.multiply(2, 2));
    global.multiplyWithCallback(4, 5, alertResult);
  };

  const alertResult = res => {
    alert(res);
  };

  return (
    // eslint-disable-next-line react-native/no-inline-styles
    <View style={{backgroundColor: '#FFFFFF', height: '100%'}}>
      <View style={{height: '10%'}} />
      <Button onPress={press} title="按钮" />
      <Text>{'2*2 = ' + result}</Text>
    </View>
  );
};

export default App;
