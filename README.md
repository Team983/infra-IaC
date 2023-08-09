<div align="center">

# Synnote Infrastructure as Code

</div>

# 주요 기능
- 고가용성을 위하여 여러 가용 영역에 걸친 서브넷 배포, NAT 게이트웨이 분산 배치 및 데이터베이스 서브넷 그룹 구성
- AWS RDS 데이터베이스 및 관련 보안 그룹 프로비저닝
- AWS EKS 기반 Multi Node 쿠버네티스 클러스터 프로비저닝
- ALB Controller가 필요로 하는 IAM 역할을 생성, 해당 역할에 필요한 IAM 정책을 연결

# 사용 기술

- HCL / Terraform
- AWS VPC
- AWS RDS
- AWS EKS
- AWS ALB
- AWS S3

