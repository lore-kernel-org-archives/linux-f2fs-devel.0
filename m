From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix to use highmem for pages of newly
	created directory
Date: Sat, 07 Feb 2015 17:36:15 +0800
Message-ID: <002801d042b9$a9a12e40$fce38ac0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YK1pQ-0001Av-PD
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 Feb 2015 09:37:28 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1YK1pN-00025r-Fx
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 Feb 2015 09:37:28 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NJE003H2AQ50X40@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 Feb 2015 18:37:17 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In commit a78186ebe516 ("f2fs: use highmem for directory pages"), we have set
__GFP_HIGHMEM into dir mapping's gfp flag in f2fs_iget, so high address memory
could be used for these existing dir's page.

But we forgot to set flag for newly created dir, due to this reason, our newly
created dir pages could not be allocated from high address memory. Fix it.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 547a2de..e79639a9 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -299,7 +299,7 @@ static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	inode->i_op = &f2fs_dir_inode_operations;
 	inode->i_fop = &f2fs_dir_operations;
 	inode->i_mapping->a_ops = &f2fs_dblock_aops;
-	mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
+	mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_HIGH_ZERO);
 
 	set_inode_flag(F2FS_I(inode), FI_INC_LINK);
 	f2fs_lock_op(sbi);
-- 
2.2.1



------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
