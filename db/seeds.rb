Message.create(title: 'test title 1', content: 'test content 1')
Message.create(title: 'test title 2', content: 'test content 2')
Message.create(title: 'test title 3', content: 'test content 3')

(1..100).each do |number|
  Message.create(title: 'test title ' + number.to_s, content: 'test content ' + number.to_s)
end