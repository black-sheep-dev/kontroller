#ifndef EU_TGCM_KONTROLLER_SERVER_H
#define EU_TGCM_KONTROLLER_SERVER_H

#include <QObject>
#include <QStringList>
#include <QVariantMap>

#include "volumeplugin.h"

namespace eu
{
namespace tgcm
{
namespace kontroller
{

class Server : public QObject
{
	Q_OBJECT
	QString serverAddress_;
	int serverPort_ = 9090;
	int serverHttpPort_ = 8080;
	QString name_;
	bool hasZones_ = false;
	QStringList zones_;
	QString uuid_;

	QString login_;

	QString password_;

	QString volumePluginName_;

	QVariantMap volumePluginParameters_;

	QString wakeUpPluginName_;

	QVariantMap wakeUpPluginParameters_;

public:
	explicit Server(QObject *parent = nullptr);
	Q_PROPERTY(QString serverAddress READ serverAddress WRITE setServerAddress NOTIFY serverAddressChanged)
	Q_PROPERTY(int serverPort READ serverPort WRITE setServerPort NOTIFY serverPortChanged)
	Q_PROPERTY(int serverHttpPort READ serverHttpPort WRITE setServerHttpPort NOTIFY serverHttpPortChanged)
	Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
	Q_PROPERTY(bool hasZones READ hasZones WRITE setHasZones NOTIFY hasZonesChanged)
	Q_PROPERTY(QStringList zones READ zones WRITE setZones NOTIFY zonesChanged)
	Q_PROPERTY(QString uuid READ uuid WRITE setUuid NOTIFY uuidChanged)
	Q_PROPERTY(QString login READ login WRITE setLogin NOTIFY loginChanged)
	Q_PROPERTY(QString password READ password WRITE setPassword NOTIFY passwordChanged)
	Q_PROPERTY(QString volumePluginName READ volumePluginName WRITE setVolumePluginName \
	           NOTIFY volumePluginNameChanged)
	Q_PROPERTY(QVariantMap volumePluginParameters READ volumePluginParameters WRITE setVolumePluginParameters \
	           NOTIFY volumePluginParametersChanged)
	Q_PROPERTY(QString wakeUpPluginName READ wakeUpPluginName WRITE setWakeUpPluginName NOTIFY wakeUpPluginNameChanged)
	Q_PROPERTY(QVariantMap wakeUpPluginParameters READ wakeUpPluginParameters WRITE setWakeUpPluginParameters NOTIFY
	               wakeUpPluginParametersChanged)
	QString serverAddress() const;

	int serverPort() const;

	int serverHttpPort() const;

	QString name() const;

	bool hasZones() const;

	QStringList zones() const;

	QString uuid() const;

	QString login() const;

	QString password() const;

	QString volumePluginName() const;

	const QVariantMap& volumePluginParameters() const;

	QString wakeUpPluginName() const;

	QVariantMap const& wakeUpPluginParameters() const;

signals:

	void serverAddressChanged(QString serverAddress);

	void serverPortChanged(int serverPort);

	void serverHttpPortChanged(int serverHttpPort);

	void nameChanged(QString name);

	void hasZonesChanged(bool hasZones);

	void zonesChanged(QStringList zones);


	void uuidChanged(QString uuid);

	void loginChanged(QString login);

	void passwordChanged(QString password);

	void volumePluginNameChanged(QString volumePluginName);

	void volumePluginParametersChanged();

	void wakeUpPluginNameChanged(QString wakeUpPluginName);

	void wakeUpPluginParametersChanged(QVariantMap wakeUpPluginParameters);

public slots:
	void setServerAddress(QString serverAddress);
	void setServerPort(int serverPort);
	void setServerHttpPort(int serverHttpPort);
	void setName(QString name);

	void setHasZones(bool hasZones);

	void setZones(QStringList zones);

	void setUuid(QString uuid);
	void setLogin(QString login);
	void setPassword(QString password);
	void setVolumePluginName(QString volumePluginName);
	void setVolumePluginParameters(QVariantMap parameters);
	void setWakeUpPluginName(QString wakeUpPluginName);
	void setWakeUpPluginParameters(QVariantMap wakeUpPluginParameters);
};

}
}
}

#endif // EU_TGCM_KONTROLLER_SERVER_H
