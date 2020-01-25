module Api
  module V1
    class LogisticMeshesController < Api::V1::ApplicationController
      def create
        message = I18n.t('.logistic_meshes.create.invalid')
        return json_response({ message: message }, :unprocessable_entity) unless valid_create_route?

        logistic_mesh = LogisticMesh.create(logistic_mesh_params)
        logistic_meshes_serializer = LogisticMeshesSerializer.new(logistic_mesh)
        render json: logistic_meshes_serializer, status: :created
      end

      def search
        @map = params[:map].upcase
        message = I18n.t('.logistic_meshes.search.invalid')

        return json_response({ message: 'Not Found Map' }, :not_found) unless map_present?(@map)
        return json_response({ message: message }, :unprocessable_entity) unless valid_search_route?

        search_route = SearchRouteService.call(@map,
                                               @source,
                                               @destination,
                                               @autonomy_km,
                                               @amount_liter)

        render json: search_route, status: :ok
      end

      private

      def valid_create_route?
        @map = params[:logistic_meshes][:map].upcase
        @routes = params[:logistic_meshes][:routes].map(&:strip).map(&:upcase)
        LogisticMeshesValidator.call(@map, @routes)
      end

      def valid_search_route?
        @source = params[:source].upcase
        @destination = params[:destination].upcase
        @autonomy_km = params[:autonomy_km]
        @amount_liter = params[:amount_liter]

        SearchRouteValidator.call(@map,
                                  @source,
                                  @destination,
                                  @autonomy_km,
                                  @amount_liter)
      end

      def map_present?(map)
        LogisticMesh.find_by(map: map).present?
      end

      def logistic_mesh_params
        params.require(:logistic_meshes).permit(:map, routes: [])
      end
    end
  end
end
