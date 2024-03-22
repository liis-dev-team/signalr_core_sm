class FirstResponseModel {
  final String url;
  final String connectionToken;
  final String connectionId;
  final double keepAliveTimeout;
  final double disconnectTimeout;
  final double connectionTimeout;
  final bool tryWebSockets;
  final String protocolVersion;
  final double transportConnectTimeout;
  final double longPollDelay;

  FirstResponseModel({
    required this.url,
    required this.connectionToken,
    required this.connectionId,
    required this.keepAliveTimeout,
    required this.disconnectTimeout,
    required this.connectionTimeout,
    required this.tryWebSockets,
    required this.protocolVersion,
    required this.transportConnectTimeout,
    required this.longPollDelay,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': this.url,
      'connectionToken': this.connectionToken,
      'connectionId': this.connectionId,
      'keepAliveTimeout': this.keepAliveTimeout,
      'disconnectTimeout': this.disconnectTimeout,
      'connectionTimeout': this.connectionTimeout,
      'tryWebSockets': this.tryWebSockets,
      'protocolVersion': this.protocolVersion,
      'transportConnectTimeout': this.transportConnectTimeout,
      'longPollDelay': this.longPollDelay,
    };
  }

  factory FirstResponseModel.fromMap(Map<String, dynamic> map) {
    return FirstResponseModel(
      url: map['Url'] as String,
      connectionToken: map['ConnectionToken'] as String,
      connectionId: map['ConnectionId'] as String,
      keepAliveTimeout: map['KeepAliveTimeout'] as double,
      disconnectTimeout: map['DisconnectTimeout'] as double,
      connectionTimeout: map['ConnectionTimeout'] as double,
      tryWebSockets: map['TryWebSockets'] as bool,
      protocolVersion: map['ProtocolVersion'] as String,
      transportConnectTimeout: map['TransportConnectTimeout'] as double,
      longPollDelay: map['LongPollDelay'] as double,
    );
  }
}
