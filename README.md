# pm-book-skills

PM 책 두 권을 정리한 AI 스킬 2개입니다. Codex·Claude Code 에서 일하다가 바로 불러 쓸 수 있어요.

| 스킬 | 책 | 이럴 때 |
|---|---|---|
| `mom-test` | 『더 맘 테스트』 (Rob Fitzpatrick) | 고객 인터뷰 질문지 만들기·점검, 칭찬·빈말 걸러내기 |
| `continuous-discovery` | 『지속적 디스커버리 습관』 (Teresa Torres) | 기회 솔루션 트리(OST) 그리기·점검, 가정 테스트 설계 |

## 설치 (한 줄)

**Codex 안에서 설치를 시키지 마세요.** Codex 는 명령을 돌릴 때 인터넷을 막아서 내려받기가 실패해요. 아래 명령은 일반 터미널 창에 붙여 넣으세요.

**Mac** — 「터미널」 앱에 붙여 넣으세요.

```bash
curl -fsSL https://raw.githubusercontent.com/wineny/pm-book-skills/main/install.sh | bash
```

**Windows** — 시작 메뉴에서 「PowerShell」을 열고 붙여 넣으세요. 관리자 권한은 필요 없어요.

```powershell
irm https://raw.githubusercontent.com/wineny/pm-book-skills/main/install.ps1 | iex
```

**인터넷이 안 될 때(Windows)** — [zip 파일](https://github.com/wineny/pm-book-skills/archive/refs/heads/main.zip)(`pm-book-skills-main.zip`)을 받아 압축을 푸세요. 풀면 `pm-book-skills-main` 폴더 안에 같은 이름 폴더가 하나 더 있어요. **`install.ps1` 이 보이는 안쪽 폴더**를 열고, 빈 곳을 오른쪽 클릭해 「터미널에서 열기」(Windows 10 은 Shift + 오른쪽 클릭 → 「여기에 PowerShell 창 열기」)를 누른 뒤 이렇게 치세요.

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

설치가 끝나면 **Codex 를 완전히 껐다가 다시 켜세요.** 스킬은 켤 때만 읽어요. 다시 켠 뒤 「mom-test 스킬 있어?」라고 물어서 확인하세요.

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
