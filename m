From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] common/attr: add maximum acl count for f2fs
Date: Fri, 26 Feb 2016 13:35:42 +0800
Message-ID: <017201d17057$a270c460$e7524d20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <fstests-owner@vger.kernel.org>
Content-language: zh-cn
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Add a max acl count into common/attr for f2fs in order to make
f2fs passing generic/026 test case.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 common/attr | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/attr b/common/attr
index 86fe181..0efc26d 100644
--- a/common/attr
+++ b/common/attr
@@ -42,6 +42,9 @@ _acl_get_max()
 	jfs)
 		echo 8191
 		;;
+	f2fs)
+		echo 506
+		;;
 	*)
 		echo 0
 		;;
-- 
2.7.0
