module ApplicationHelper
  def is_active_controller(controller_name)
    params[:controller] == controller_name ? "active" : nil
  end

  def is_active_action(action_name)
    params[:action] == action_name ? "active" : nil
  end

  def main_subscription_link
    if current_user and current_user.in_trial
      info = <<-INFO
        <div class="alert alert-info">
          <strong> You are using trial account: </strong>
          You trial #{current_user.trial_expired? ?  'has been expired' : 'will expire'} on #{current_user.trial_ends_at.to_date},
          #{link_to "Click here","/pricing"} to upgrade subscription.
        </div>
      INFO
      info.html_safe
    end
  end

  def subscription_lnk plan
    if current_user
      user_subscription_lnk(plan)  
    else
      link_to "Login",new_user_session_path,class: "btn btn-primary btn-xl"
    end
  end

  # only called when user signed in
  def user_subscription_lnk plan
    current_subscription = current_user.current_subscription(plan.plan_type.downcase)
    if current_subscription.present?
      current_plan = current_subscription.plan
      if Plan.match_plan?(current_plan,plan)
        link_to "CURRENT","javascript:void(0);",class: "btn btn-default btn-xl"
      else
        if Plan.downgrade?(current_plan,plan)
          link_to "DOWNGRADE","javascript:void(0);",lnk: subscription_path(id: current_subscription.id,plan_id: plan.id,source: 'pricing'),method: :put,plan_id: plan.id,class: "btn btn-primary btn-xl subscription_lnk"
        else
          link_to "UPGRADE","javascript:void(0);",lnk: subscription_path(id: current_subscription.id,plan_id: plan.id,source: 'pricing'),method: :put,plan_id: plan.id,class: "btn btn-primary btn-xl subscription_lnk"
        end
      end
    else
      if current_user.stripe_customer_id.blank?
        link_to "SUBSCRIBE",new_subscription_path(plan_id: plan.stripe_id),plan_id: plan.id,class: "btn btn-primary btn-xl"
      else
        link_to "SUBSCRIBE","javascript:void(0);",lnk: subscriptions_path(plan_id: plan.id,source: "pricing"),method: :post,plan_id: plan.id,class: "btn btn-primary btn-xl subscription_lnk"
      end
    end
  end
end
