# Coffeescript language module
module Murdoc
  module Languages
    module Coffee
      module Annotator
        def self.included(base)
          base.extend ClassMethods
        end

        module ClassMethods
          protected
          def detect_source_type_from_filename(filename)
            if File.extname(filename) == ".coffee"
              :coffee
            else
              super if defined?(super)
            end
          end
        end
      end

      module CommentSymbols
        protected
        def comment_symbols
          if source_type == "coffee"
            {:single_line => "#", :multiline => {:begin => "###", :end => "###"}}
          else
            super if defined?(super)
          end
        end
      end
    end
  end

  class Annotator
    include Languages::Coffee::Annotator
    include Languages::Coffee::CommentSymbols
  end

  class Paragraph
    include Languages::Coffee::CommentSymbols
  end
end