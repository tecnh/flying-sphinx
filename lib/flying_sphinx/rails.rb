if ENV['FLYING_SPHINX_IDENTIFIER'] || ENV['STAGED_SPHINX_IDENTIFIER']
  Rails.configuration.to_prepare :flying_sphinx do
    FlyingSphinx::Binary.load
  end
end
