// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import DatePickerController from "./date_picker_controller"
application.register("date-picker", DatePickerController)

import FilterController from "./filter_controller"
application.register("filter", FilterController)

import FlashController from "./flash_controller"
application.register("flash", FlashController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import ItemLabelsController from "./item_labels_controller"
application.register("item-labels", ItemLabelsController)

import LabelItemsController from "./label_items_controller"
application.register("label-items", LabelItemsController)

import ModalController from "./modal_controller"
application.register("modal", ModalController)

import NavBarController from "./nav_bar_controller"
application.register("nav-bar", NavBarController)

import NewUserStoreModalController from "./new_user_store_modal_controller"
application.register("new-user-store-modal", NewUserStoreModalController)

import PagerController from "./pager_controller"
application.register("pager", PagerController)

import ShoppingListItemsController from "./shopping_list_items_controller"
application.register("shopping-list-items", ShoppingListItemsController)

import ZipCodeController from "./zip_code_controller"
application.register("zip-code", ZipCodeController)
