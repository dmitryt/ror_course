require 'data_mapper'

class Log
	include DataMapper::Resource

	property :id, Serial
	property :ip, String
	property :datetime, DateTime
end

DataMapper.finalize