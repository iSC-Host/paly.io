# helpers

def gen_rand size=6
  charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
  (0...size).map{ charset.to_a[rand(charset.size)] }.join
end

def fetch_url key
  Link.first(:shortkey => key.upcase)
end

def key_exists? key
  fetch_url(key) != nil
end

def save_url key, url
  Link.create(:shortkey => key, :url => url)
end

def gen_key size=6, num_attempts=0
  attempt = gen_rand size
  if key_exists? attempt
    return gen_key size+1 if num_attempts > 9
    return gen_key size, num_attempts + 1
  else
    return attempt
  end
end

def valid_custom_key? key
  exp = /^([\w]|-){5,}$/ #five or more letters/digits/underscores/dashes

  return (key =~ exp) == 0 && !key_exists?(key)
end

def method_missing(meth, *args, &block)
  if meth.to_s =~ /^gen_(.+)_response$/
    generic_response($1, *args)
  else
    super
  end
end

def generic_response type, *args
  { :response_type => type.to_sym, :success => args[0], :response => args[1], :comment => args[2] }
end