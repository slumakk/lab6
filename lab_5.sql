-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Час створення: Лис 30 2023 р., 19:58
-- Версія сервера: 10.4.28-MariaDB
-- Версія PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База даних: `lab_5`
--

-- --------------------------------------------------------

--
-- Структура таблиці `chemicals`
--

CREATE TABLE `chemicals` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `chemical_composition` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп даних таблиці `chemicals`
--

INSERT INTO `chemicals` (`id`, `name`, `chemical_composition`) VALUES
(1, 'Хлорид натрію', 'NaCl'),
(2, 'Цукор', 'C6H12O6'),
(3, 'Парафін', 'CnH2n+2'),
(4, 'Вода', 'H2O');

-- --------------------------------------------------------

--
-- Структура таблиці `experiments`
--

CREATE TABLE `experiments` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп даних таблиці `experiments`
--

INSERT INTO `experiments` (`id`, `date`, `description`) VALUES
(1, '2023-11-30 18:06:35', 'Тестування реакції хлориду натрію з хлоридною кислотою'),
(2, '2023-11-30 18:06:35', 'Тестування розчинності цукру в воді'),
(3, '2023-11-30 18:07:22', 'Тестування горіння свічки');

-- --------------------------------------------------------

--
-- Структура таблиці `results`
--

CREATE TABLE `results` (
  `id` int(11) NOT NULL,
  `experiment_id` int(11) NOT NULL,
  `obtained_data` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп даних таблиці `results`
--

INSERT INTO `results` (`id`, `experiment_id`, `obtained_data`, `description`) VALUES
(3, 1, 'Прозорий розчин	', 'Реакція відбулася, утворився прозорий розчин солі'),
(4, 2, 'Розчинений', 'Цукор повністю розчинився у воді.'),
(5, 3, 'Згоріла', 'Свічка повністю згоріла, утворивши дим і попіл.\r\n');

-- --------------------------------------------------------

--
-- Структура таблиці `results_chemicals`
--

CREATE TABLE `results_chemicals` (
  `id` int(11) NOT NULL,
  `result_id` int(11) NOT NULL,
  `chemical_id` int(11) NOT NULL,
  `dose` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп даних таблиці `results_chemicals`
--

INSERT INTO `results_chemicals` (`id`, `result_id`, `chemical_id`, `dose`) VALUES
(1, 3, 4, 10),
(2, 3, 1, 2),
(3, 4, 4, 10),
(4, 4, 2, 4),
(5, 5, 3, 1);

--
-- Індекси збережених таблиць
--

--
-- Індекси таблиці `chemicals`
--
ALTER TABLE `chemicals`
  ADD PRIMARY KEY (`id`);

--
-- Індекси таблиці `experiments`
--
ALTER TABLE `experiments`
  ADD PRIMARY KEY (`id`);

--
-- Індекси таблиці `results`
--
ALTER TABLE `results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `experiment_id` (`experiment_id`);

--
-- Індекси таблиці `results_chemicals`
--
ALTER TABLE `results_chemicals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chemical_id` (`chemical_id`),
  ADD KEY `result_id` (`result_id`);

--
-- AUTO_INCREMENT для збережених таблиць
--

--
-- AUTO_INCREMENT для таблиці `chemicals`
--
ALTER TABLE `chemicals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблиці `experiments`
--
ALTER TABLE `experiments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблиці `results`
--
ALTER TABLE `results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблиці `results_chemicals`
--
ALTER TABLE `results_chemicals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Обмеження зовнішнього ключа збережених таблиць
--

--
-- Обмеження зовнішнього ключа таблиці `results`
--
ALTER TABLE `results`
  ADD CONSTRAINT `results_ibfk_1` FOREIGN KEY (`experiment_id`) REFERENCES `experiments` (`id`);

--
-- Обмеження зовнішнього ключа таблиці `results_chemicals`
--
ALTER TABLE `results_chemicals`
  ADD CONSTRAINT `results_chemicals_ibfk_2` FOREIGN KEY (`chemical_id`) REFERENCES `chemicals` (`id`),
  ADD CONSTRAINT `results_chemicals_ibfk_3` FOREIGN KEY (`result_id`) REFERENCES `results` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
