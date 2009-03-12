# SKIP(Social Knowledge & Innovation Platform)
# Copyright (C) 2008 TIS Inc.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.

# アプリケーション連携用のライブラリ
# 別のWebアプリを呼び出す際は、WebServiceUtilを利用する
# 呼び出されるサービスを定義する際は、ForServicesModuleをincludeする
require 'skip_collabo/web_service_util/client'

module SkipCollabo
  class WebServiceUtil
    extend SkipCollabo::WebServiceUtil::Client
  end
end

