# Gitops Architecture

## Argocd - Github App 연동

### Setup Github Credential 
ArgoCD–GitHub App 연동은 개인 PAT 대신 GitHub App의 단기 토큰(자동 발급·회전)을 사용해, 계정 종속·만료 관리 부담 없이 최소 권한으로 더 안전하고 복구 가능한 Git 접근을 제공.

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
kubectl apply -f argocd-repo-creds.yaml
kubectl apply -f argocd-repositories.yaml
```