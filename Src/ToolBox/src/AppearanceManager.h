#pragma once
#include <QObject>
#include <QColor>
#include <QScreen>
#include <QQmlContext>
#include <QFont>

#define appearanceManager (HAppearanceManager::instance())
class AppearanceManager : public QObject {
    Q_OBJECT

    // Theme
    Q_PROPERTY(bool isDark READ isDark WRITE setIsDark NOTIFY isDarkChanged FINAL)

    // Colors
    Q_PROPERTY(QColor primaryColor READ primaryColor WRITE setPrimaryColor NOTIFY primaryColorChanged)
    Q_PROPERTY(QColor backgroundColor READ backgroundColor WRITE setBackgroundColor NOTIFY backgroundColorChanged)
    Q_PROPERTY(QColor successColor READ successColor WRITE setSuccessColor NOTIFY successColorChanged FINAL)

    // Sizing
    Q_PROPERTY(int itemSpacing READ itemSpacing WRITE setItemSpacing NOTIFY itemSpacingChanged)
    Q_PROPERTY(int margins READ margins WRITE setMargins NOTIFY marginsChanged FINAL)
    Q_PROPERTY(int marginsBig READ marginsBig WRITE setMarginsBig NOTIFY marginsBigChanged FINAL)
    Q_PROPERTY(int radius READ radius WRITE setRadius NOTIFY radiusChanged FINAL)
    Q_PROPERTY(int radiusBig READ radiusBig WRITE setRadiusBig NOTIFY radiusBigChanged FINAL)
    Q_PROPERTY(int iconNormalSize READ iconNormalSize WRITE setIconNormalSize NOTIFY iconNormalSizeChanged FINAL)
    Q_PROPERTY(int iconBigSize READ iconBigSize WRITE setIconBigSize NOTIFY iconBigSizeChanged FINAL)
    Q_PROPERTY(int iconVeryBigSize READ iconVeryBigSize WRITE setIconVeryBigSize NOTIFY iconVeryBigSizeChanged FINAL)

    // Font
    Q_PROPERTY(QString fontFamily READ fontFamily WRITE setFontFamily NOTIFY fontFamilyChanged FINAL)
    Q_PROPERTY(int fontMediumPixelSize READ fontMediumPixelSize WRITE setfontMediumPixelSize NOTIFY fontMediumPixelSizeChanged FINAL)
    Q_PROPERTY(int fontLargePixelSize READ fontLargePixelSize WRITE setfontLargePixelSize NOTIFY fontLargePixelSizeChanged FINAL)

public:
    static AppearanceManager* instance();
    void registerYourself(QQmlContext* context);

    // Theme
    bool isDark() const;
    void setIsDark(bool newIsDark);

    // Colors
    Q_INVOKABLE QColor primaryColor() const { return m_primaryColor; }
    Q_INVOKABLE void setPrimaryColor(const QColor &color);
    Q_INVOKABLE QColor backgroundColor() const { return m_backgroundColor; }
    Q_INVOKABLE void setBackgroundColor(const QColor &color);
    Q_INVOKABLE QColor successColor() const;
    Q_INVOKABLE void setSuccessColor(const QColor &newSuccessColor);


    // Sizing
    Q_INVOKABLE int itemSpacing() const { return m_itemSpacing; }
    Q_INVOKABLE void setItemSpacing(const int &spacing);
    Q_INVOKABLE int margins() const;
    Q_INVOKABLE void setMargins(int newMargins);
    Q_INVOKABLE int marginsBig() const;
    Q_INVOKABLE void setMarginsBig(int newMarginsBig);
    Q_INVOKABLE int radius() const;
    Q_INVOKABLE void setRadius(int newRadius);
    Q_INVOKABLE int radiusBig() const;
    Q_INVOKABLE void setRadiusBig(int newRadiusBig);
    Q_INVOKABLE int iconNormalSize() const;
    Q_INVOKABLE void setIconNormalSize(int newIconNormalSize);
    Q_INVOKABLE int iconBigSize() const;
    Q_INVOKABLE void setIconBigSize(int newIconBigSize);
    Q_INVOKABLE int iconVeryBigSize() const;
    Q_INVOKABLE void setIconVeryBigSize(int newIconVeryBigSize);

    // Font
    Q_INVOKABLE QString fontFamily() const;
    Q_INVOKABLE void setFontFamily(const QString &newFontFamily);
    Q_INVOKABLE int fontMediumPixelSize() const;
    Q_INVOKABLE void setfontMediumPixelSize(int newfontMediumPixelSize);
    Q_INVOKABLE int fontLargePixelSize() const;
    Q_INVOKABLE void setfontLargePixelSize(int newfontLargePixelSize);


signals:
    // Theme
    void isDarkChanged();

    // Colors
    void primaryColorChanged();
    void backgroundColorChanged();
    void successColorChanged();

    // Sizing
    void itemSpacingChanged();
    void marginsChanged();
    void marginsBigChanged();
    void radiusChanged();
    void radiusBigChanged();
    void iconNormalSizeChanged();
    void iconBigSizeChanged();
    void iconVeryBigSizeChanged();

    // Font
    void fontFamilyChanged();
    void fontMediumPixelSizeChanged();
    void fontLargePixelSizeChanged();


private:
    explicit AppearanceManager(QObject* parent = nullptr);

    //Theme
    bool m_isDark{false};

    // Colors
    QColor m_primaryColor{"#007892"};
    QColor m_backgroundColor{"white"};
    QColor m_successColor{"green"};

    // Sizing
    int m_itemSpacing{6};
    int m_margins{6};
    int m_marginsBig{16};
    int m_radius{3};
    int m_radiusBig{9};
    int m_iconNormalSize{24};
    int m_iconBigSize{36};
    int m_iconVeryBigSize{48};

    // Font
    QString m_fontFamily{"Arial"};
    int m_fontMediumPixelSize{11};
    int m_fontLargePixelSize{18};
};
