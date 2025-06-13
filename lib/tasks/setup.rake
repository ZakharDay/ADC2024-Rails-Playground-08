namespace :setup do

  desc "Setup project"
  task all: :environment do

    @raw_text = 'Дом Наркомфина — один из знаковых памятников архитектуры советского авангарда и конструктивизма. Построен в 1928—1930 годах по проекту архитекторов Моисея Гинзбурга, Игнатия Милиниса и инженера Сергея Прохорова для работников Народного комиссариата финансов СССР (Наркомфина). Автор замысла дома Наркомфина Гинзбург определял его как «опытный дом переходного типа». Дом находится в Москве по адресу: Новинский бульвар, дом 25, корпус 1. С начала 1990-х годов дом находился в аварийном состоянии, был трижды включён в список «100 главных зданий мира, которым грозит уничтожение». В 2017—2020 годах отреставрирован по проекту АБ «Гинзбург Архитектс», функционирует как элитный жилой дом. Отдельно стоящий «Коммунальный блок» (историческое название) планируется как место проведения публичных мероприятий.'
    @words = @raw_text.downcase.gsub(/[—.—,«»:()]/, '').gsub(/  /, ' ').split(' ')
    @categories = ["керамика", "картина", "скульптура", "диджитал", "печатная графика"]
    @tags = ["cюрреализм", "нежность", "онтология", "природа", "повседневность", "философия", "жизнь", "цифра", "семантика"] 

    def seed
      create_users(5)
      create_products(100)
      create_pins(100)
      create_comments(2..8)
      create_likes
      
      5.times do
        create_comment_replies
      end

      create_galleries(2..5)
      create_gallery_images
    end

    def create_users(quantity)
      i = 0

      quantity.times do
        user_data = {
          email: "user_#{i}@email.com",
          password: "testtest"
        }

        # if i == 0
        #   user_data[:admin] = true
        # end

        user = User.create!(user_data)
        puts "User created with ID #{user.id} with JTI #{user.jti}"

        i += 1
      end
    end

    def create_sentence
      sentence_words = []

      (10..20).to_a.sample.times do
        sentence_words << @words.sample
      end

      sentence = sentence_words.join(' ').capitalize + '.'
    end

    def upload_random_image
      uploader = PinImageUploader.new(Pin.new, :pin_image)
      uploader.cache!(File.open(Dir.glob(File.join(Rails.root, 'public/autoupload/pins', '*')).sample))
      uploader
    end

    def create_pins(quantity)
      quantity.times do
        tag_list = @tags.sample(rand(1..3))
        category_list = @categories.sample

        pin = Pin.create!(
          title: create_sentence,
          description: create_sentence,
          pin_image: upload_random_image,
          tag_list: tag_list,
          category_list: category_list,
          user_id: User.all.sample.id
        )

        puts "Pin with id #{pin.id} just created"
      end
    end

    def create_comments(quantity)
      Pin.all.each do |pin|
        quantity.to_a.sample.times do
          comment = Comment.create(pin_id: pin.id, body: create_sentence, user: User.all.sample)
          puts "Comment with id #{comment.id} for pin with id #{comment.pin.id} just created"
        end
      end
    end

    def create_likes
      Pin.all.each do |pin|
        like = User.all.sample.likes.create(likeable_type: "Pin", likeable_id: pin.id)
        puts "Like just created"
      end
    end

    def create_comment_replies
      Comment.all.each do |comment|
        if rand(1..3) == 1
          comment_reply = comment.replies.create(pin_id: comment.pin_id, body: create_sentence, user: User.all.sample)
          puts "Comment reply with id #{comment_reply.id} for pin with id #{comment_reply.pin.id} just created"
        end
      end
    end

    def create_products(quantity)
      quantity.times do
        product = Product.create(
          name: create_sentence,
          description: create_sentence,
          price: rand(100..1000)
        )

        puts "Product with id #{product.id} just created"
      end
    end

    def create_galleries(quantity)
      quantity.to_a.sample.times do
        gallery = Gallery.create(
          name: create_sentence
        )

        puts "Gallery with id #{gallery.id} just created"
      end
    end

    def create_gallery_images
      Gallery.all.each do |gallery|
        rand(1..10).times do
          gallery_image = gallery.gallery_images.create!(
            image: upload_random_image
            # position
            # orientation
          )

          puts "GalleryImage with id #{gallery_image.id} just created"
        end
      end
    end

    seed

  end

end