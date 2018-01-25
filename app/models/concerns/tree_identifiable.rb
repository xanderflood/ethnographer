module TreeIdentifiable
  extend ActiveSupport::Concern

  included do
    before_create :set_uuid
  end

  private
  ### callbacks ###
  def set_uuid
    self.uuid = "#{uuid_base}#{next_chars}"
  end

  def uuid_base
    if self.parent
      self.parent.uuid
    else
      group_field = self.class.class_variable_get(:@@group_field)
      if group_field
        base = "#{self[group_field]}-"
      else
        ""
      end
    end
  end

  def next_chars
    num = self.culture.units.where(parent: self.parent).count
    g = self.generation

    if g % 2 == 0
      str = ""
      chars = ("A".."Z").to_a
      loop do
        str = str + chars[(num % 26)]
        num = num / 26
        break if num == 0
      end

      str
    else
      num.to_s
    end
  end

  class_methods do
    # Prepend this field to UUIDs
    # You should make sure to call 'inherits' with this same field
    def uuid_group_field group_field
      self.class_variable_set(:@@group_field, group_field)
    end
  end
end