# Todolune

> 📝 Todolune - 할일 관리 앱

<br>

<img width="1960" height="960" alt="Image" src="https://github.com/user-attachments/assets/3dd56169-8c77-4326-8f59-76c7036787e9" />

## 🎯 Overview

Todolune는 UIKit 기반으로 구현한 할일 관리 앱입니다. <br>
Stitch AI를 활용하여 화면 레이아웃을 참고하였고, 실제 UI는 코드 베이스로 직접 구현하였습니다. <br>
데이터를 저장하기 위해 CoreData를 활용하여 할일 등록, 조회, 수정, 삭제 기능을 구현하였습니다. <br>
이를 통해 iOS 앱의 기본 구조와 화면 간 데이터 흐름을 이해하고, UIKit 기반 앱의 CRUD 구현 경험을 쌓았습니다. <br>
또한 앱 스토어 배포를 진행하여 실제 iOS 앱을 출시하는 경험을 쌓았습니다.

- 플랫폼: iOS
- 개발 기간: 2025.11.16 ~ 2026.01.06(52일)
- 개발 인원: 1명
- 기술 스택: UIKit, Core Data
- Design Source: Stitch AI
- App Store: [https://apps.apple.com/kr/app/todolune/id6757188137](https://apps.apple.com/kr/app/todolune/id6757188137)

## 📷 ScreenShot

<div align="left">
  <img src="https://github.com/user-attachments/assets/68a1c7b1-24f9-4663-ae89-82ce7b494fd1" width="260" />
  <img src="https://github.com/user-attachments/assets/41b40c47-51f3-4b5b-8629-182ef1f549c7" width="260" />
  <img src="https://github.com/user-attachments/assets/187a946c-7339-4485-922a-dddf27358f77" width="260" />
</div>

## ✨ Features

- 할일 목록 조회
  - 등록된 할일을 생성 날짜 순으로 표시
- 할일 등록
  - 제목, 내용 입력을 통한 신규 할일 생성
- 할일 수정
  - 기존 할일의 제목 및 내용 수정
- 할일 삭제
  - 할일 삭제 기능 제공
- 데이터 영속성
  - CoreData를 활용하여 앱 종료 후에도 데이터 유지
- 코드 기반 UI 구성
  - UIKit + AutoLayout을 사용한 코드 베이스 UI 구현

## 📚 Learned
- `UIScrollView`를 직접 사용하며 `frame`과 `bounds`의 차이 및 스크롤 좌표계 동작 방식 이해
- `UITableView` / `UITableViewCell` 기반 리스트 UI 구성 및 재사용 메커니즘 이해
- Custom Delegate 패턴을 통해 화면 간 데이터 변경 이벤트 전달
- Core Data를 활용한 로컬 데이터 CRUD 및 영속성 처리 경험
- `UITextField`, `UITextView`를 통한 사용자 입력 처리 및 검증
- `UIStackView`를 활용한 레이아웃 구성 및 뷰 계층 관리
- `NSLayoutConstraint` 기반 `AutoLayout` 구성 및 코드 레이아웃 설계
- Hugging / Compression Priority를 활용한 동적 레이아웃 제어
- 앱 미리보기 이미지 제작 경험

## 🚨 Troubleshooting & Debugging
- [https://myrrhex06.github.io/posts/tableviewdeleterowsexception/](https://myrrhex06.github.io/posts/tableviewdeleterowsexception/)
- [https://myrrhex06.github.io/posts/uitableviewdeleteupdateissue/](https://myrrhex06.github.io/posts/uitableviewdeleteupdateissue/)
