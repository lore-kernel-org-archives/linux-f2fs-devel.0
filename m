From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH v2 5/9] dump.f2fs: do not dump encrypted files
Date: Thu, 2 Nov 2017 11:56:08 +0800
Message-ID: <20171102035612.217263-6-shengyong1@huawei.com>
References: <20171102035612.217263-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <shengyong1@huawei.com>)
 id 1eA6cM-0002yx-KM
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 03:56:34 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1eA6cL-0003ls-8c
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 03:56:34 +0000
In-Reply-To: <20171102035612.217263-1-shengyong1@huawei.com>
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

If a file is encrypted, its content is cipher text on the storage. So
there is no need to dump an encrypted file.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/dump.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 3d64cb7..27736ae 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -410,12 +410,17 @@ static void dump_file(struct f2fs_sb_info *sbi, struct node_info *ni,
 	struct f2fs_inode *inode = &node_blk->i;
 	u32 imode = le32_to_cpu(inode->i_mode);
 	u32 namelen = le32_to_cpu(inode->i_namelen);
-	unsigned char name[F2FS_NAME_LEN + 1] = {0};
+	char name[F2FS_NAME_LEN + 1] = {0};
 	char path[1024] = {0};
 	char ans[255] = {0};
-	int enc_name = file_enc_name(inode);
+	int is_encrypted = file_is_encrypt(inode);
 	int ret;
 
+	if (is_encrypted) {
+		MSG(force, "File is encrypted\n");
+		return;
+	}
+
 	if (!S_ISREG(imode) || namelen == 0 || namelen > F2FS_NAME_LEN) {
 		MSG(force, "Not a regular file or wrong name info\n\n");
 		return;
@@ -433,8 +438,7 @@ dump:
 		ASSERT(ret >= 0);
 
 		/* make a file */
-		namelen = convert_encrypted_name(inode->i_name, namelen,
-							name, enc_name);
+		strncpy(name, (const char *)inode->i_name, namelen);
 		name[namelen] = 0;
 		sprintf(path, "./lost_found/%s", name);
 
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
