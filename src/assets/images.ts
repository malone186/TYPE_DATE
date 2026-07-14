import { ImageSourcePropType } from 'react-native';

// RN은 정적 require만 허용하므로, Flutter의 asset 경로 문자열을 모듈로 매핑한다.
// 캐릭터 데이터의 imagePath/facePath 문자열이 이 맵의 키로 그대로 쓰인다.
const registry: Record<string, ImageSourcePropType> = {
  'assets/images/jisu.png': require('../../assets/images/jisu.png'),
  'assets/images/jisu_face.png': require('../../assets/images/jisu_face.png'),
  'assets/images/seoyun.png': require('../../assets/images/seoyun.png'),
  'assets/images/seoyun_face.png': require('../../assets/images/seoyun_face.png'),
  'assets/images/harin.png': require('../../assets/images/harin.png'),
  'assets/images/harin_face.png': require('../../assets/images/harin_face.png'),
  'assets/images/yujin.png': require('../../assets/images/yujin.png'),
  'assets/images/yujin_face.png': require('../../assets/images/yujin_face.png'),
  'assets/images/logo.png': require('../../assets/images/logo.png'),
  'assets/images/logo_mark.png': require('../../assets/images/logo_mark.png'),
  'assets/images/background.png': require('../../assets/images/background.png'),
};

export function imageSource(path?: string | null): ImageSourcePropType | undefined {
  if (!path) return undefined;
  return registry[path];
}

export const logoImage = registry['assets/images/logo.png'];
export const logoMarkImage = registry['assets/images/logo_mark.png'];
export const backgroundImage = registry['assets/images/background.png'];
