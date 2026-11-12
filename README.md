# WordFlip

**Ứng dụng học từ vựng bằng Flashcard trên thiết bị di động**

Báo cáo môn **Lập trình thiết bị di động** (Flutter).

## Thông tin nhóm

| Thông tin | Chi tiết |
|---|---|
| Lớp học phần | N01 |
| Nhóm | 13 |
| Giảng viên | Nguyễn Xuân Quế |

### Thành viên

| STT | Họ và tên | MSSV |
|---|---|---|
| 1 | Vũ Thành Long | 23010882 |
| 2 | Phạm Hồng Sơn | 23010883 |

## Giới thiệu

WordFlip giúp người dùng học từ vựng tiếng Anh theo chủ đề bằng thẻ lật (flashcard) và kiểm tra lại kiến thức bằng bài trắc nghiệm. Giao diện thân thiện, hỗ trợ song ngữ Anh - Việt và chế độ sáng/tối.

## Chức năng chính

- **Màn hình khởi động (Splash)** và **Trang chủ** hiển thị tiến độ học, thống kê số bộ thẻ, tổng số từ.
- **Danh sách bộ thẻ** dạng lưới theo chủ đề (Family, Travel, Food, Work), có thanh tìm kiếm.
- **Chi tiết bộ thẻ**: danh sách từ, trạng thái đã thuộc, thanh tiến độ.
- **Học Flashcard**: thẻ lật 3D, xem nghĩa và câu ví dụ, đánh dấu "Đã thuộc / Chưa thuộc".
- **Quiz trắc nghiệm**: 4 đáp án, đồng hồ đếm ngược 10 giây mỗi câu, màn hình kết quả kèm danh sách từ cần ôn lại.
- **Cài đặt**: đổi ngôn ngữ Anh/Việt, bật tắt chế độ tối.
- **Thông tin nhóm**: thành viên, môn học, công nghệ sử dụng.

## Công nghệ sử dụng

- Flutter, Dart (Material 3)
- `provider`: quản lý trạng thái (ngôn ngữ, giao diện)
- `flutter_localizations`: hỗ trợ đa ngôn ngữ
- Dữ liệu lưu tạm trong biến (không dùng file hay cơ sở dữ liệu)

## Cấu trúc thư mục

```
lib/
├── main.dart
├── data/          # Dữ liệu mẫu (sample_data.dart)
├── l10n/          # Chuỗi văn bản song ngữ (app_strings.dart)
├── models/        # Word, Deck
├── providers/     # SettingsProvider
├── screens/       # Các màn hình của ứng dụng
├── utils/         # Theme
└── widgets/       # FlipCard, DeckCard
```

## Hướng dẫn chạy

```bash
git clone https://github.com/longdz05/2026_2027_1_1_LTTBDD_N01_Nhom_13.git
cd 2026_2027_1_1_LTTBDD_N01_Nhom_13
flutter pub get
flutter run
```

Yêu cầu: đã cài Flutter SDK và có thiết bị hoặc trình duyệt Chrome để chạy.

## Quản lý mã nguồn

- Commit đầu tiên chỉ chứa code mẫu của Flutter.
- Mỗi commit build thành công, thay đổi nhỏ và có message mô tả rõ nội dung.
