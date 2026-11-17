-- Schema inicial de referência. Revisar com o responsável técnico antes de produção.
-- Não executar até confirmar MySQL/MariaDB, versão e política de backup.
CREATE TABLE admin_users (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(140) NOT NULL,
 email VARCHAR(190) NOT NULL UNIQUE,
 password_hash VARCHAR(255) NOT NULL,
 role ENUM('owner','admin','editor','analyst') NOT NULL DEFAULT 'editor',
 is_active TINYINT(1) NOT NULL DEFAULT 1,
 last_login_at DATETIME NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE contacts (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 full_name VARCHAR(180) NOT NULL,
 email VARCHAR(254) NOT NULL,
 organization VARCHAR(180) NULL,
 category VARCHAR(80) NULL,
 source_name VARCHAR(180) NULL,
 source_url VARCHAR(1000) NULL,
 purpose VARCHAR(255) NULL,
 legal_basis VARCHAR(120) NULL,
 consent_status ENUM('unknown','consented','legitimate_interest_reviewed','objected','unsubscribed') NOT NULL DEFAULT 'unknown',
 consent_record TEXT NULL,
 collected_at DATETIME NULL,
 suppressed_at DATETIME NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 UNIQUE KEY uq_contact_email (email),
 KEY idx_contact_status (consent_status),
 KEY idx_contact_category (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE campaigns (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(180) NOT NULL,
 subject VARCHAR(255) NULL,
 body_html MEDIUMTEXT NULL,
 status ENUM('draft','review','scheduled','sending','sent','cancelled') NOT NULL DEFAULT 'draft',
 provider VARCHAR(80) NULL,
 scheduled_at DATETIME NULL,
 created_by BIGINT UNSIGNED NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 CONSTRAINT fk_campaign_user FOREIGN KEY (created_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE campaign_recipients (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 campaign_id BIGINT UNSIGNED NOT NULL,
 contact_id BIGINT UNSIGNED NOT NULL,
 delivery_status ENUM('pending','accepted','delivered','bounced','failed','unsubscribed') NOT NULL DEFAULT 'pending',
 provider_message_id VARCHAR(190) NULL,
 sent_at DATETIME NULL,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 UNIQUE KEY uq_campaign_contact (campaign_id,contact_id),
 CONSTRAINT fk_recipient_campaign FOREIGN KEY (campaign_id) REFERENCES campaigns(id) ON DELETE CASCADE,
 CONSTRAINT fk_recipient_contact FOREIGN KEY (contact_id) REFERENCES contacts(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE content_calendar (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 title VARCHAR(220) NOT NULL,
 channel VARCHAR(60) NOT NULL,
 topic VARCHAR(120) NULL,
 brief TEXT NULL,
 scheduled_for DATETIME NULL,
 status ENUM('idea','draft','review','approved','published','cancelled') NOT NULL DEFAULT 'idea',
 created_by BIGINT UNSIGNED NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT fk_content_user FOREIGN KEY (created_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE integrations (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 service_key VARCHAR(80) NOT NULL UNIQUE,
 display_name VARCHAR(140) NOT NULL,
 status ENUM('not_configured','pending','connected','error','disabled') NOT NULL DEFAULT 'not_configured',
 public_config JSON NULL,
 connected_at DATETIME NULL,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE audit_logs (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 admin_user_id BIGINT UNSIGNED NULL,
 action VARCHAR(120) NOT NULL,
 entity_type VARCHAR(80) NULL,
 entity_id BIGINT UNSIGNED NULL,
 ip_hash VARCHAR(128) NULL,
 details JSON NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT fk_audit_user FOREIGN KEY (admin_user_id) REFERENCES admin_users(id) ON DELETE SET NULL,
 KEY idx_audit_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
