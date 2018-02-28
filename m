From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] mkfs.f2fs: treat db's data as hot one
Date: Wed, 28 Feb 2018 17:03:44 +0800
Message-ID: <20180228090344.33741-2-yuchao0@huawei.com>
References: <20180228090344.33741-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180228090344.33741-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

DB files like .db, .db-journal, .db-wal, .db-shm are very active, this
patch adds db file type to hot file extension list by default.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 mkfs/f2fs_format.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 3fc2f05437dd..f4a1b08789c1 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -69,6 +69,7 @@ const char *media_ext_lists[] = {
 };
 
 const char *hot_ext_lists[] = {
+	"db",
 	NULL
 };
 
-- 
2.15.0.55.gc2ece9dc4de6
