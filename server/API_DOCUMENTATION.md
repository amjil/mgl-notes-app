# Notes Sync Service API Documentation

## Overview

This is a Clojure-based notes synchronization service that provides CRUD operations for notes and tags, as well as synchronization functionality.

## Basic Information

- **Base URL**: `/api`
- **Content Type**: `application/json`
- **Time Format**: ISO 8601 (e.g.: `2024-01-01T00:00:00`)

## Database Schema

### Users Table (users)
- `id`: User ID (Primary Key)
- `first_name`: First Name
- `last_name`: Last Name
- `email`: Email
- `admin`: Is Admin
- `last_login`: Last Login Time
- `is_active`: Is Active
- `pass`: Password

### Notes Table (notes)
- `id`: Note ID (Primary Key)
- `user_id`: User ID (Foreign Key)
- `title`: Title
- `content`: Content
- `created_at`: Created Time
- `updated_at`: Updated Time
- `is_deleted`: Is Deleted (Soft Delete)
- `sync_version`: Sync Version

### Tags Table (tags)
- `id`: Tag ID (Primary Key)
- `user_id`: User ID (Foreign Key)
- `name`: Tag Name
- `color`: Tag Color (Default: #007AFF)
- `created_at`: Created Time
- `updated_at`: Updated Time
- `is_deleted`: Is Deleted (Soft Delete)
- `sync_version`: Sync Version

### Note Tags Association Table (note_tags)
- `id`: Association ID (Primary Key)
- `note_id`: Note ID (Foreign Key)
- `tag_id`: Tag ID (Foreign Key)
- `created_at`: Created Time

## API Endpoints

### 1. Notes Related Endpoints

#### 1.1 Get All User Notes
```
GET /api/notes?user_id={user_id}
```

**Parameters:**
- `user_id` (Required): User ID

**Response:**
```json
{
  "notes": [
    {
      "id": "note-uuid",
      "user_id": "user123",
      "title": "Note Title",
      "content": "Note Content",
      "created_at": "2024-01-01T00:00:00",
      "updated_at": "2024-01-01T00:00:00",
      "is_deleted": false,
      "sync_version": 1
    }
  ],
  "count": 1
}
```

#### 1.2 Get Single Note
```
GET /api/notes/{note_id}?user_id={user_id}
```

**Parameters:**
- `note_id` (Path): Note ID
- `user_id` (Query): User ID

**Response:**
```json
{
  "id": "note-uuid",
  "user_id": "user123",
  "title": "Note Title",
  "content": "Note Content",
  "created_at": "2024-01-01T00:00:00",
  "updated_at": "2024-01-01T00:00:00",
  "is_deleted": false,
  "sync_version": 1
}
```

#### 1.3 Create Note
```
POST /api/notes
```

**Request Body:**
```json
{
  "id": "note-uuid",
  "user_id": "user123",
  "title": "Note Title",
  "content": "Note Content",
  "sync_version": 1
}
```

**Response:**
```json
{
  "success": true,
  "id": "note-uuid"
}
```

#### 1.4 Update Note
```
PUT /api/notes/{note_id}
```

**Request Body:**
```json
{
  "user_id": "user123",
  "title": "Updated Title",
  "content": "Updated Content",
  "sync_version": 2
}
```

**Response:**
```json
{
  "success": true,
  "id": "note-uuid"
}
```

#### 1.5 Delete Note
```
DELETE /api/notes/{note_id}?user_id={user_id}&sync_version={sync_version}
```

**Parameters:**
- `note_id` (Path): Note ID
- `user_id` (Query): User ID
- `sync_version` (Query): Sync Version

**Response:**
```json
{
  "success": true,
  "id": "note-uuid"
}
```

### 2. Tags Related Endpoints

#### 2.1 Get All User Tags
```
GET /api/tags?user_id={user_id}
```

**Parameters:**
- `user_id` (Required): User ID

**Response:**
```json
{
  "tags": [
    {
      "id": "tag-uuid",
      "user_id": "user123",
      "name": "Tag Name",
      "color": "#007AFF",
      "created_at": "2024-01-01T00:00:00",
      "updated_at": "2024-01-01T00:00:00",
      "is_deleted": false,
      "sync_version": 1
    }
  ],
  "count": 1
}
```

#### 2.2 Get Single Tag
```
GET /api/tags/{tag_id}?user_id={user_id}
```

**Parameters:**
- `tag_id` (Path): Tag ID
- `user_id` (Query): User ID

**Response:**
```json
{
  "id": "tag-uuid",
  "user_id": "user123",
  "name": "Tag Name",
  "color": "#007AFF",
  "created_at": "2024-01-01T00:00:00",
  "updated_at": "2024-01-01T00:00:00",
  "is_deleted": false,
  "sync_version": 1
}
```

#### 2.3 Create Tag
```
POST /api/tags
```

**Request Body:**
```json
{
  "id": "tag-uuid",
  "user_id": "user123",
  "name": "Tag Name",
  "color": "#007AFF",
  "sync_version": 1
}
```

**Response:**
```json
{
  "success": true,
  "id": "tag-uuid"
}
```

#### 2.4 Update Tag
```
PUT /api/tags/{tag_id}
```

**Request Body:**
```json
{
  "user_id": "user123",
  "name": "Updated Tag Name",
  "color": "#FF0000",
  "sync_version": 2
}
```

**Response:**
```json
{
  "success": true,
  "id": "tag-uuid"
}
```

#### 2.5 Delete Tag
```
DELETE /api/tags/{tag_id}?user_id={user_id}&sync_version={sync_version}
```

**Parameters:**
- `tag_id` (Path): Tag ID
- `user_id` (Query): User ID
- `sync_version` (Query): Sync Version

**Response:**
```json
{
  "success": true,
  "id": "tag-uuid"
}
```

### 3. Note Tag Association Endpoints

#### 3.1 Add Tag to Note
```
POST /api/notes/{note_id}/tags/{tag_id}
```

**Parameters:**
- `note_id` (Path): Note ID
- `tag_id` (Path): Tag ID

**Response:**
```json
{
  "success": true,
  "id": "association-uuid"
}
```

#### 3.2 Remove Tag from Note
```
DELETE /api/notes/{note_id}/tags/{tag_id}
```

**Parameters:**
- `note_id` (Path): Note ID
- `tag_id` (Path): Tag ID

**Response:**
```json
{
  "success": true
}
```

#### 3.3 Get All Tags for Note
```
GET /api/notes/{note_id}/tags
```

**Parameters:**
- `note_id` (Path): Note ID

**Response:**
```json
{
  "tags": [
    {
      "id": "tag-uuid",
      "name": "Tag Name",
      "color": "#007AFF"
    }
  ],
  "count": 1
}
```

#### 3.4 Get All Notes with Specific Tag
```
GET /api/tags/{tag_id}/notes?user_id={user_id}
```

**Parameters:**
- `tag_id` (Path): Tag ID
- `user_id` (Query): User ID

**Response:**
```json
{
  "notes": [
    {
      "id": "note-uuid",
      "title": "Note Title",
      "content": "Note Content"
    }
  ],
  "count": 1
}
```

### 4. Sync Related Endpoints

#### 4.1 Get All Sync Data
```
GET /api/sync?user_id={user_id}&since={timestamp}
```

**Parameters:**
- `user_id` (Required): User ID
- `since` (Required): Start Time (ISO 8601 format)

**Response:**
```json
{
  "sync_data": [
    {
      "type": "note",
      "id": "note-uuid",
      "title": "Note Title",
      "content": "Note Content",
      "created_at": "2024-01-01T00:00:00",
      "updated_at": "2024-01-01T00:00:00",
      "sync_version": 1,
      "is_deleted": false
    },
    {
      "type": "tag",
      "id": "tag-uuid",
      "title": "Tag Name",
      "content": "#007AFF",
      "created_at": "2024-01-01T00:00:00",
      "updated_at": "2024-01-01T00:00:00",
      "sync_version": 1,
      "is_deleted": false
    }
  ],
  "count": 2
}
```

#### 4.2 Sync Notes Data
```
GET /api/sync/notes?user_id={user_id}&since={timestamp}
```

**Parameters:**
- `user_id` (Required): User ID
- `since` (Required): Start Time (ISO 8601 format)

**Response:**
```json
{
  "notes": [
    {
      "id": "note-uuid",
      "user_id": "user123",
      "title": "Note Title",
      "content": "Note Content",
      "created_at": "2024-01-01T00:00:00",
      "updated_at": "2024-01-01T00:00:00",
      "is_deleted": false,
      "sync_version": 1
    }
  ],
  "count": 1
}
```

#### 4.3 Sync Tags Data
```
GET /api/sync/tags?user_id={user_id}&since={timestamp}
```

**Parameters:**
- `user_id` (Required): User ID
- `since` (Required): Start Time (ISO 8601 format)

**Response:**
```json
{
  "tags": [
    {
      "id": "tag-uuid",
      "user_id": "user123",
      "name": "Tag Name",
      "color": "#007AFF",
      "created_at": "2024-01-01T00:00:00",
      "updated_at": "2024-01-01T00:00:00",
      "is_deleted": false,
      "sync_version": 1
    }
  ],
  "count": 1
}
```

## Error Responses

All endpoints return appropriate HTTP status codes and error messages when errors occur:

```json
{
  "error": "Error description"
}
```

Common status codes:
- `400 Bad Request`: Request parameter error
- `404 Not Found`: Resource not found
- `500 Internal Server Error`: Server internal error

## Usage Examples

### Create Note and Add Tag

1. Create note:
```bash
curl -X POST http://localhost:3000/api/notes \
  -H "Content-Type: application/json" \
  -d '{
    "id": "note-123",
    "user_id": "user-456",
    "title": "My First Note",
    "content": "This is the note content",
    "sync_version": 1
  }'
```

2. Create tag:
```bash
curl -X POST http://localhost:3000/api/tags \
  -H "Content-Type: application/json" \
  -d '{
    "id": "tag-789",
    "user_id": "user-456",
    "name": "Important",
    "color": "#FF0000",
    "sync_version": 1
  }'
```

3. Add tag to note:
```bash
curl -X POST http://localhost:3000/api/notes/note-123/tags/tag-789
```

4. Sync data:
```bash
curl "http://localhost:3000/api/sync?user_id=user-456&since=2024-01-01T00:00:00"
```

## Notes

1. All IDs should be in UUID format
2. Timestamps use ISO 8601 format
3. Soft deleted records are automatically filtered in queries
4. Sync version numbers are used for conflict detection and resolution
5. User ID is used for data isolation to ensure users can only access their own data 