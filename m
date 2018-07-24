From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] f2fs: fix 32-bit format string warning
Date: Tue, 24 Jul 2018 11:34:54 +0200
Message-ID: <20180724093509.1637386-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <arnd@arndb.de>) id 1fhtj6-0004ud-RW
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Jul 2018 09:35:28 +0000
Received: from mout.kundenserver.de ([212.227.126.187])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fhtj5-00Gf1e-1C
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Jul 2018 09:35:28 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>

On 32-bit targets, size_t is often 'unsigned int', so printing it as %lu
causes a warning:

fs/f2fs/inode.c: In function 'sanity_check_inode':
fs/f2fs/inode.c:247:4: error: format '%lu' expects argument of type 'long unsigned int', but argument 7 has type 'unsigned int' [-Werror=format=]

The correct format string is %zu.

Fixes: ba3a252d3367 ("f2fs: fix to do sanity check with i_extra_isize")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/f2fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 3fe63b0c7325..4fd339fd3ff2 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -245,7 +245,7 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_msg(sbi->sb, KERN_WARNING,
 			"%s: inode (ino=%lx) has corrupted i_extra_isize: %d, "
-			"max: %lu",
+			"max: %zu",
 			__func__, inode->i_ino, fi->i_extra_isize,
 			F2FS_TOTAL_EXTRA_ATTR_SIZE);
 		return false;
-- 
2.18.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
