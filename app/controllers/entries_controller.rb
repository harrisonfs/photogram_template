class EntriesController < ApplicationController
  before_action :current_user_must_be_entry_owner, :only => [:edit_form, :update_row, :destroy_row]

  def current_user_must_be_entry_owner
    entry = Entry.find(params["id_to_display"] || params["prefill_with_id"] || params["id_to_modify"] || params["id_to_remove"])

    unless current_user == entry.owner
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = Entry.ransack(params[:q])
    @entries = @q.result(:distinct => true).includes(:owner).page(params[:page]).per(10)

    render("entry_templates/index.html.erb")
  end

  def show
    @entry = Entry.find(params.fetch("id_to_display"))

    render("entry_templates/show.html.erb")
  end

  def new_form
    @entry = Entry.new

    render("entry_templates/new_form.html.erb")
  end

  def create_row
    @entry = Entry.new

    @entry.content = params.fetch("content")
    @entry.image = params.fetch("image") if params.key?("image")
    @entry.owner_id = params.fetch("owner_id")

    if @entry.valid?
      @entry.save

      redirect_back(:fallback_location => "/entries", :notice => "Entry created successfully.")
    else
      render("entry_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @entry = Entry.find(params.fetch("prefill_with_id"))

    render("entry_templates/edit_form.html.erb")
  end

  def update_row
    @entry = Entry.find(params.fetch("id_to_modify"))

    @entry.content = params.fetch("content")
    @entry.image = params.fetch("image") if params.key?("image")
    

    if @entry.valid?
      @entry.save

      redirect_to("/entries/#{@entry.id}", :notice => "Entry updated successfully.")
    else
      render("entry_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row_from_owner
    @entry = Entry.find(params.fetch("id_to_remove"))

    @entry.destroy

    redirect_to("/users/#{@entry.owner_id}", notice: "Entry deleted successfully.")
  end

  def destroy_row
    @entry = Entry.find(params.fetch("id_to_remove"))

    @entry.destroy

    redirect_to("/entries", :notice => "Entry deleted successfully.")
  end
end
