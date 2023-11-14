-- Users Table
CREATE TABLE `users` (
  `user_id` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL, -- Store encrypted passwords
  `role` ENUM('Farmer', 'Investor', 'Administrator') NOT NULL,
  `phone` VARCHAR(20),
  `address` VARCHAR(255),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Farms Table
CREATE TABLE `farms` (
  `farm_id` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL,
  `location` VARCHAR(255),
  `size` DECIMAL(10,2), -- Size in acres or hectares
  `type` VARCHAR(100),
  `owner_id` INT NOT NULL,
  FOREIGN KEY (`owner_id`) REFERENCES `users`(`user_id`),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Crops Table
CREATE TABLE `crops` (
  `crop_id` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL,
  `type` VARCHAR(100),
  `planting_date` DATE,
  `harvest_date` DATE,
  `farm_id` INT NOT NULL,
  FOREIGN KEY (`farm_id`) REFERENCES `farms`(`farm_id`)
);

-- Livestock Table
CREATE TABLE `livestock` (
  `livestock_id` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  `type` VARCHAR(100) NOT NULL,
  `number` INT,
  `farm_id` INT NOT NULL,
  FOREIGN KEY (`farm_id`) REFERENCES `farms`(`farm_id`)
);

-- Equipment Table
CREATE TABLE `equipment` (
  `equipment_id` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  `type` VARCHAR(100) NOT NULL,
  `purchase_date` DATE,
  `farm_id` INT NOT NULL,
  FOREIGN KEY (`farm_id`) REFERENCES `farms`(`farm_id`)
);

-- Transactions Table
CREATE TABLE `transactions` (
  `transaction_id` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  `type` ENUM('sale', 'purchase') NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `date` DATE NOT NULL,
  `user_id` INT NOT NULL,
  `farm_id` INT, -- Optional, may not always be linked to a farm
  FOREIGN KEY (`user_id`) REFERENCES `users`(`user_id`),
  FOREIGN KEY (`farm_id`) REFERENCES `farms`(`farm_id`)
);

-- Surveys Table
CREATE TABLE `surveys` (
  `survey_id` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT,
  `creation_date` DATE NOT NULL,
  `user_id` INT NOT NULL,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`user_id`)
);

-- Survey Responses Table
CREATE TABLE `survey_responses` (
  `response_id` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  `survey_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `response_content` TEXT,
  FOREIGN KEY (`survey_id`) REFERENCES `surveys`(`survey_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`user_id`)
);