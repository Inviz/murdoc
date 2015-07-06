# CSS language module
module Murdoc
  module Languages
    module CSS
      module Annotator
        def self.included(base)
          base.extend ClassMethods
        end

        module ClassMethods
          protected
          def detect_source_type_from_filename(filename)
            if File.extname(filename) == ".css"
              :css
            else
              super if defined?(super)
            end
          end
        end
      end

      module CommentSymbols
        protected
        def comment_symbols
          if source_type == "css"
            {:single_line => "//", :multiline => {:begin => "/*", :end => "*/"}}
          else
            super if defined?(super)
          end
        end
      end
    end
  end

  class Annotator
    include Languages::CSS::Annotator
    include Languages::CSS::CommentSymbols
  end

  class Paragraph
    include Languages::CSS::CommentSymbols
  end
end