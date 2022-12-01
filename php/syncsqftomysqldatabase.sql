-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 01/12/2022 às 10:18
-- Versão do servidor: 8.0.30
-- Versão do PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `syncsqftomysqldatabase`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `contactinfotable`
--

CREATE TABLE `contactinfotable` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `contact_id` int NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `contactinfotable`
--

INSERT INTO `contactinfotable` (`id`, `user_id`, `contact_id`, `name`, `email`, `gender`, `created_at`) VALUES
(3, 1, 1, 'Izaias', 'email1@gmail', 'Masculino', '2022-12-01 09:27:02.691800'),
(4, 1, 2, 'Francisco', 'email@email.com', 'Masculino', '2022-12-01 10:14:58.606213'),
(5, 1, 3, 'Francisco', 'email@email.com', 'Masculino', '2022-12-01 10:15:07.423683'),
(6, 1, 4, 'Francisco1', 'email@email.com', 'Masculino', '2022-12-01 10:16:51.236187');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `contactinfotable`
--
ALTER TABLE `contactinfotable`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `contactinfotable`
--
ALTER TABLE `contactinfotable`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
