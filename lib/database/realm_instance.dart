import 'package:cipherplant/database/app.dart';
import 'package:realm/realm.dart';
// import '/database/app.realm.dart' // ✅ Adjust this path if needed

// ✅ Realm configuration
final Configuration realmConfig = Configuration.local(
  [UserPlant.schema, Plant.schema],
  schemaVersion: 2, // 🔁 Increment this on every schema change
  migrationCallback: (migration, oldVersion) {
    print('Realm migrated from version $oldVersion to 2');
    // No manual object migration logic is supported yet in Flutter
  },
);

// ✅ Global Realm instance
final Realm realm = Realm(realmConfig);
