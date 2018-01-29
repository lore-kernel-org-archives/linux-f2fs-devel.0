From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH v2] f2fs: fix potential corruption in area before
 F2FS_SUPER_OFFSET
Date: Mon, 29 Jan 2018 19:13:15 +0800
Message-ID: <20180129111315.44332-1-shengyong1@huawei.com>
References: <20180129080418.33490-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1eg7NT-0004D3-Tt
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jan 2018 11:13:31 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eg7NS-0001vz-G9
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jan 2018 11:13:31 +0000
In-Reply-To: <20180129080418.33490-1-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: shengyong1@huawei.com, linux-f2fs-devel@lists.sourceforge.net

sb_getblk does not guarantee the buffer head is uptodate. If bh is not
uptodate, the data (may be used as boot code) in area before
F2FS_SUPER_OFFSET may get corrupted when super block is committed.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/super.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8173ae688814..3db1f02ed8c2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1894,7 +1894,6 @@ static int __f2fs_commit_super(struct buffer_head *bh,
 	lock_buffer(bh);
 	if (super)
 		memcpy(bh->b_data + F2FS_SUPER_OFFSET, super, sizeof(*super));
-	set_buffer_uptodate(bh);
 	set_buffer_dirty(bh);
 	unlock_buffer(bh);
 
@@ -2334,7 +2333,7 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 	}
 
 	/* write back-up superblock first */
-	bh = sb_getblk(sbi->sb, sbi->valid_super_block ? 0: 1);
+	bh = sb_bread(sbi->sb, sbi->valid_super_block ? 0 : 1);
 	if (!bh)
 		return -EIO;
 	err = __f2fs_commit_super(bh, F2FS_RAW_SUPER(sbi));
@@ -2345,7 +2344,7 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 		return err;
 
 	/* write current valid superblock */
-	bh = sb_getblk(sbi->sb, sbi->valid_super_block);
+	bh = sb_bread(sbi->sb, sbi->valid_super_block);
 	if (!bh)
 		return -EIO;
 	err = __f2fs_commit_super(bh, F2FS_RAW_SUPER(sbi));
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
