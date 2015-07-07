# Annotator class does all the main job: parses out comments
# and returns annotated code


# Main module
module Murdoc
  class Annotator
    # Attribute accessor containing the resulting paragraphs
    attr_accessor :paragraphs

    # Options
    # Available options:
    #   `:highlight_source` -- highlights source syntax using pygments (default: true)
    attr_accessor :options

    def self.default_options
      {
          :highlight_source => true
      }
    end


    # `source` string contains annotated source code
    # `source_type` is one of supported source types (currently `[:ruby, :javascript]`)
    def initialize(source, source_type, options = {})
      self.source_type = source_type
      self.options     = self.class.default_options.merge(options)
      self.source      = source
    end


    # You may also initialize annotator from file, it will even try to detect the
    # source type from extension.
    def self.from_file(filename, source_type = nil, options = {})
      self.new(File.read(filename),
               source_type || detect_source_type_from_filename(filename),
               options.merge(:filename => filename))
    end

    def source_type
      @source_type
    end

    def source_type=(source_type)
      @source_type = source_type.to_s
    end

    # Big and hairy code parser
    def source=(src)
      @source = src
      @paragraphs = []
      lines = src.split("\n")

      # splitting stuff into lines and setting cursor into initial position
      i = 0
      source_lines_counter = 0
      while i < lines.size
        comment_lines = []
        # get single line comments
        if comment_symbols[:single_line]
          while i < lines.size && lines[i] =~ /^\s*#{Regexp.escape(comment_symbols[:single_line])}(.*)/
            comment_lines << $1
            i += 1
          end
        end

        # getting multiline comments
        if comment_symbols[:multiline]
          begin_symbol = Regexp.escape(comment_symbols[:multiline][:begin])
          end_symbol = Regexp.escape(comment_symbols[:multiline][:end])
          if i < lines.size && lines[i] =~ /\s*#{begin_symbol}/
            begin
              match = lines[i].match /\s*(#{begin_symbol})?\s?(.*?)(#{end_symbol}|$)/
              comment_lines << match[2]
              i += 1
            end while i < lines.size && !(lines[i-1] =~ /\s*#{end_symbol}/)
          end
        end

        # getting source lines
        source_lines = []
        starting_line = if options[:do_not_count_comment_lines]
          source_lines_counter
        else
          i
        end

        while i < lines.size && !is_comment(lines[i])
          source_lines << lines[i]
          source_lines_counter += 1
          i += 1
        end

        # post-processing: stripping comments and removing empty strings from beginnings and ends
        starting_line += postprocess_source(source_lines)
        postprocess_comments(comment_lines)
        # clear comment lines if that's commented out code
        comment_lines.clear if comment_lines[0] =~ /^:code:$/

        # if we have comments or source
        if comment_lines.size > 0 || source_lines.size > 0
          @paragraphs << Paragraph.new(source_lines.join("\n"),
                                       comment_lines.join("\n"),
                                       starting_line,
                                       source_type,
                                       options)
        end
      end
    end

    # Rest of the file quite less self-explanatory
    def source
      @source
    end

  protected
    def comment_symbols
      super || {}
    end

    # Method for checking source for comments. Used for getting consequent non-comments
    # into resulting stream
    def is_comment(line)
      result = false
      # If source supports single line comments
      if comment_symbols[:single_line]
        result ||= line =~ /^\s*#{Regexp.escape(comment_symbols[:single_line])}/
      end

      # If source supports multi-line comments
      if comment_symbols[:multiline]
        result ||= line =~ /^\s*#{Regexp.escape(comment_symbols[:multiline][:begin])}/
      end
      result
    end

    #
    # Removes trailing spaces from comments, also removes first space from comments,
    # but only if there's only one space there (not to mess with markdown)
    #
    def postprocess_comments(comment_lines)
      comment_lines.map! {|l| l.sub(/^\s([^\s])/, '\\1').rstrip }
      comment_lines.delete_at(0) while comment_lines.size > 0 && comment_lines[0].empty?
      comment_lines.delete_at(-1) while comment_lines.size > 0 && comment_lines[-1].empty?
    end


    # Removes blank lines from beginning and end of source lines
    # returns starting offset for source (number of lines deleted from beginning)
    def postprocess_source(source_lines)
      starting_offset = 0
      while source_lines.size > 0 && source_lines[0] =~ /^\s*$/
        starting_offset += 1
        source_lines.delete_at(0)
      end

      while source_lines.size > 0 && source_lines[-1] =~ /^\s*$/
        source_lines.delete_at(-1)
      end
      starting_offset
    end
  end
end
