# encoding: UTF-8

Dir[File.expand_path('../../factories', __FILE__) + '/*.rb'].each do |factory|
  require factory
end

def Factory.build_via_new(name, attributes = {})
  attributes = Factory.attributes_for(name).merge(attributes)
  klass = FactoryGirl.factory_by_name(name).build_class
  klass.new(attributes)
end

##
# Override the default Factory() create alias method to build the attributes
# hash, then create them all though the new method. This gets around :required
# attribute issues in Hashie objects.
#
def Factory(name, attributes = {})
  Factory.build_via_new(name, attributes).save!
end