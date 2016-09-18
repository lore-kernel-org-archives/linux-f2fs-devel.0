From: Chao Yu <chao@kernel.org>
Subject: [PATCH 3/6] f2fs: fix to avoid race condition when
	updating sbi flag
Date: Sun, 18 Sep 2016 23:30:05 +0800
Message-ID: <1474212608-6930-3-git-send-email-chao@kernel.org>
References: <1474212608-6930-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1ble59-00027o-EJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 18 Sep 2016 15:32:39 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ble58-0007JE-OD
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 18 Sep 2016 15:32:39 +0000
In-Reply-To: <1474212608-6930-1-git-send-email-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Making updating of sbi flag atomic by using {test,set,clear}_bit,
otherwise in concurrency scenario, the flag could be updated incorrectly.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9b4bbf2..c30f744b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -794,7 +794,7 @@ struct f2fs_sb_info {
 	struct proc_dir_entry *s_proc;		/* proc entry */
 	struct f2fs_super_block *raw_super;	/* raw super block pointer */
 	int valid_super_block;			/* valid super block no */
-	int s_flag;				/* flags for sbi */
+	unsigned long s_flag;				/* flags for sbi */
 
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
 	u8 key_prefix[F2FS_KEY_DESC_PREFIX_SIZE];
@@ -1063,17 +1063,19 @@ static inline struct address_space *NODE_MAPPING(struct f2fs_sb_info *sbi)
 
 static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
 {
-	return sbi->s_flag & (0x01 << type);
+	return test_bit(type, &sbi->s_flag);
 }
 
 static inline void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
 {
-	sbi->s_flag |= (0x01 << type);
+	if (!test_bit(type, &sbi->s_flag))
+		set_bit(type, &sbi->s_flag);
 }
 
 static inline void clear_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
 {
-	sbi->s_flag &= ~(0x01 << type);
+	if (test_bit(type, &sbi->s_flag))
+		clear_bit(type, &sbi->s_flag);
 }
 
 static inline unsigned long long cur_cp_version(struct f2fs_checkpoint *cp)
-- 
2.7.2


------------------------------------------------------------------------------
