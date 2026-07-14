import React, { useState } from 'react';
import { Image, Text, View } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { NativeStackScreenProps } from '@react-navigation/native-stack';
import { RootStackParamList } from '../navigation/types';
import { useColors } from '../theme/useColors';
import { TypeDateTextStyles } from '../theme/textStyles';
import { GlowBackground, GlassPanel, ThemeToggleButton, CoralButton } from '../widgets/common';
import { KakaoChatView } from '../widgets/KakaoChatView';
import { prologueLines, episode1 } from '../data';
import { logoImage } from '../assets/images';

// Flutter screens/prologue_screen.dart 이식.
// Scene 1(민준) → Scene 2(온보딩) → Scene 3(배정 카드)
type Step = 'minjun' | 'onboarding' | 'assignment';

export function PrologueScreen({ navigation }: NativeStackScreenProps<RootStackParamList, 'Prologue'>) {
  const [step, setStep] = useState<Step>('minjun');

  const goToProfile = () => {
    // Flutter: 프로필(지수)을 띄우고 프롤로그를 목록 화면으로 바꿔치기.
    // RN: 스택을 [CharacterSelect, CharacterProfile(지수)]로 리셋해 뒤로가기 시 목록으로.
    navigation.reset({
      index: 1,
      routes: [
        { name: 'CharacterSelect' },
        { name: 'CharacterProfile', params: { characterId: episode1.character.id } },
      ],
    });
  };

  if (step === 'minjun') {
    return (
      <KakaoChatView
        contactName="최민준"
        lines={prologueLines}
        showStatusBar
        completeButtonLabel="다음"
        onComplete={() => setStep('onboarding')}
      />
    );
  }
  if (step === 'onboarding') {
    return <OnboardingScene onNext={() => setStep('assignment')} />;
  }
  return <AssignmentScene onNext={goToProfile} />;
}

function OnboardingScene({ onNext }: { onNext: () => void }) {
  const c = useColors();
  return (
    <GlowBackground>
      <SafeAreaView style={{ flex: 1 }}>
        <View style={{ flex: 1, paddingHorizontal: 32 }}>
          <View style={{ alignSelf: 'flex-end' }}>
            <ThemeToggleButton />
          </View>
          <View style={{ flex: 2 }} />
          <Image source={logoImage} style={{ width: 100, height: 100, alignSelf: 'center' }} resizeMode="contain" />
          <View style={{ height: 32 }} />
          <Text style={[TypeDateTextStyles.screenTitle(c.textPrimary), { textAlign: 'center' }]}>
            "당신의 진짜 인연을 찾아드립니다"
          </Text>
          <View style={{ height: 16 }} />
          <Text style={[TypeDateTextStyles.chatMessage(c.textSecondary), { textAlign: 'center' }]}>
            16가지 유형의 상대를 만나보세요.{'\n'}16번의 만남이 끝날 때,{'\n'}당신이 진짜 설레는 인연 유형이 밝혀집니다.
          </Text>
          <View style={{ height: 28 }} />
          <Text style={[TypeDateTextStyles.monologue(c.textMuted), { textAlign: 'center' }]}>
            ...혹시 진짜 있긴 한 건가.
          </Text>
          <View style={{ flex: 3 }} />
          <CoralButton label="시작하기" onPress={onNext} />
          <View style={{ height: 32 }} />
        </View>
      </SafeAreaView>
    </GlowBackground>
  );
}

function AssignmentScene({ onNext }: { onNext: () => void }) {
  const c = useColors();
  return (
    <GlowBackground>
      <SafeAreaView style={{ flex: 1 }}>
        <View style={{ flex: 1, padding: 24, justifyContent: 'center' }}>
          <View style={{ alignSelf: 'flex-end' }}>
            <ThemeToggleButton />
          </View>
          <GlassPanel style={{ width: '100%' }}>
            <View>
              <View style={{ flexDirection: 'row', alignItems: 'center' }}>
                <Text style={{ fontSize: 22 }}>💘</Text>
                <View style={{ width: 8 }} />
                <Text style={TypeDateTextStyles.screenTitle(c.textPrimary)}>첫 번째 인연</Text>
              </View>
              <View style={{ height: 20 }} />
              <InfoRow label="상대" value="지수 (26세)" />
              <InfoRow label="직업" value="콘텐츠 기획자" />
              <InfoRow label="장소" value="홍대 카페" />
              <InfoRow label="시간" value="오늘 오후 2시" />
              <View style={{ height: 16 }} />
              <Text style={TypeDateTextStyles.chatMessage(c.textSecondary)}>
                "이 사람이 당신의 인연일까요?"
              </Text>
            </View>
          </GlassPanel>
          <View style={{ height: 16 }} />
          <Text style={[TypeDateTextStyles.monologue(c.textMuted), { textAlign: 'center' }]}>
            ...뭐, 한번 보긴 해야겠지.
          </Text>
          <View style={{ height: 32 }} />
          <CoralButton label="소개팅 출발하기" onPress={onNext} />
        </View>
      </SafeAreaView>
    </GlowBackground>
  );
}

function InfoRow({ label, value }: { label: string; value: string }) {
  const c = useColors();
  return (
    <View style={{ flexDirection: 'row', paddingVertical: 4 }}>
      <View style={{ width: 48 }}>
        <Text style={TypeDateTextStyles.caption(c.textMuted)}>{label}</Text>
      </View>
      <Text style={TypeDateTextStyles.chatMessage(c.textPrimary)}>{value}</Text>
    </View>
  );
}
