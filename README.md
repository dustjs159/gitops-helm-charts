# Gitops Architecture

## argocd - Github App 연동

ArgoCD–GitHub App 연동은 개인 PAT 대신 GitHub App의 단기 토큰(자동 발급·회전)을 사용해, 계정 종속·만료 관리 부담 없이 최소 권한으로 더 안전하고 복구 가능한 Git 접근을 제공.

### How to works
1. Argo CD가 Private Key로 JWT 생성
2. JWT로 GitHub API에 요청 → Installation Token 발급
3. 해당 토큰으로 Git clone
4. 1시간 후 자동 재발급(arogcd에서 자동으로 처리하기 때문에 별도로 관리할 필요 없음.)

### Setup
1. Settings > Developer settings > Github Apps > New Github App
2. GitHub App name 입력
3. Homepage URL: https://argocd.acme.io
4. Repository permissions
    - Contents: `Read-only`
    - Metadata: `Read-only`
5. 이후 `Generate private key` 
    - 자동으로 로컬에 다운로드됨
6. Installation ID 확인
    - Settings > Developer settings > Github Apps > 위에서 생성한 Github Apps 선택 > Install App > Repository 선택 > URL에 임의의 숫자 확인
        - 예시) https://github.com/settings/installations/123456789

### Create K8s secret
```zsh
kubectl create secret generic argocd-repo-creds \
  -n argocd \
  --from-literal=appID=**** \
  --from-literal=installationID=**** \
  --from-file=privateKey=****
```