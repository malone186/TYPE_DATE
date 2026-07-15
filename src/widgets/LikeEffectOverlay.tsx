import React, { useEffect, useRef } from 'react';
import { Animated, StyleSheet, View } from 'react-native';
import { MaterialIcons } from '@expo/vector-icons';
import { withAlpha } from '../theme/colors';
import { useColors } from '../theme/useColors';

// Flutter widgets/like_effect.dart 이식.
// 호감도 이펙트 — 점수/숫자 노출 금지, 색과 움직임으로만 전달.

const DISLIKE_GRAY = '#9B9B9B';
const PARTICLE_ANGLES = [-70, -35, -8, 20, 50, 80, -105, 110];
const SHARD_ANGLES = [-50, -15, 15, 50];

export function LikeEffectOverlay({ isLike, onFinished }: { isLike: boolean; onFinished: () => void }) {
  const c = useColors();
  const t = useRef(new Animated.Value(0)).current;
  const flashColor = isLike ? c.accentCoral : DISLIKE_GRAY;

  useEffect(() => {
    const anim = Animated.timing(t, { toValue: 1, duration: 850, useNativeDriver: true });
    anim.start(({ finished }) => {
      if (finished) onFinished();
    });
    return () => anim.stop();
  }, []);

  const rad = (deg: number) => (deg * Math.PI) / 180;

  return (
    <View style={StyleSheet.absoluteFill} pointerEvents="none">
      {/* 가장자리 플래시 */}
      <Animated.View
        style={[
          StyleSheet.absoluteFill,
          {
            borderWidth: 14,
            borderColor: flashColor,
            opacity: t.interpolate({ inputRange: [0, 0.18, 0.73, 1], outputRange: [0, 1, 0, 0] }),
          },
        ]}
      />

      {/* 중앙 상단 이펙트 영역 (Flutter Alignment(0,-0.55) 근사) */}
      <View style={styles.center} pointerEvents="none">
        {isLike
          ? PARTICLE_ANGLES.map((angle, i) => (
              <Animated.View
                key={i}
                style={{
                  position: 'absolute',
                  opacity: t.interpolate({ inputRange: [0, 0.55, 1], outputRange: [1, 1, 0] }),
                  transform: [
                    { translateX: t.interpolate({ inputRange: [0, 0.75, 1], outputRange: [0, 90 * Math.cos(rad(angle)), 90 * Math.cos(rad(angle))] }) },
                    { translateY: t.interpolate({ inputRange: [0, 0.75, 1], outputRange: [-6, 90 * Math.sin(rad(angle)) - 6, 90 * Math.sin(rad(angle)) - 6] }) },
                    { scale: t.interpolate({ inputRange: [0, 1], outputRange: [0.5, 0.9] }) },
                  ],
                }}
              >
                <MaterialIcons name="favorite" size={15} color={c.accentCoral} />
              </Animated.View>
            ))
          : SHARD_ANGLES.map((angle, i) => (
              <Animated.View
                key={i}
                style={{
                  position: 'absolute',
                  opacity: t.interpolate({ inputRange: [0, 0.5, 1], outputRange: [1, 1, 0] }),
                  transform: [
                    { translateX: t.interpolate({ inputRange: [0, 1], outputRange: [0, 50 * Math.cos(rad(angle))] }) },
                    { translateY: t.interpolate({ inputRange: [0, 1], outputRange: [0, 60 + 30 * Math.abs(Math.sin(rad(angle)))] }) },
                    { rotate: t.interpolate({ inputRange: [0, 1], outputRange: ['0deg', `${(i % 2 === 0 ? 1 : -1) * 68}deg`] }) },
                  ],
                }}
              >
                <MaterialIcons name="close" size={10} color={DISLIKE_GRAY} />
              </Animated.View>
            ))}

        {/* 중앙 아이콘 */}
        {isLike ? (
          <Animated.View
            style={{
              opacity: t.interpolate({ inputRange: [0, 0.6, 1], outputRange: [1, 1, 0] }),
              transform: [
                { translateY: t.interpolate({ inputRange: [0, 1], outputRange: [0, -24] }) },
                { scale: t.interpolate({ inputRange: [0, 0.35, 1], outputRange: [1, 1.35, 0.9] }) },
              ],
            }}
          >
            <MaterialIcons name="favorite" size={60} color={c.accentCoral} />
          </Animated.View>
        ) : (
          <Animated.View
            style={{
              opacity: t.interpolate({ inputRange: [0, 0.6, 1], outputRange: [1, 1, 0] }),
              transform: [{ scale: t.interpolate({ inputRange: [0, 0.35, 1], outputRange: [1, 1.15, 0.85] }) }],
            }}
          >
            <MaterialIcons name="heart-broken" size={54} color={DISLIKE_GRAY} />
          </Animated.View>
        )}
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  center: {
    ...StyleSheet.absoluteFillObject,
    top: '22%',
    alignItems: 'center',
    justifyContent: 'flex-start',
  },
});
