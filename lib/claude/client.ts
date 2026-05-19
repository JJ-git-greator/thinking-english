import Anthropic from "@anthropic-ai/sdk";

let _client: Anthropic | null = null;

export function claude() {
  if (!_client) {
    _client = new Anthropic({ apiKey: process.env.ANTHROPIC_API_KEY! });
  }
  return _client;
}

export const MODELS = {
  cheap: "claude-haiku-4-5-20251001",
  smart: "claude-sonnet-4-6",
} as const;
