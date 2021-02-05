require 'shrine'
require 'shrine/storage/file_system'

Shrine.storages = {
  # temporary storage
  cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'),

  # permanent storage
  store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/store'),
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for forms
