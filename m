From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] MAINTAINERS: update f2fs entry
Date: Fri, 9 Sep 2016 08:38:20 +0800
Message-ID: <20160909003820.54958-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, cm224.lee@samsung.com, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch includes below modifications:
1. change my maintainership from reviewer to maintainer.
2. remove maintainership of Changman Lee since he is not active about
one and a half year.
3. change website of f2fs from wiki to kernel one.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2: gather more modification in this patch.
 MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bbe4b1..bd28973 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5060,10 +5060,9 @@ F:	include/linux/fscrypto.h
 
 F2FS FILE SYSTEM
 M:	Jaegeuk Kim <jaegeuk@kernel.org>
-M:	Changman Lee <cm224.lee@samsung.com>
-R:	Chao Yu <yuchao0@huawei.com>
+M:	Chao Yu <yuchao0@huawei.com>
 L:	linux-f2fs-devel@lists.sourceforge.net
-W:	http://en.wikipedia.org/wiki/F2FS
+W:	https://f2fs.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 S:	Maintained
 F:	Documentation/filesystems/f2fs.txt
-- 
2.8.2.311.gee88674
