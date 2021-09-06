class DistanceCalc
  def initialize(params)
    @address1 = params[:address1]
    @address2 = params[:address2]
  end

  def calculate
    coordinates1 = Geocoder.coordinates(@address1)
    coordinates2 = Geocoder.coordinates(@address2)
    Geocoder::Calculations.distance_between(coordinates1, coordinates2, units: :km).round(2)
  end
end
