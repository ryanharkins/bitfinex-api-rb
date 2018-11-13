require_relative '../../../lib/bitfinex.rb'

client = Bitfinex::WSv2.new({
  :url => ENV['WS_URL'],
  :transform => true
})

client.on(:public_trades) do |sym, msg|
  puts "recv public trades message for symbol #{sym}"

  if msg.kind_of?(Array)
    puts msg.map { |t| t.serialize.join('|') }
  else
    puts msg.serialize.join('|')
  end
end

client.on(:public_trade_entry) do |sym, msg|
  puts "recv public trade entry for symbol #{sym}"
  puts msg.serialize.join('|')
end

client.on(:public_trade_update) do |sym, msg|
  puts "recv public trade update for symbol #{sym}"
  puts msg.serialize.join('|')
end

client.on(:open) do
  client.subscribe_trades('tBTCUSD')
end

client.open!