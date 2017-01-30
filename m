From: DongOh Shin <doscode.kr@gmail.com>
Subject: [PATCH 1/2] Fix 3 coding style errors in f2fs.h
Date: Mon, 30 Jan 2017 10:55:17 -0800
Message-ID: <20170130185518.916-2-doscode.kr@gmail.com>
References: <20170130185518.916-1-doscode.kr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <doscode.kr@gmail.com>) id 1cYH72-00025m-GQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 30 Jan 2017 18:55:36 +0000
Received: from mail-pg0-f65.google.com ([74.125.83.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cYH71-0003mi-NW
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 30 Jan 2017 18:55:36 +0000
Received: by mail-pg0-f65.google.com with SMTP id 3so14436837pgj.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 30 Jan 2017 10:55:35 -0800 (PST)
In-Reply-To: <20170130185518.916-1-doscode.kr@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: doscode.kr@gmail.com, linux-f2fs-devel@lists.sourceforge.net

Two coding style errors below have been resolved:
"Macros with complex values should be enclosed in parentheses"

And a coding style error below has been resolved:
"space prohibited before that ',' (ctx:WxW)"
Signed-off-by: DongOh Shin <doscode.kr@gmail.com>

Signed-off-by: DongOh Shin <doscode.kr@gmail.com>
---
 fs/f2fs/f2fs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4cce13d..85bd8c1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -108,9 +108,9 @@ struct f2fs_mount_info {
 #define F2FS_HAS_FEATURE(sb, mask)					\
 	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
 #define F2FS_SET_FEATURE(sb, mask)					\
-	F2FS_SB(sb)->raw_super->feature |= cpu_to_le32(mask)
+	(F2FS_SB(sb)->raw_super->feature |= cpu_to_le32(mask))
 #define F2FS_CLEAR_FEATURE(sb, mask)					\
-	F2FS_SB(sb)->raw_super->feature &= ~cpu_to_le32(mask)
+	(F2FS_SB(sb)->raw_super->feature &= ~cpu_to_le32(mask))
 
 /*
  * For checkpoint manager
@@ -2023,7 +2023,7 @@ void f2fs_set_link(struct inode *, struct f2fs_dir_entry *,
 				struct page *, struct inode *);
 int update_dent_inode(struct inode *, struct inode *, const struct qstr *);
 void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *,
-			const struct qstr *, f2fs_hash_t , unsigned int);
+			const struct qstr *, f2fs_hash_t, unsigned int);
 int f2fs_add_regular_entry(struct inode *, const struct qstr *,
 			const struct qstr *, struct inode *, nid_t, umode_t);
 int __f2fs_do_add_link(struct inode *, struct fscrypt_name*, struct inode *,
-- 
1.8.3.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
