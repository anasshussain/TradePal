// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> subscribe(
  String table,
  String filterColumn,
  String filterValue,
  String eventType,
  Future Function() callbackAction,
) async {
  try {
    PostgresChangeEvent event;
    debugPrint("Event type is ${eventType}");
    debugPrint("filterColumn is ${filterColumn}");
    debugPrint("filterValue is ${filterValue}");
    switch (eventType.toLowerCase()) {
      case 'insert':
        event = PostgresChangeEvent.insert;
        break;

      case 'update':
        event = PostgresChangeEvent.update;
        break;

      case 'delete':
        event = PostgresChangeEvent.delete;
        break;

      default:
        event = PostgresChangeEvent.all;
    }

    SupaFlow.client
        .channel('public:$table')
        .onPostgresChanges(
            event: event,
            schema: 'public',
            table: table,
            filter: PostgresChangeFilter(
              type: PostgresChangeFilterType.eq,
              column: filterColumn,
              value: filterValue,
            ),
            callback: (payload) async {
              print('Your payload is $payload');
              if (table == "proposal_payments") {
                final status = payload.newRecord['payment_status'];
                final jobId = payload.newRecord['job_id']?.toString();
                print('Your jobid is $jobId');
                if (status == 'paid' && jobId != null) {
                  print('Flutterflow app state execution started successfully');
                  FFAppState().update(() {
                    FFAppState().paidJobId = jobId;
                    print('Flutterflow app state updated successfully');
                  });

                  await callbackAction();
                }
              } else {
                await callbackAction();
              }
            })
        .subscribe();
    print(
      'Subscribed to $table where $filterColumn = $filterValue',
    );
  } catch (e) {
    print('Error subscribing to $table: $e');
  }
}
