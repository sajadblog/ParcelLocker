#include "AppearanceManager.h"

AppearanceManager::AppearanceManager(QObject* parent)
    : QObject(parent)
{
}

QColor AppearanceManager::successColor() const
{
    return m_successColor;
}

void AppearanceManager::setSuccessColor(const QColor &newSuccessColor)
{
    if (m_successColor == newSuccessColor)
        return;
    m_successColor = newSuccessColor;
    emit successColorChanged();
}

bool AppearanceManager::isDark() const
{
    return m_isDark;
}

void AppearanceManager::setIsDark(bool newIsDark)
{
    if (m_isDark == newIsDark)
        return;
    m_isDark = newIsDark;
    auto backColor = m_backgroundColor;
    setBackgroundColor(m_primaryColor);
    setPrimaryColor(backColor);
    setSuccessColor(newIsDark ? "chartreuse" : "green");

    emit isDarkChanged();
}

int AppearanceManager::radiusBig() const
{
    return m_radiusBig;
}

void AppearanceManager::setRadiusBig(int newRadiusBig)
{
    if (m_radiusBig == newRadiusBig)
        return;
    m_radiusBig = newRadiusBig;
    emit radiusBigChanged();
}

int AppearanceManager::marginsBig() const
{
    return m_marginsBig;
}

void AppearanceManager::setMarginsBig(int newMarginsBig)
{
    if (m_marginsBig == newMarginsBig)
        return;
    m_marginsBig = newMarginsBig;
    emit marginsBigChanged();
}


int AppearanceManager::iconVeryBigSize() const
{
    return m_iconVeryBigSize;
}

void AppearanceManager::setIconVeryBigSize(int newIconVeryBigSize)
{
    if (m_iconVeryBigSize == newIconVeryBigSize)
        return;
    m_iconVeryBigSize = newIconVeryBigSize;
    setIconNormalSize(m_iconVeryBigSize / 2);
    setIconBigSize(m_iconVeryBigSize * 3 / 4);

    emit iconVeryBigSizeChanged();
}

int AppearanceManager::iconBigSize() const
{
    return m_iconBigSize;
}

void AppearanceManager::setIconBigSize(int newIconBigSize)
{
    if (m_iconBigSize == newIconBigSize)
        return;
    m_iconBigSize = newIconBigSize;
    emit iconBigSizeChanged();
}

int AppearanceManager::iconNormalSize() const
{
    return m_iconNormalSize;
}

void AppearanceManager::setIconNormalSize(int newIconNormalSize)
{
    if (m_iconNormalSize == newIconNormalSize)
        return;
    m_iconNormalSize = newIconNormalSize;
    emit iconNormalSizeChanged();
}

int AppearanceManager::fontLargePixelSize() const
{
    return m_fontLargePixelSize;
}

void AppearanceManager::setfontLargePixelSize(int newfontLargePixelSize)
{
    if (m_fontLargePixelSize == newfontLargePixelSize)
        return;
    m_fontLargePixelSize = newfontLargePixelSize;
    setfontMediumPixelSize(m_fontLargePixelSize * 3 / 5);
    emit fontLargePixelSizeChanged();
}

int AppearanceManager::fontMediumPixelSize() const
{
    return m_fontMediumPixelSize;
}

void AppearanceManager::setfontMediumPixelSize(int newfontMediumPixelSize)
{
    if (m_fontMediumPixelSize == newfontMediumPixelSize)
        return;
    m_fontMediumPixelSize = newfontMediumPixelSize;
    emit fontMediumPixelSizeChanged();
}

QString AppearanceManager::fontFamily() const
{
    return m_fontFamily;
}

void AppearanceManager::setFontFamily(const QString &newFontFamily)
{
    if (m_fontFamily == newFontFamily)
        return;
    m_fontFamily = newFontFamily;

    emit fontFamilyChanged();
}

int AppearanceManager::radius() const
{
    return m_radius;
}

void AppearanceManager::setRadius(int newRadius)
{
    if (m_radius == newRadius)
        return;
    m_radius = newRadius;
    emit radiusChanged();
}

int AppearanceManager::margins() const
{
    return m_margins;
}

void AppearanceManager::setMargins(int newMargins)
{
    if (m_margins == newMargins)
        return;
    m_margins = newMargins;
    emit marginsChanged();
}

AppearanceManager* AppearanceManager::instance() {
    static AppearanceManager inst;
    return &inst;
}

void AppearanceManager::registerYourself(QQmlContext *context)
{
    context->setContextProperty("appearanceManager", this);
}

void AppearanceManager::setPrimaryColor(const QColor &color)
{
    if(m_primaryColor == color)
        return;
    m_primaryColor = color;
    emit primaryColorChanged();
}

void AppearanceManager::setBackgroundColor(const QColor &color)
{
    if(m_backgroundColor == color)
        return;
    m_backgroundColor = color;
    emit backgroundColorChanged();
}

void AppearanceManager::setItemSpacing(const int &spacing)
{
    if(m_itemSpacing == spacing)
        return;
    m_itemSpacing = spacing;
    emit itemSpacingChanged();
}
