# pm-book-skills

PM 책 두 권을 정리한 AI 스킬 2개입니다. Codex·Claude Code 에서 일하다가 바로 불러 쓸 수 있어요.

| 스킬 | 책 | 이럴 때 |
|---|---|---|
| `mom-test` | 『더 맘 테스트』 (Rob Fitzpatrick) | 고객 인터뷰 질문지 만들기·점검, 칭찬·빈말 걸러내기 |
| `continuous-discovery` | 『지속적 디스커버리 습관』 (Teresa Torres) | 기회 솔루션 트리(OST) 그리기·점검, 가정 테스트 설계 |

## 설치 (한 줄)

터미널에 붙여 넣으세요.

```bash
curl -fsSL https://raw.githubusercontent.com/wineny/pm-book-skills/main/install.sh | bash
```

- Codex 스킬 폴더(`~/.codex/skills`)에 설치합니다.
- Claude Code 를 쓰고 있으면(`~/.claude` 가 있으면) `~/.claude/skills` 에도 설치합니다.
- 다시 실행하면 최신 내용으로 덮어씁니다.

직접 하고 싶으면:

```bash
git clone https://github.com/wineny/pm-book-skills.git
cp -R pm-book-skills/skills/* ~/.codex/skills/
```

## 써 보기

Codex 를 새로 열고:

- 「mom-test 스킬로 이 인터뷰 질문지 점검해 줘. 미래 가정·칭찬 유도 질문을 찾아서 고쳐 줘.」
- 「continuous-discovery 스킬로 기회 솔루션 트리 만들자. 목표는 ___ 야. 인터뷰에서 들은 이야기는 이거야: ___」
- 「우리는 ___라서 ___로 정했는데, 책에서도 그래?」

## 알아 둘 점

- 책 내용을 장별로 요약·정리한 것입니다. 책 원문은 들어 있지 않아요.
- 개인 공부·자기 프로젝트용으로 써 주세요.
