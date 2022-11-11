# frozen_string_literal: true

# Enables the use of `let` syntax on controllers
#
# This is a technique I really like! Definitely a style choice, so I'm not committed
# to using it everywhere. What it does is allows you to declare simple helper methods
# for the underlying views, and easily override them in inheriting controllers.
#
# If you're interested, there are some more details available here:
# https://medium.com/@eric.programmer/striving-towards-maintainable-controllers-bac186c66429
module Lettable
  def let(name, &blk)
    iv = "@#{name}"

    # create the method on the controller
    define_method name do
      return instance_variable_get iv if instance_variable_defined? iv

      instance_variable_set iv, instance_eval(&blk)
    end

    # add the method as a helper for the view
    helper_method name

    define_method :"#{name}=" do |value|
      instance_variable_set iv, value
    end

    # prevent writing to the attribute on the view
    private :"#{name}="
  end
end
