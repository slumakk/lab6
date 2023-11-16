-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 16, 2023 at 06:33 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `agency`
--

-- --------------------------------------------------------

--
-- Table structure for table `agreements`
--

CREATE TABLE `agreements` (
  `ID` int(11) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp() COMMENT 'Дата укладання договору',
  `property_id` int(11) NOT NULL COMMENT 'Нерухомість',
  `realtor_id` int(11) NOT NULL COMMENT 'Рієлтор',
  `buyer_id` int(11) NOT NULL COMMENT 'Покупець',
  `seller_id` int(11) NOT NULL COMMENT 'Продавець',
  `price` int(11) NOT NULL COMMENT 'Ціна',
  `deposit_amount` int(11) NOT NULL COMMENT 'Сума внеску',
  `payments_qty` int(11) NOT NULL COMMENT 'Кількість платежів',
  `payment_end_date` date NOT NULL COMMENT 'Дата кінця виплати',
  `status_id` int(11) NOT NULL COMMENT 'Поточний статус'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `agreements`
--

INSERT INTO `agreements` (`ID`, `date`, `property_id`, `realtor_id`, `buyer_id`, `seller_id`, `price`, `deposit_amount`, `payments_qty`, `payment_end_date`, `status_id`) VALUES
(1, '2021-07-13', 1, 1, 1, 2, 1003056000, 500000, 2007, '2030-07-13', 5),
(2, '2023-11-16', 3, 2, 1, 10, 3000000, 40000, 75, '2026-11-16', 5),
(3, '2022-09-14', 6, 5, 8, 3, 362324000, 181162000, 2, '2023-11-01', 9),
(4, '2022-01-05', 7, 5, 10, 1, 4000000, 100000, 100, '2027-11-05', 9),
(5, '2023-06-16', 5, 2, 1, 5, 380000, 54000, 10, '2025-11-16', 7),
(6, '2023-11-16', 13, 3, 2, 5, 2100000, 50000, 30, '2028-04-05', 9),
(7, '2021-11-24', 14, 5, 8, 9, 2500000, 43000, 44, '2026-11-23', 5);

-- --------------------------------------------------------

--
-- Table structure for table `agreement_statuses`
--

CREATE TABLE `agreement_statuses` (
  `ID` int(11) NOT NULL,
  `status` varchar(32) NOT NULL COMMENT 'Назва статусу'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `agreement_statuses`
--

INSERT INTO `agreement_statuses` (`ID`, `status`) VALUES
(1, 'Неактивний'),
(2, 'Анульовано'),
(3, 'Активно обговорюється'),
(4, 'Підготовлено до підписання'),
(5, 'Підписано'),
(6, 'Узгоджено'),
(7, 'Відправлено на підпис'),
(8, 'Отримано підписи'),
(9, 'Зареєстровано в реєстрі');

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `ID` int(11) NOT NULL,
  `name` varchar(32) NOT NULL COMMENT 'Ім''я',
  `surname` varchar(32) NOT NULL COMMENT 'Прізвище',
  `patronymic` varchar(32) NOT NULL COMMENT 'По батькові',
  `passport_location` text DEFAULT NULL COMMENT 'Розташування фотографії паспорту',
  `identification_code_location` text DEFAULT NULL COMMENT 'Розташування фотографії Ідентифікаційного коду',
  `is_married` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Сімейний статус (чи одружений)',
  `email` varchar(64) DEFAULT NULL COMMENT 'Електронна скринька',
  `phone_number` decimal(15,0) NOT NULL COMMENT 'Номер телефону'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`ID`, `name`, `surname`, `patronymic`, `passport_location`, `identification_code_location`, `is_married`, `email`, `phone_number`) VALUES
(1, 'Ярослав', 'Петров', 'Ігорович', 'ІПЗ-2 Алгоритми Лаб 11-1.pdf', 'Шаблон звіту ЛР5.docx', 1, 'ivanov@example.com', 380991234567),
(2, 'Ольга', 'Сидоренко', 'Петрівна', '.', '.', 0, 'sidorenko@example.com', 380992345678),
(3, 'Петро', 'Михайлов', 'Олексійович', 'passport3.jpg', 'identification_code3.jpg', 1, 'mikhailov@example.com', 380993456789),
(4, 'Рава', 'Когут', 'Макарович', 'bmw_x3__516645587hd.jpg', 'bmw_x3__516645587hd.webp', 0, 'violinhi@yahoo.com', 380914701144),
(5, 'Йозеф', 'Білявський', 'Милославович', 'androidparty.png', '', 1, 'mlewan@comcast.net', 380972125327),
(6, 'Яровит', 'Кочур', 'Орестович', '', 'Ariana_Grande_Grammys_Red_Carpet_2020.png', 0, 'eurohack@att.net', 380681574030),
(7, 'Лілея', 'Малежик', 'Костянтинівна', '', '', 1, 'graham@mac.com', 380632144225),
(8, 'Владлена', 'Василашко', 'Глібівна', 'Практична робота №11. Висловлення. Предикати-1.pdf', 'PixysOS-v7.0.0-GAPPS-coral-BETA-20231105-172458-img.zip', 0, 'dialworld@live.com', 380918725647),
(9, 'Злата', 'Семеняк', 'Федорівна', '', '', 1, 'malvar@outlook.com', 380976206788),
(10, 'Вернидуб', 'Гетьманчук', 'Устимович', 'sGSI++PR1++WiFi-BT-fix.zip', 'Magisk-v26.1.apk', 1, 'fmtbebuck@yahoo.ca', 380981184157);

-- --------------------------------------------------------

--
-- Table structure for table `properties`
--

CREATE TABLE `properties` (
  `ID` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL COMMENT 'Власник',
  `region` varchar(32) NOT NULL COMMENT 'Область',
  `city` varchar(25) NOT NULL COMMENT 'Населений пункт',
  `address` varchar(50) DEFAULT NULL COMMENT 'Адреса',
  `house_number` varchar(4) DEFAULT NULL COMMENT 'Номер будинку',
  `flat_number` varchar(4) DEFAULT NULL COMMENT 'Номер квартири',
  `type_id` int(11) NOT NULL COMMENT 'Тип нерухомості',
  `area` decimal(7,2) NOT NULL COMMENT 'Площа (м²)',
  `price` int(11) NOT NULL COMMENT 'Ціна',
  `is_active` tinyint(1) DEFAULT 0 COMMENT 'Чи на продажі',
  `description` text DEFAULT NULL COMMENT 'Короткий опис'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `properties`
--

INSERT INTO `properties` (`ID`, `owner_id`, `region`, `city`, `address`, `house_number`, `flat_number`, `type_id`, `area`, `price`, `is_active`, `description`) VALUES
(1, 1, 'Полтавська', 'Абзаівка', '', '', '', 6, 1016.00, 1000000000, 1, ''),
(2, 6, 'Дніпропетровська', 'Цвричанка', 'Першотравнева', '73', '', 3, 70.00, 543486, 1, 'високі стелі, 4 кімнати, санвузол, центр. вода, газове опалення, бойлер, літня кухня, землі 0,20 га під\'їзні шляхи асфальт, будинок в житловому стані, гараж'),
(3, 1, 'Харківська', 'Харків', 'вул. Студентська', '1', '42д', 4, 79.80, 2789895, 1, 'В квартирі зроблений якісний, сучасний ремонт. Підлога утеплена - ламінат, кахель. Санвузол фаневрований, встановлені лічільники на воду. Є готовий дизайн-проєкт кухні. Є вже куплені меблі на кухню. За додадкову плату є можливість придбати паркомісце, та комору з документами. Будинок заселений. '),
(4, 4, 'Київська', 'Київ', 'вул. Чернігівська', '10', '', 5, 31600.00, 797112800, 0, 'Поруч Епіцентр, Новус, ринок Троєщина, гарна транспортна розв\'язка. На сьогодні в оренді вже більша половина приміщень! Постійний трафік. До метро Чернігівська 10 хвилин на авто. система пожежної сигналізації система охранної сигналізації система кондиціонування система вентиляції відеонагляд'),
(5, 1, 'Донецька', 'Краматорськ', 'вул. Наді Курченко', '29', '5', 4, 56.40, 344208, 0, 'четырех комнатная квартира под ремонт. крыша новая.квартира теплая. хороший тихий район. школа,дет.сад,рынок-все в пешей доступности. хорошая транспортная развязка.'),
(6, 8, 'Київська', 'Бровари', '', '', '', 1, 3402.00, 362324000, 0, 'Участок расположен в черте города Бровары правильной формы с удобной транспортной развязкой Целевое назначение: Жилищной застройки и общественного назначения для размещения жилой застройки и объектов инфраструктуры.'),
(7, 10, 'Київська', 'Ходосівка', '', '', '', 1, 3100.00, 4166726, 1, 'Вся инфраструктура рядом: Мегамаркет , рестораны , магазины, школа , садик , больница , остановка транспорта Соседи застроены Асфальтированный подъезд  Коммуникации: газ , свет 75 кВ,скважина  Хорошая транспортная развязка ,заезд с новообуховской трассы , до Киева 15мин'),
(8, 7, 'Київська', 'Київ', 'вул. Червоноткацька', '42в', '', 6, 1200.00, 358700760, 1, 'У будинку є два автономні твердопаливні котли, світло 100 кВт, стелі заввишки 5 м. Меблі та техніка — за домовленістю. На цю мить будинок знаходиться в оренді: готель (хостел на 150 місць), СТО, магазин олій.  Ділянка з будівлею розташована на ділянці 0,24 Га, територія має огорожі.'),
(9, 3, 'Київська', 'Щасливе', 'вул. Пса Патрона', '34', '', 3, 1150.00, 18116200, 1, 'Будинок 3-х поверховий 1050 кв.м. + цокольний поверх. На ділянці 38 соток розташовані: гостинний будинок на 100 кв.м., басейн, сауна, будинок охорони.. В будинку 9 спалень, 7 сан.вузлів, 2 вітальні, 2 великі гардеробні кімнати, велика пральна, також є кімнати вільного використання.'),
(10, 6, 'Полтавська', 'Миргород', 'вул. Зміїна', '3', '', 5, 54.00, 1559296, 1, ''),
(13, 2, 'Київська', 'Київ', 'вул. Ужвій Наталі', '9', '16', 4, 79.00, 2083691, 1, 'высокий тех этаж, трехкомнатная продам отличный двор, парковка, детские площадки, чистое парадное, этаж, два лифта хорошее состояние, холл, гардеробная, санузел разный, 79/44/9, паркетная доска, напольная плитка, кафель, без мебели, электроплита, хорошее состояние , красивый вид.'),
(14, 8, 'Київська', 'Київ', 'вул. Деригуса', '44', '6г', 4, 28.00, 2355477, 1, '- 2-й поверх з 4-х;\r\n- зроблений якісний ремонт;\r\n- мебльована по індивідуальному дизайну;\r\n- підігрів підлоги у всій квартирі\r\n- гарна, зелена територія\r\n- 15-20 хвилин від будинку до станції метро Васильківська.');

-- --------------------------------------------------------

--
-- Table structure for table `properties_types`
--

CREATE TABLE `properties_types` (
  `ID` int(11) NOT NULL,
  `type` varchar(32) NOT NULL COMMENT 'Назва типу'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `properties_types`
--

INSERT INTO `properties_types` (`ID`, `type`) VALUES
(1, 'Земельна ділянка'),
(3, 'Будівля'),
(4, 'Квартира'),
(5, 'Приміщення офісного призначення'),
(6, 'Виробниче приміщення'),
(7, 'Склад');

-- --------------------------------------------------------

--
-- Table structure for table `realtors`
--

CREATE TABLE `realtors` (
  `ID` int(11) NOT NULL,
  `name` varchar(32) NOT NULL COMMENT 'Ім''я',
  `surname` varchar(32) NOT NULL COMMENT 'Прізвище',
  `patronymic` varchar(32) NOT NULL COMMENT 'По батькові',
  `email` varchar(64) NOT NULL COMMENT 'Електронна скринька',
  `phone_number` decimal(15,0) NOT NULL COMMENT 'Номер телефону у міжнародному форматі',
  `is_employed` tinyint(1) DEFAULT 0 COMMENT 'Чи виконує свої обов''язки на даний момент',
  `asnu_cert` varchar(6) NOT NULL COMMENT 'Номер сертифікату АФНУ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `realtors`
--

INSERT INTO `realtors` (`ID`, `name`, `surname`, `patronymic`, `email`, `phone_number`, `is_employed`, `asnu_cert`) VALUES
(1, 'Олег', 'Євлашкін', 'Вікторович', 'sartak@optonline.net', 380943705895, 1, '23-013'),
(2, 'Дмитро', 'Євстафієв', 'Михайлович', 'godeke@gmail.com', 380918061319, 1, '01-657'),
(3, 'Світлана', 'Євстратенко', 'Анатоліївна', 'fmtbebuck@yahoo.ca', 380984948027, 0, '01-292'),
(4, 'Сергій', 'Євстратенко', 'Володимирович', 'graham@mac.com', 380940161115, 1, '05-070'),
(5, 'Сергій', 'Євтухов', 'Іванович', 'bmorrow@yahoo.ca', 380942011983, 1, '01-076');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `agreements`
--
ALTER TABLE `agreements`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `realtor_id` (`realtor_id`),
  ADD KEY `buyer_id` (`buyer_id`),
  ADD KEY `seller_id` (`seller_id`),
  ADD KEY `property_id` (`property_id`),
  ADD KEY `status_id` (`status_id`);

--
-- Indexes for table `agreement_statuses`
--
ALTER TABLE `agreement_statuses`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `owner_id` (`owner_id`),
  ADD KEY `type_id` (`type_id`),
  ADD KEY `owner_id_2` (`owner_id`);

--
-- Indexes for table `properties_types`
--
ALTER TABLE `properties_types`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `realtors`
--
ALTER TABLE `realtors`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `agreements`
--
ALTER TABLE `agreements`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `agreement_statuses`
--
ALTER TABLE `agreement_statuses`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `properties`
--
ALTER TABLE `properties`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `properties_types`
--
ALTER TABLE `properties_types`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `realtors`
--
ALTER TABLE `realtors`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `agreements`
--
ALTER TABLE `agreements`
  ADD CONSTRAINT `agreements_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `agreement_statuses` (`ID`),
  ADD CONSTRAINT `agreements_ibfk_2` FOREIGN KEY (`property_id`) REFERENCES `properties` (`ID`),
  ADD CONSTRAINT `agreements_ibfk_3` FOREIGN KEY (`realtor_id`) REFERENCES `realtors` (`ID`),
  ADD CONSTRAINT `agreements_ibfk_4` FOREIGN KEY (`buyer_id`) REFERENCES `clients` (`ID`),
  ADD CONSTRAINT `agreements_ibfk_5` FOREIGN KEY (`seller_id`) REFERENCES `clients` (`ID`);

--
-- Constraints for table `properties`
--
ALTER TABLE `properties`
  ADD CONSTRAINT `properties_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `clients` (`ID`),
  ADD CONSTRAINT `properties_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `properties_types` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
