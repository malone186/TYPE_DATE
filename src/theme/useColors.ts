import { useColorScheme } from 'react-native';
import { useStore } from '../state/store';
import { darkTokens, lightTokens, TypeDateTokens } from './colors';

// Flutter `context.colors` + themeMode(light/dark/system) 해석 이식.
export function useIsDark(): boolean {
  const mode = useStore((s) => s.themeMode);
  const system = useColorScheme();
  if (mode === 'light') return false;
  if (mode === 'dark') return true;
  return system === 'dark';
}

export function useColors(): TypeDateTokens {
  return useIsDark() ? darkTokens : lightTokens;
}
