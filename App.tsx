import React, { useEffect, useState } from 'react';
import { View } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { StatusBar } from 'expo-status-bar';
import { useFonts } from 'expo-font';
import { Asset } from 'expo-asset';
import { RootNavigator } from './src/navigation/RootNavigator';
import { useStore } from './src/state/store';
import { useColors, useIsDark } from './src/theme/useColors';
import { allImages } from './src/assets/images';

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

  // 화면 전환 시 사진이 뜨는 지연을 없애기 위해 시작 시 전체 이미지를 미리 캐싱한다.
  const [imagesLoaded, setImagesLoaded] = useState(false);
  useEffect(() => {
    loadPersisted();
    Asset.loadAsync(allImages)
      .catch(() => {})
      .finally(() => setImagesLoaded(true));
  }, []);

  if (!fontsLoaded || !imagesLoaded) return null;

  return (
    <SafeAreaProvider>
      <Root />
    </SafeAreaProvider>
  );
}
