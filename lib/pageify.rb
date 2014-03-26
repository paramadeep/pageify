require "pageify/parse"

class Pageify
  def self.load(base_dir)
    base_dir.chomp! '/'
    all_pages = []
    Dir["#{base_dir}/**/"].each do |dir|
      Dir["#{dir}/*.page"].each do |file|
        all_pages << file
      end
    end
  end
end
