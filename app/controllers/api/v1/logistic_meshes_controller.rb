module Api
  module V1
    class LogisticMeshesController < ApplicationController
      def create
        map = params[:logistic_meshes][:map]
        routes = params[:logistic_meshes][:routes]

        logistic_meshes_validator = LogisticMeshesValidator.call(map, routes)
        
        message = I18n.t('.logistic_meshes.create.invalid')
        return render json: message, status: :unprocessable_entity unless logistic_meshes_validator
        
        logistic_meshe = LogisticMeshe.create(logistic_meshe_params)
        logistic_meshes_serializer = LogisticMeshesSerializer.new(logistic_meshe)
        render json: logistic_meshes_serializer, status: :created
      end
    
      def search
        map = params[:map]
        source = params[:source]
        destination = params[:destination]
        autonomy_km = params[:autonomy_km]
        amount_liter = params[:amount_liter]
        
        search_route_validator = SearchRouteValidator.call(map, source,
                                                           destination,
                                                           autonomy_km,
                                                           amount_liter)
        
        message = I18n.t('.logistic_meshes.search.invalid')
        return render json: message, status: :unprocessable_entity unless logistic_meshes_validator

        search_route = SearchRouteService.call(map, source, destination, autonomy_km, amount_liter)
        
        render json: search_route, status: :ok
        
      end
    
      def logistic_meshe_params
        params.require(:logistic_meshes).permit(:map, routes: [])
      end
    end    
  end
end
