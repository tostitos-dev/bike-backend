# frozen_string_literal: true

# Background task for import data for every company
class ImportTelemetryJob < ApplicationJob
  queue_as :default

  def perform
    Company.all.each { |c| Citybik::CitybikImporter.new(c).import! }
  end
end
