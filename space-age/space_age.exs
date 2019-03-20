defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.

  - Earth: orbital period 365.25 Earth days, or 31557600 seconds
  - Mercury: orbital period 0.2408467 Earth years
  - Venus: orbital period 0.61519726 Earth years
  - Mars: orbital period 1.8808158 Earth years
  - Jupiter: orbital period 11.862615 Earth years
  - Saturn: orbital period 29.447498 Earth years
  - Uranus: orbital period 84.016846 Earth years
  - Neptune: orbital period 164.79132 Earth years

  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(:earth, seconds), do: seconds / 31_557_600
  def age_on(:mercury, seconds), do: age_on(:earth, seconds) / 0.2408467
  def age_on(:venus, seconds), do: age_on(:earth, seconds) / 0.61519726
  def age_on(:mars, seconds), do: age_on(:earth, seconds) / 1.8808158
  def age_on(:jupiter, seconds), do: age_on(:earth, seconds) / 11.862615
  def age_on(:saturn, seconds), do: age_on(:earth, seconds) / 29.4474987
  def age_on(:uranus, seconds), do: age_on(:earth, seconds) / 84.016846
  def age_on(:neptune, seconds), do: age_on(:earth, seconds) / 164.79132
end
