-- Create notes table
CREATE TABLE notes
(id VARCHAR(36) PRIMARY KEY,
 user_id VARCHAR(20) NOT NULL,
 content TEXT,
 block_ids TEXT DEFAULT '[]',
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 sync_status TEXT DEFAULT 'pending',
 is_deleted BOOLEAN DEFAULT FALSE,
 synced_at TIMESTAMP NULL,
 base_hash TEXT NULL,
 merged_from_conflict BOOLEAN DEFAULT FALSE,
 deleted_at TIMESTAMP NULL,
 sync_version INTEGER DEFAULT 1,
 FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE);

-- Create indexes to improve query performance
CREATE INDEX idx_notes_user_id ON notes(user_id);
CREATE INDEX idx_notes_updated_at ON notes(updated_at);