export type Plan = 'trial' | 'starter' | 'growth' | 'scale';
export type PlanStatus = 'active' | 'paused' | 'cancelled';
export type IntegrationSource = 'shopify' | 'meta' | 'google' | 'tally_csv' | 'amazon' | 'zoho';
export type SyncStatus = 'pending' | 'syncing' | 'success' | 'error';
export type AlertSeverity = 'info' | 'warning' | 'critical';
export type AlertType = 'roas_drop' | 'creative_fatigue' | 'cash_low' | 'rto_spike' | 'gst_notice';

export interface Brand {
  id: string;
  name: string;
  founder_name: string | null;
  founder_phone: string | null;
  founder_email: string | null;
  plan: Plan;
  plan_status: PlanStatus;
  razorpay_subscription_id: string | null;
  mrr_inr: number;
  timezone: string;
  created_at: string;
  trial_ends_at: string;
}

export interface Integration {
  id: string;
  brand_id: string;
  source: IntegrationSource;
  access_token: string | null;
  refresh_token: string | null;
  shop_domain: string | null;
  account_id: string | null;
  last_synced_at: string | null;
  sync_status: SyncStatus;
  error_message: string | null;
  metadata: Record<string, unknown>;
  created_at: string;
}

export interface MetricDaily {
  id: string;
  brand_id: string;
  date: string;
  source: string;
  metric_key: string;
  metric_value: number | null;
  metadata: Record<string, unknown>;
}

export interface ChatMessage {
  role: 'user' | 'assistant';
  content: string;
  timestamp?: string;
}

export interface Conversation {
  id: string;
  brand_id: string;
  messages: ChatMessage[];
  created_at: string;
  updated_at: string;
}

export interface Alert {
  id: string;
  brand_id: string;
  alert_type: AlertType | string;
  severity: AlertSeverity;
  message: string;
  data: Record<string, unknown>;
  triggered_at: string;
  resolved_at: string | null;
  notified_whatsapp: boolean;
}

export interface BrandContext {
  brand_id: string;
  key_skus: string[];
  target_roas: number;
  monthly_ad_budget_inr: number | null;
  competitors: string[];
  primary_channels: string[];
  business_notes: string | null;
  updated_at: string;
}

export interface SkuMetric {
  sku: string;
  title: string;
  revenue: number;
  units_sold: number;
  orders: number;
}

export interface CreativeMetric {
  creative_id: string;
  name: string;
  spend: number;
  roas: number;
  ctr: number;
  impressions: number;
  clicks: number;
}

export interface Database {
  public: {
    Tables: {
      brands: {
        Row: Brand;
        Insert: Omit<Brand, 'id' | 'created_at'>;
        Update: Partial<Omit<Brand, 'id'>>;
      };
      integrations: {
        Row: Integration;
        Insert: Omit<Integration, 'id' | 'created_at'>;
        Update: Partial<Omit<Integration, 'id'>>;
      };
      metrics_daily: {
        Row: MetricDaily;
        Insert: Omit<MetricDaily, 'id'>;
        Update: Partial<Omit<MetricDaily, 'id'>>;
      };
      conversations: {
        Row: Conversation;
        Insert: Omit<Conversation, 'id' | 'created_at' | 'updated_at'>;
        Update: Partial<Omit<Conversation, 'id'>>;
      };
      alerts: {
        Row: Alert;
        Insert: Omit<Alert, 'id' | 'triggered_at'>;
        Update: Partial<Omit<Alert, 'id'>>;
      };
      brand_context: {
        Row: BrandContext;
        Insert: Omit<BrandContext, 'updated_at'>;
        Update: Partial<BrandContext>;
      };
    };
  };
}
