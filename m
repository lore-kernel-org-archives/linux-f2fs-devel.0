From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/4] f2fs-tools: adjust feature name
Date: Thu, 16 Nov 2017 19:50:58 +0800
Message-ID: <20171116115058.110552-4-yuchao0@huawei.com>
References: <20171116115058.110552-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eFIiF-000844-Ur
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Nov 2017 11:52:07 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eFIiE-0003Fc-2Q
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

This patch slightly changes showed feature name.

Before:
Info: superblock features = f9 :  encrypt extra attribute project quota inode checksum flexible inline xattr quota ino

After:
Info: superblock features = f9 :  encrypt extra_attr project_quota inode_checksum flexible_inline_xattr quota_ino

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/mount.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index c094f940ee1b..4ad22a136ca9 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -429,22 +429,22 @@ void print_sb_state(struct f2fs_super_block *sb)
 		MSG(0, "%s", " encrypt");
 	}
 	if (f & cpu_to_le32(F2FS_FEATURE_BLKZONED)) {
-		MSG(0, "%s", " zoned block device");
+		MSG(0, "%s", " blkzoned");
 	}
 	if (f & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
-		MSG(0, "%s", " extra attribute");
+		MSG(0, "%s", " extra_attr");
 	}
 	if (f & cpu_to_le32(F2FS_FEATURE_PRJQUOTA)) {
-		MSG(0, "%s", " project quota");
+		MSG(0, "%s", " project_quota");
 	}
 	if (f & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM)) {
-		MSG(0, "%s", " inode checksum");
+		MSG(0, "%s", " inode_checksum");
 	}
 	if (f & cpu_to_le32(F2FS_FEATURE_FLEXIBLE_INLINE_XATTR)) {
-		MSG(0, "%s", " flexible inline xattr");
+		MSG(0, "%s", " flexible_inline_xattr");
 	}
 	if (f & cpu_to_le32(F2FS_FEATURE_QUOTA_INO)) {
-		MSG(0, "%s", " quota ino");
+		MSG(0, "%s", " quota_ino");
 	}
 	MSG(0, "\n");
 	MSG(0, "Info: superblock encrypt level = %d, salt = ",
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
