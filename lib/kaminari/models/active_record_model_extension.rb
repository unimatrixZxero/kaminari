require File.join(File.dirname(__FILE__), 'active_record_relation_methods')

module Kaminari
  module ActiveRecordModelExtension
    extend ActiveSupport::Concern

    included do
      self.send(:include, Kaminari::ConfigurationMethods)

      # Fetch the values at the specified page number
      #   Model.page(5)
      # "namespace" the page scope
      self.scope :kaminari_page, Proc.new {|num|
        limit(default_per_page).offset(default_per_page * ([num.to_i, 1].max - 1))
      } do
        include Kaminari::ActiveRecordRelationMethods
        include Kaminari::PageScopeMethods
      end
    end
  end
end
