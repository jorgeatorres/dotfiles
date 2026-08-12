# Sets various macOS config settings.

if ! plutil -lint /Library/Preferences/com.apple.TimeMachine.plist > /dev/null 2>&1; then
	echo "! This step needs Full Disk Access."
	open "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles"
	exit 1
fi

# ------------
# Useful utils
# ------------

# https://github.com/gildas-lormeau/single-file-cli. Save web pages as self-contained HTML; drives Chrome.
if [[ ! -e ${HOME}/.bin/single-file ]]; then
	wget -q -O ${HOME}/.bin/single-file https://github.com/gildas-lormeau/single-file-cli/releases/download/v2.0.83/single-file-aarch64-apple-darwin
	chmod +x ${HOME}/.bin/single-file
fi

# --------------
# TouchID + sudo
# --------------
[[ -e /etc/pam.d/sudo_local ]] ||  sudo touch /etc/pam.d/sudo_local

if ! grep -qE '^[^#]*auth\s+sufficient\s+pam_tid.so' /etc/pam.d/sudo_local; then
	echo "auth       sufficient     pam_tid.so" | sudo tee -a /etc/pam.d/sudo_local > /dev/null
fi

# -----
# Fonts
# -----
[[ -e ${HOME}/Downloads/Fonts/MonoLisa ]] && cp ${HOME}/Downloads/Fonts/MonoLisa/otf/*.otf ${HOME}/Library/Fonts/
[[ -e ${HOME}/Downloads/Fonts/Operator\ Mono ]] && cp ${HOME}/Downloads/Fonts/Operator\ Mono/otf/*.otf ${HOME}/Library/Fonts/


# -----
# Dates
# -----
# Dict keys/use: 1- short, 2- medium, 3- long, 4- full date (source: https://www.caseyliss.com/2022/11/14/ventura-date-formats)
defaults write -g AppleICUDateFormatStrings -dict-add 1 "y-MM-dd"
defaults write -g AppleICUDateFormatStrings -dict-add 2 "y-MM-dd"
defaults write -g AppleICUForce24HourTime -bool true
plutil -replace AppleFirstWeekday -xml "<dict><key>gregorian</key><integer>2</integer></dict>" ~/Library/Preferences/.GlobalPreferences.plist # Monday as first day of the week.
killall -SIGHUP SystemUIServer

defaults write -g AppleICUNumberSymbols -dict 0 '.' 1 ',' 10 '.' 17 ','


# ----
# Dock
# ----
defaults write com.apple.dock autohide -bool false # Don't auto-hide.
defaults write com.apple.dock autohide-time-modifier -float 0.3 # Auto-hide animation speed (if ever enabled).
defaults write com.apple.dock tilesize -int 32 # Dock size.
defaults delete com.apple.dock persistent-apps 2> /dev/null || true # Clear out persistent apps (may already be absent).
defaults write com.apple.dock show-recents -bool false # Don't show recent apps.
defaults write com.apple.dock show-process-indicators -bool false # Don't show open app indicators.
defaults write com.apple.dock magnification -int 0 # Disable magnification.
defaults write com.apple.dock orientation -string "bottom" # Position.

# # Hot Corners:
#   wvous-<corner>-corner <action>
#   - <corner> -- tl: top left,  can be tl (top left), tr (top right), bl (bottom left) or br (bottom right).
#   - <action> -- 0: no-op, 2: Mission Control, 3: Show application windows, 4: Desktop, 5: Start screen saver, 6: Disable screen saver, 7: Dashboard, 10: Put display to sleep, 11: Launchpad, 12: Notification Center, 13: Lock Screen
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0

killall Dock

# ------
# Finder
# ------
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0 # Document proxy icon delay.
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1 # Sidebar icon size

defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv" # List view.
defaults write com.apple.finder NewWindowTarget -string "PfHm" # New finder windows open home folder.
defaults write com.apple.finder NewWindowTargetPath -string "file:///${HOME}/" # New window target path.
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf" # Search defaults to current dir.
defaults write com.apple.finder SidebarWidth -int 180 # Sidebar width.

# Desktop view.
# plutil -replace DesktopViewSettings.IconViewSettings.iconSize -integer 64 ${HOME}/Library/Preferences/com.apple.finder.plist
# plutil -replace DesktopViewSettings.IconViewSettings.textSize -integer 12 ${HOME}/Library/Preferences/com.apple.finder.plist

# List View: calculate sizes and use relative dates.
plutil -replace StandardViewSettings.ExtendedListViewSettingsV2.calculateAllSizes -bool true ${HOME}/Library/Preferences/com.apple.finder.plist
plutil -replace StandardViewSettings.ExtendedListViewSettingsV2.useRelativeDates -bool true ${HOME}/Library/Preferences/com.apple.finder.plist
plutil -replace StandardViewSettings.ListViewSettings.calculateAllSizes -bool true ${HOME}/Library/Preferences/com.apple.finder.plist
plutil -replace StandardViewSettings.ListViewSettings.useRelativeDates -bool true ${HOME}/Library/Preferences/com.apple.finder.plist

# List View: sort by kind.
plutil -replace StandardViewSettings.ExtendedListViewSettingsV2.sortColumn -string kind ${HOME}/Library/Preferences/com.apple.finder.plist
plutil -replace StandardViewSettings.ListViewSettings.sortColumn -string kind ${HOME}/Library/Preferences/com.apple.finder.plist

find -x ${HOME} -name .DS_Store -delete 2> /dev/null || true

# Make cfprefsd re-read the plists edited directly via plutil, so cached copies don't clobber them.
killall cfprefsd
killall Finder

# --------
# Trackpad
# --------
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true # Tap to click.
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true # Right click.
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool true # Dragging.
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad DragLock -bool true # Drag lock.
defaults write com.apple.AppleMultitouchTrackpad DragLock -bool true

# --------
# Terminal
# --------
defaults write com.apple.terminal "Default Window Settings" -string "Pro"
defaults write com.apple.terminal "Startup Window Settings" -string "Pro"
plutil -replace Window\ Settings.Pro.FontAntialias -bool true ${HOME}/Library/Preferences/com.apple.Terminal.plist # Font Antialias.
plutil -replace Window\ Settings.Pro.columnCount -integer 120 ${HOME}/Library/Preferences/com.apple.Terminal.plist # Window size (cols).
plutil -replace Window\ Settings.Pro.rowCount -integer 40 ${HOME}/Library/Preferences/com.apple.Terminal.plist # Window size (rows).
plutil -replace Window\ Settings.Pro.Font -data "YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMSAAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGkCwwVFlUkbnVsbNQNDg8QERITFFZOU1NpemVYTlNmRmxhZ3NWTlNOYW1lViRjbGFzcyNAKAAAAAAAABAQgAKAA15TRk1vbm8tUmVndWxhctIXGBkaWiRjbGFzc25hbWVYJGNsYXNzZXNWTlNGb250ohkbWE5TT2JqZWN0CBEaJCkyN0lMUVNYXmdud36FjpCSlKOos7zDxgAAAAAAAAEBAAAAAAAAABwAAAAAAAAAAAAAAAAAAADP" ${HOME}/Library/Preferences/com.apple.Terminal.plist # Font.
plutil -replace Window\ Settings.Pro.BackgroundColor -data "YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMSAAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxAREldOU1doaXRlXE5TQ29sb3JTcGFjZVYkY2xhc3NPEA8wIDAuODk4NTQyODU3MQAQA4AC0hQVFhdaJGNsYXNzbmFtZVgkY2xhc3Nlc1dOU0NvbG9yohYYWE5TT2JqZWN0CBEaJCkyN0lMUVNXXWRseYCSlJabpq+3ugAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAAAAAAAADD" ${HOME}/Library/Preferences/com.apple.Terminal.plist # Background color.
plutil -replace Window\ Settings.Pro.CursorBlink -bool true ${HOME}/Library/Preferences/com.apple.Terminal.plist # Blink cursor.
killall cfprefsd

# ------
# Safari
# ------
defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch -bool true
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari NewTabBehavior -int 4 # 4 = Start Page, 0 = Homepage, 1 = Empty Page, 2 = Same Page.
defaults write com.apple.Safari NewWindowBehavior -int 4 # Same as above.
defaults write com.apple.Safari ShowStandaloneTabBar -bool true # false = Compact mode, true = Separate.
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
defaults write com.apple.Safari ShowOverlayStatusBar -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
