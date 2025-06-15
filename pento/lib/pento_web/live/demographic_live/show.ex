defmodule PentoWeb.DemographicLive.Show do
  use Phoenix.Component
  import Phoenix.HTML
  alias Pento.Survey.Demographic
  import PentoWeb.CoreComponents
  attr(:demographic, Demographic, required: true)

  ### Deepseek Chat V3###
  def details(assigns) do
    ~H"""
    <div>
      <h2 class="font-medium text-2xl">
        Demographics {raw("&#x2713;")}
      </h2>
      <table id="demographics-table" class="w-full text-sm text-left text-gray-500">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50">
          <tr>
            <th scope="col" class="px-6 py-3">Gender</th>
            <th scope="col" class="px-6 py-3">Year of Birth</th>
          </tr>
        </thead>
        <tbody>
          <tr class="bg-white border-b">
            <td class="px-6 py-4"><%= @demographic.gender %></td>
            <td class="px-6 py-4"><%= @demographic.year_of_birth %></td>
          </tr>
        </tbody>
      </table>
    </div>
    """

    # ~H"""
    # <div>
    # <h2 class="font-medium text-2xl">
    # Demographics {raw("&#x2713;")}
    # </h2>
    # <ul>
    # <li>Gender: {@demographic.gender}</li>
    # <li>
    # Year of birth: {@demographic.year_of_birth}
    # </li>
    # </ul>
    # </div>
    # """
  end
end
