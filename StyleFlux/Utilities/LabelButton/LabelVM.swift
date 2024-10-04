//
//  CategoryVM.swift
//  StyleFlux
//
//  Created by Deepinder on 2024-08-27.

import Foundation
import Observation

@Observable final class Label {

  var labels: [String]
  var selectedLabel: String

  init(labels: [String], selectedLabel: String = "All") {
    self.labels = labels
    self.selectedLabel = selectedLabel
  }

  func selectedLabel(_ label: String) {
    selectedLabel = label
  }
}
