require 'fileutils'

namespace :draft do
  desc "Create a new draft post"
  task :new do
    puts "What will be the name for your next post?"
    @name = STDIN.gets.chomp
    puts "Enter space separated categories for your post"
    @categories = STDIN.gets.chomp
    puts "Enter space separated tags for your post"
    @tags = STDIN.gets.chomp
    @slug = "#{@name}"
    @slug = @slug.downcase.strip.gsub(' ', '-')
    FileUtils.touch("_drafts/#{@slug}.md")
    open("_drafts/#{@slug}.md", 'a' ) do |file|
      file.puts "---"
      file.puts "layout: post"
      file.puts "title: #{@name}"
      file.puts "description: maximum 155 char description"
      file.puts "categories: #{@categories}"
      file.puts "tags: #{@tags}"
      file.puts "---" 
    end
  end

  desc "copy draft to production post!"
  task :ready do
    puts "Posts in _drafts:"
    @drafts = Hash.new
    Dir.glob("_drafts/*.md").each_with_index do |index,fname|
      puts index, fname
    end
    puts "what's the name of the draft to post?"
    @post_name = STDIN.gets.chomp
    @post_date = Time.now.strftime("%F")
    FileUtils.mv("_drafts/#{@post_name}", "_posts/#{@post_name}")
    FileUtils.mv("_posts/#{@post_name}", "_posts/#{@post_date}-#{@post_name}")
    puts "Post copied and ready to deploy!"
  end

end

namespace :tags do
  desc "create tag pages"
  task :update do
    puts "update tags"
    parse = false
    all_tags = []
    Dir.glob("_posts/*.md").each_with_index do |fname, index|
      puts "#{index} => #{fname} -- #{parse}"
      File.readlines(fname).each do |line|
        if parse
          key,tags = line.split(':')
          if(key == 'tags')
            puts(tags)
            all_tags = all_tags + tags.strip.split(' ')
            parse = false
            break
          end
        end
        if (line.strip == '---' )
          if (not parse)
            parse = true
          else
            parse = false
            break
          end
        end
      end
    end

    Dir.glob("tag/*.md").each do |fname|
      File.delete(fname) if File.exist?(fname)
    end

    all_tags.each do |tag|
      FileUtils.touch("_drafts/#{tag}.md")
      open("tag/#{tag}.md", 'a' ) do |file|
        file.puts "---"
        file.puts "layout: tagpage"
        file.puts "title: Tag #{tag}"
        file.puts "description: All posts with tag #{tag}"
        file.puts "tag: #{tag}"
        file.puts "robots: noindex"
        file.puts "---" 
      end
    end

  end
end
