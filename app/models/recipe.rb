class Recipe
  # def initialize(title:, difficulty:, recipe_type:, cuisine:, cook_time:,
  #                ingredients:, cook_method:, user:, status:)
  # end

  attr_reader :id, :title, :difficulty, :recipe_type, :cuisine, :cook_time,
              :ingredients, :cook_method, :user, :status

  def initialize(**args)
    args.each do |key, value|
      instance_variable_set("@#{key.to_s}", value)
    end
  end

  def self.find(id)
    response = Cookbook.client.get do |req|
      req.url "recipes/#{id}"
    end
    return new(response.body) if response.status == 200
  end

  def self.all
    response = Cookbook.client.get do |req|
      req.url "recipes"
    end
    return response.body.map { |recipe| new(recipe) } if response.status == 200

    []
  end
end
