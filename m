From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/4] fsck.f2fs: fix potential stack overflow issue
Date: Thu, 16 Nov 2017 19:50:56 +0800
Message-ID: <20171116115058.110552-2-yuchao0@huawei.com>
References: <20171116115058.110552-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eFIiF-00083y-R3
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Nov 2017 11:52:07 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eFIiD-00034a-Rw
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Nov 2017 11:52:07 +0000
In-Reply-To: <20171116115058.110552-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In fsck_chk_inode_blk, we will allocate 256 bytes memory in stack before
traversing sub-directory recursively, it's not safe, in order to avoid
potential stack overflow, use malloc instead.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/fsck.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index ec8871278464..11b8b0b8303d 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -633,7 +633,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	u64 i_size = le64_to_cpu(node_blk->i.i_size);
 	u64 i_blocks = le64_to_cpu(node_blk->i.i_blocks);
 	int ofs = get_extra_isize(node_blk);
-	unsigned char en[F2FS_NAME_LEN + 1];
+	unsigned char *en;
 	int namelen;
 	unsigned int idx = 0;
 	int need_fix = 0;
@@ -838,6 +838,9 @@ check:
 		}
 	}
 skip_blkcnt_fix:
+	en = malloc(F2FS_NAME_LEN + 1);
+	ASSERT(en);
+
 	namelen = convert_encrypted_name(node_blk->i.i_name,
 					le32_to_cpu(node_blk->i.i_namelen),
 					en, file_enc_name(&node_blk->i));
@@ -879,6 +882,9 @@ skip_blkcnt_fix:
 			}
 		}
 	}
+
+	free(en);
+
 	if (ftype == F2FS_FT_SYMLINK && i_blocks && i_size == 0) {
 		DBG(1, "ino: 0x%x i_blocks: %lu with zero i_size",
 						nid, (unsigned long)i_blocks);
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
