local _config = (import 'config-instana.libsonnet');
{
  accessRules: [
    {
      accessType: 'READ_WRITE',
      relationType: 'USER',
      relatedId: _config.instana.userId,
    },
    {
      accessType: 'READ_WRITE',
      relatedId: _config.instana.apiTokenRelationId,
      relationType: 'API_TOKEN',
    },
    {
      accessType: 'READ',
      relationType: 'GLOBAL',
      relatedId: '',
    },
  ],
}
