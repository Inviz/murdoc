# GSS language module
module Murdoc
  module Languages
    module GSS
      module Annotator
        def self.included(base)
          base.extend ClassMethods
        end

        module ClassMethods
          protected
          def detect_source_type_from_filename(filename)
            if File.extname(filename) == ".gss"
              :gss
            else
              super if defined?(super)
            end
          end
        end
      end

      module CommentSymbols
        protected
        def comment_symbols
          if source_type == "gss"
            {:single_line => "//", :multiline => {:begin => "/*", :end => "*/"}}
          else
            super if defined?(super)
          end
        end
      end
    end
  end

  class Annotator
    include Languages::GSS::Annotator
    include Languages::GSS::CommentSymbols
  end

  class Paragraph
    include Languages::GSS::CommentSymbols
  end
end