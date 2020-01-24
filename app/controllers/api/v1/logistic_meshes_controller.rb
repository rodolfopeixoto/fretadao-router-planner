module Api
  module V1
    class LogisticMeshesController < ApplicationController
      def create
        map = params[:logistic_meshes][:map]
        routes = params[:logistic_meshes][:routes]
        binding.pry
        logistic_meshes_validator = LogisticMeshesValidator.call(map, routes)
        
        message = I18n.t('.logistic_meshes.create.invalid')
        return render json: message, status: :unprocessable_entity unless logistic_meshes_validator
        
        logistic_meshe = LogisticMeshe.create(logistic_meshe_params)
        logistic_meshes_serializer = LogisticMeshesSerializer.new(logistic_meshe)
        render json: logistic_meshes_serializer, status: :created
      end
    
      def search
      end
    
      def logistic_meshe_params
        params.require(:logistic_meshes).permit(:map, routes: [])
      end
    end    
  end
end
