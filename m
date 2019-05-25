From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] f2fs: Make sanity_check_curseg static
Date: Sat, 25 May 2019 20:48:09 +0800
Message-ID: <20190525124809.17424-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Fix sparse warning:

fs/f2fs/segment.c:4246:5: warning:
 symbol 'sanity_check_curseg' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1a83115284b9..51f57393ad5b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4243,7 +4243,7 @@ static int build_dirty_segmap(struct f2fs_sb_info *sbi)
 	return init_victim_secmap(sbi);
 }
 
-int sanity_check_curseg(struct f2fs_sb_info *sbi)
+static int sanity_check_curseg(struct f2fs_sb_info *sbi)
 {
 	int i;
 
-- 
2.17.1
