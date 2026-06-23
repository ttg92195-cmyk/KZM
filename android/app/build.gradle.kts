plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
}

def localProperties = new Properties()
def localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader("UTF-8") { reader ->
        localProperties.load(reader)
    }
}

def flutterVersionCode = localProperties.getProperty("flutter.versionCode") ?: "1"
def flutterVersionName = localProperties.getProperty("flutter.versionName") ?: "1.0.0"

def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.kzm.app"
    compileSdk = 34
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    defaultConfig {
        applicationId = "com.kzm.app"
        minSdk = 21
        targetSdk = 34
        versionCode = flutterVersionCode.toInteger()
        versionName = flutterVersionName
    }

    signingConfigs {
        create("release") {
            if (keystoreProperties["storeFile"] != null) {
                keyAlias = keystoreProperties["keyAlias"]
                keyPassword = keystoreProperties["keyPassword"]
                storeFile = file(keystoreProperties["storeFile"])
                storePassword = keystoreProperties["storePassword"]
            }
        }
    }

    buildTypes {
        release {
            // For CI builds without a keystore, fall back to debug signing
            // so the APK can still be produced. Replace with `signingConfig = signingConfigs.release`
            // once a keystore is provisioned.
            signingConfig = keystoreProperties["storeFile"] != null
                ? signingConfigs.release
                : signingConfigs.debug
            minifyEnabled = false
            shrinkResources = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}
