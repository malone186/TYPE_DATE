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
  'assets/images/esfp.png': require('../../assets/images/esfp.png'),
  'assets/images/esfp_face.png': require('../../assets/images/esfp_face.png'),
  'assets/images/INFP.png': require('../../assets/images/INFP.png'),
  'assets/images/INFP_face.png': require('../../assets/images/INFP_face.png'),
  'assets/images/ESTP.png': require('../../assets/images/ESTP.png'),
  'assets/images/ESTP_face.png': require('../../assets/images/ESTP_face.png'),
  'assets/images/ISFJ.png': require('../../assets/images/ISFJ.png'),
  'assets/images/ESFJ.png': require('../../assets/images/ESFJ.png'),
  'assets/images/ESFJ_face.png': require('../../assets/images/ESFJ_face.png'),
  'assets/images/ISFJ_face.png': require('../../assets/images/ISFJ_face.png'),
  'assets/images/ISTP.png': require('../../assets/images/ISTP.png'),
  'assets/images/ISTP_face.png': require('../../assets/images/ISTP_face.png'),
  'assets/images/ESTJ.png': require('../../assets/images/ESTJ.png'),
  'assets/images/ENTP_female.png': require('../../assets/images/ENTP_female.png'),
  'assets/images/ENTP_female_face.png': require('../../assets/images/ENTP_female_face.png'),
  'assets/images/INTP_female.png': require('../../assets/images/INTP_female.png'),
  'assets/images/INTP_female_face.png': require('../../assets/images/INTP_female_face.png'),
  'assets/images/ENFJ_female.png': require('../../assets/images/ENFJ_female.png'),
  'assets/images/ENFJ_female_face.png': require('../../assets/images/ENFJ_female_face.png'),
  'assets/images/ISTJ_female.png': require('../../assets/images/ISTJ_female.png'),
  'assets/images/ISTJ_female_face.png': require('../../assets/images/ISTJ_female_face.png'),
  'assets/images/ESFP_female.png': require('../../assets/images/ESFP_female.png'),
  'assets/images/ESFP_female_face.png': require('../../assets/images/ESFP_female_face.png'),
  'assets/images/INFJ_female.png': require('../../assets/images/INFJ_female.png'),
  'assets/images/INFJ_female_face.png': require('../../assets/images/INFJ_female_face.png'),
  'assets/images/ENTJ_female.png': require('../../assets/images/ENTJ_female.png'),
  'assets/images/ENTJ_female_face.png': require('../../assets/images/ENTJ_female_face.png'),
  'assets/images/ENFP_male.png': require('../../assets/images/ENFP_male.png'),
  'assets/images/INTJ_male.png': require('../../assets/images/INTJ_male.png'),
  'assets/images/ISTP_male.png': require('../../assets/images/ISTP_male.png'),
  'assets/images/ENTJ_male.png': require('../../assets/images/ENTJ_male.png'),
  'assets/images/ENTP_male.png': require('../../assets/images/ENTP_male.png'),
  'assets/images/ESFJ_male.png': require('../../assets/images/ESFJ_male.png'),
  'assets/images/INFP_male.png': require('../../assets/images/INFP_male.png'),
  'assets/images/ISFJ_male.png': require('../../assets/images/ISFJ_male.png'),
  'assets/images/ISFP_male.png': require('../../assets/images/ISFP_male.png'),
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
