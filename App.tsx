import React, { useEffect } from 'react';
import { View } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { StatusBar } from 'expo-status-bar';
import { useFonts } from 'expo-font';
import { RootNavigator } from './src/navigation/RootNavigator';
import { useStore } from './src/state/store';
import { useColors, useIsDark } from './src/theme/useColors';

function Root() {
  const c = useColors();
  const isDark = useIsDark();
  return (
    <View style={{ flex: 1, backgroundColor: c.bg }}>
      <StatusBar style={isDark ? 'light' : 'dark'} />
      <NavigationContainer>
        <RootNavigator />
      </NavigationContainer>
    </View>
  );
}

export default function App() {
  const loadPersisted = useStore((s) => s.loadPersisted);
  const [fontsLoaded] = useFonts({
    'Pretendard-Regular': require('./assets/fonts/Pretendard-Regular.ttf'),
    'Pretendard-Medium': require('./assets/fonts/Pretendard-Medium.ttf'),
    'Pretendard-SemiBold': require('./assets/fonts/Pretendard-SemiBold.ttf'),
    'Pretendard-Bold': require('./assets/fonts/Pretendard-Bold.ttf'),
  });

  useEffect(() => {
    loadPersisted();
  }, []);

  if (!fontsLoaded) return null;

  return (
    <SafeAreaProvider>
      <Root />
    </SafeAreaProvider>
  );
}
