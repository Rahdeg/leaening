-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 10, 2026 at 06:59 PM
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
-- Database: `savify_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `activity_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `goal_id` int(11) DEFAULT NULL,
  `activity_type` varchar(100) NOT NULL,
  `activity_message` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`activity_id`, `user_id`, `goal_id`, `activity_type`, `activity_message`, `created_at`) VALUES
(1, 1, NULL, 'Account Creation', 'You created an account', '2026-03-10 17:57:20'),
(2, 1, 1, 'Deposit', 'You deposited ₦500 into School Fees 2026', '2026-03-10 17:57:20'),
(3, 1, 2, 'Deposit', 'You deposited ₦1200 into Rent Fund', '2026-03-10 17:57:20'),
(4, 2, 3, 'Goal Target Met', 'Emergency Backup reached target amount', '2026-03-10 17:57:20'),
(5, 2, 3, 'Bonus Awarded', 'You received a 10% consistency bonus', '2026-03-10 17:57:20');

-- --------------------------------------------------------

--
-- Table structure for table `bonuses`
--

CREATE TABLE `bonuses` (
  `bonus_id` int(11) NOT NULL,
  `goal_id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `bonus_percentage` decimal(5,2) NOT NULL DEFAULT 10.00,
  `bonus_amount` decimal(12,2) NOT NULL,
  `eligibility_status` enum('eligible','not_eligible') NOT NULL,
  `awarded_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bonuses`
--

INSERT INTO `bonuses` (`bonus_id`, `goal_id`, `transaction_id`, `bonus_percentage`, `bonus_amount`, `eligibility_status`, `awarded_at`) VALUES
(1, 3, 6, 10.00, 200.00, 'eligible', '2026-03-10 17:57:20');

-- --------------------------------------------------------

--
-- Table structure for table `goal_categories`
--

CREATE TABLE `goal_categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `goal_categories`
--

INSERT INTO `goal_categories` (`category_id`, `category_name`, `description`) VALUES
(1, 'Tuition', 'Saving towards school fees'),
(2, 'Rent', 'Saving towards accommodation'),
(3, 'Business', 'Saving for business capital'),
(4, 'Emergency', 'Emergency reserve fund'),
(5, 'Travel', 'Saving for trips and vacations');

-- --------------------------------------------------------

--
-- Table structure for table `otp_verifications`
--

CREATE TABLE `otp_verifications` (
  `otp_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `otp_code` varchar(10) NOT NULL,
  `expires_at` datetime NOT NULL,
  `verified_at` datetime DEFAULT NULL,
  `status` enum('pending','verified','expired') NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `otp_verifications`
--

INSERT INTO `otp_verifications` (`otp_id`, `user_id`, `otp_code`, `expires_at`, `verified_at`, `status`) VALUES
(1, 1, '483920', '2026-03-10 18:07:20', '2026-03-10 17:57:20', 'verified'),
(2, 2, '918274', '2026-03-10 18:07:20', '2026-03-10 17:57:20', 'verified');

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods`
--

CREATE TABLE `payment_methods` (
  `payment_method_id` int(11) NOT NULL,
  `method_name` varchar(100) NOT NULL,
  `provider_name` varchar(100) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment_methods`
--

INSERT INTO `payment_methods` (`payment_method_id`, `method_name`, `provider_name`, `status`) VALUES
(1, 'Bank Transfer', 'GTBank', 'active'),
(2, 'Card Payment', 'Visa', 'active'),
(3, 'Mobile Money', 'Opay', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `savings_goals`
--

CREATE TABLE `savings_goals` (
  `goal_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `goal_title` varchar(100) NOT NULL,
  `goal_description` text DEFAULT NULL,
  `target_amount` decimal(12,2) NOT NULL,
  `current_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `saving_frequency` enum('daily','weekly','monthly','manual') NOT NULL DEFAULT 'manual',
  `duration_months` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `scheduled_withdrawal_date` date DEFAULT NULL,
  `goal_status` enum('active','target_met','locked','completed','withdrawn') NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `savings_goals`
--

INSERT INTO `savings_goals` (`goal_id`, `user_id`, `category_id`, `goal_title`, `goal_description`, `target_amount`, `current_amount`, `saving_frequency`, `duration_months`, `start_date`, `end_date`, `scheduled_withdrawal_date`, `goal_status`, `created_at`) VALUES
(1, 1, 1, 'School Fees 2026', 'Saving towards tuition payment', 5000.00, 1300.00, 'monthly', 12, '2026-01-01', '2026-12-01', '2026-12-05', 'active', '2026-03-10 17:57:20'),
(2, 1, 2, 'Rent Fund', 'Saving towards yearly rent', 6000.00, 1200.00, 'monthly', 10, '2026-02-01', '2026-11-30', '2026-12-01', 'active', '2026-03-10 17:57:20'),
(3, 2, 4, 'Emergency Backup', 'Emergency personal savings', 2000.00, 2200.00, 'weekly', 6, '2026-01-15', '2026-07-15', '2026-07-16', 'completed', '2026-03-10 17:57:20');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `transaction_id` int(11) NOT NULL,
  `goal_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `transaction_type` enum('deposit','withdrawal','bonus') NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `transaction_reference` varchar(100) NOT NULL,
  `transaction_status` enum('pending','successful','failed') NOT NULL DEFAULT 'successful',
  `transaction_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`transaction_id`, `goal_id`, `user_id`, `payment_method_id`, `transaction_type`, `amount`, `transaction_reference`, `transaction_status`, `transaction_date`) VALUES
(1, 1, 1, 1, 'deposit', 500.00, 'TXN-0001', 'successful', '2026-03-10 17:57:20'),
(2, 1, 1, 2, 'deposit', 800.00, 'TXN-0002', 'successful', '2026-03-10 17:57:20'),
(3, 2, 1, 3, 'deposit', 1200.00, 'TXN-0003', 'successful', '2026-03-10 17:57:20'),
(4, 3, 2, 1, 'deposit', 2000.00, 'TXN-0004', 'successful', '2026-03-10 17:57:20'),
(5, 3, 2, 1, 'withdrawal', 2000.00, 'TXN-0005', 'successful', '2026-03-10 17:57:20'),
(6, 3, 2, 1, 'bonus', 200.00, 'TXN-0006', 'successful', '2026-03-10 17:57:20');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('user','admin') NOT NULL DEFAULT 'user',
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `occupation`, `password_hash`, `role`, `is_verified`, `created_at`) VALUES
(1, 'Raheem Adegbite', 'raheem@example.com', 'Student', 'hashed_password_1', 'user', 1, '2026-03-10 17:57:20'),
(2, 'Omobolanle Famotibe', 'omobolanle@example.com', 'Student', 'hashed_password_2', 'user', 1, '2026-03-10 17:57:20'),
(3, 'Super Admin', 'admin@savify.com', 'Administrator', 'hashed_password_3', 'admin', 1, '2026-03-10 17:57:20');

-- --------------------------------------------------------

--
-- Table structure for table `withdrawals`
--

CREATE TABLE `withdrawals` (
  `withdrawal_id` int(11) NOT NULL,
  `goal_id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `requested_amount` decimal(12,2) NOT NULL,
  `approved_amount` decimal(12,2) DEFAULT NULL,
  `reason_for_withdrawal` text DEFAULT NULL,
  `eligibility_status` enum('eligible','not_eligible') NOT NULL,
  `withdrawal_status` enum('pending','approved','rejected','processed') NOT NULL DEFAULT 'pending',
  `requested_at` datetime NOT NULL DEFAULT current_timestamp(),
  `processed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `withdrawals`
--

INSERT INTO `withdrawals` (`withdrawal_id`, `goal_id`, `transaction_id`, `requested_amount`, `approved_amount`, `reason_for_withdrawal`, `eligibility_status`, `withdrawal_status`, `requested_at`, `processed_at`) VALUES
(1, 3, 5, 2000.00, 2000.00, 'Medical emergency support', 'eligible', 'processed', '2026-03-10 17:57:20', '2026-03-10 17:57:20');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`activity_id`),
  ADD KEY `fk_activity_user` (`user_id`),
  ADD KEY `fk_activity_goal` (`goal_id`);

--
-- Indexes for table `bonuses`
--
ALTER TABLE `bonuses`
  ADD PRIMARY KEY (`bonus_id`),
  ADD UNIQUE KEY `transaction_id` (`transaction_id`),
  ADD KEY `fk_bonus_goal` (`goal_id`);

--
-- Indexes for table `goal_categories`
--
ALTER TABLE `goal_categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_name` (`category_name`);

--
-- Indexes for table `otp_verifications`
--
ALTER TABLE `otp_verifications`
  ADD PRIMARY KEY (`otp_id`),
  ADD KEY `fk_otp_user` (`user_id`);

--
-- Indexes for table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`payment_method_id`);

--
-- Indexes for table `savings_goals`
--
ALTER TABLE `savings_goals`
  ADD PRIMARY KEY (`goal_id`),
  ADD KEY `fk_goal_user` (`user_id`),
  ADD KEY `fk_goal_category` (`category_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transaction_id`),
  ADD UNIQUE KEY `transaction_reference` (`transaction_reference`),
  ADD KEY `fk_transaction_goal` (`goal_id`),
  ADD KEY `fk_transaction_user` (`user_id`),
  ADD KEY `fk_transaction_payment_method` (`payment_method_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `withdrawals`
--
ALTER TABLE `withdrawals`
  ADD PRIMARY KEY (`withdrawal_id`),
  ADD UNIQUE KEY `transaction_id` (`transaction_id`),
  ADD KEY `fk_withdrawal_goal` (`goal_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `activity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `bonuses`
--
ALTER TABLE `bonuses`
  MODIFY `bonus_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `goal_categories`
--
ALTER TABLE `goal_categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `otp_verifications`
--
ALTER TABLE `otp_verifications`
  MODIFY `otp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `payment_method_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `savings_goals`
--
ALTER TABLE `savings_goals`
  MODIFY `goal_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `withdrawals`
--
ALTER TABLE `withdrawals`
  MODIFY `withdrawal_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `fk_activity_goal` FOREIGN KEY (`goal_id`) REFERENCES `savings_goals` (`goal_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_activity_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `bonuses`
--
ALTER TABLE `bonuses`
  ADD CONSTRAINT `fk_bonus_goal` FOREIGN KEY (`goal_id`) REFERENCES `savings_goals` (`goal_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_bonus_transaction` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `otp_verifications`
--
ALTER TABLE `otp_verifications`
  ADD CONSTRAINT `fk_otp_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `savings_goals`
--
ALTER TABLE `savings_goals`
  ADD CONSTRAINT `fk_goal_category` FOREIGN KEY (`category_id`) REFERENCES `goal_categories` (`category_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_goal_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `fk_transaction_goal` FOREIGN KEY (`goal_id`) REFERENCES `savings_goals` (`goal_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transaction_payment_method` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`payment_method_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transaction_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `withdrawals`
--
ALTER TABLE `withdrawals`
  ADD CONSTRAINT `fk_withdrawal_goal` FOREIGN KEY (`goal_id`) REFERENCES `savings_goals` (`goal_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_withdrawal_transaction` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
