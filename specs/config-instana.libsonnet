# General configuration options.
{
  instana: {
    baseUrl: std.extVar('INSTANA_BASE_URL'),
    userId: std.extVar('INSTANA_USER_ID'),
    apiTokenRelationId: std.extVar('INSTANA_API_TOKEN_RELATION_ID'),  // Allow API calls to delete the custom dashboard
  },
}
