From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix to handle error in f2fs_disable_checkpoint()
Date: Fri, 26 Apr 2019 17:57:54 +0800
Message-ID: <20190426095754.85784-2-yuchao0@huawei.com>
References: <20190426095754.85784-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426095754.85784-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, drosen@google.com, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

In f2fs_disable_checkpoint(), it needs to detect and propagate error
number returned from f2fs_write_checkpoint().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fcc9793dbc2c..ad0faa19cb69 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1507,9 +1507,12 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 	mutex_lock(&sbi->gc_mutex);
 	cpc.reason = CP_PAUSE;
 	set_sbi_flag(sbi, SBI_CP_DISABLED);
-	f2fs_write_checkpoint(sbi, &cpc);
+	err = f2fs_write_checkpoint(sbi, &cpc);
+	if (err)
+		goto out_unlock;
 
 	sbi->unusable_block_count = 0;
+out_unlock:
 	mutex_unlock(&sbi->gc_mutex);
 restore_flag:
 	sbi->sb->s_flags = s_flags;	/* Restore MS_RDONLY status */
-- 
2.18.0.rc1
