#Example use:
# xs = [1, 2, 3]
# ys = [4, 5, 6]
# linear_regression = LinearRegression.new(xs, ys)
# slope = linear_regression.slope
# intercept = linear_regression.y_intercept
class LinearRegression
  def initialize(xs, ys)
    @xs, @ys = xs, ys.map{|y| transform_y(y)}
    if @xs.length != @ys.length
      raise "Unbalanced data. xs need to be same length as ys"
    end
    @slope = calculate_slope
    @y_intercept = calculate_y_intercept
  end

  def transform_y(y)
    y
  end

  def predict(x)
    y_intercept + slope * x.to_f
  end

  def slope
    @slope
  end

  def y_intercept
    @y_intercept
  end

  def mean(array)
    array.inject(&:+) / array.length.to_f
  end

  def calculate_y_intercept
    mean(@ys) - (slope * mean(@xs))
  end

  def r_squared
    ssr = 0.0
    sst = 0.0
    y_mean = mean(@ys)
    @ys.each_with_index do |y, index|
      ssr += (transform_y(predict(@xs[index])) - y_mean) ** 2
      sst += (y - y_mean) ** 2
    end
    return 0.0 if sst == 0
    ssr / sst
  end

  def slope=(b)
    @slope = b
  end
 
  def calculate_slope
    x_mean = mean(@xs)
    y_mean = mean(@ys)
 
    numerator = (0...@xs.length).reduce(0) do |sum, i|
      sum + ((@xs[i] - x_mean) * (@ys[i] - y_mean))
    end
 
    denominator = @xs.reduce(0) do |sum, x|
      sum + ((x - x_mean) ** 2)
    end
 
    numerator / denominator
  end
end