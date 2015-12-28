From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] fsck.f2fs: fix double free invalid checkpoint
Date: Mon, 28 Dec 2015 11:33:22 +0000
Message-ID: <1451302402-21642-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1aDOoP-0006LQ-7b
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Dec 2015 03:49:33 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aDOoI-00025r-6s
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Dec 2015 03:49:33 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net

The invalid checkpoin is freed in validate_checkpoint().

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/mount.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index fe68f37..7533926 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -469,11 +469,8 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 		cur_page = cp2;
 		sbi->cur_cp = 2;
 		version = cp2_version;
-	} else {
-		free(cp1);
-		free(cp2);
+	} else
 		goto fail_no_cp;
-	}
 
 	MSG(0, "Info: CKPT version = %llx\n", version);
 
@@ -495,8 +492,10 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 			memcpy(ckpt + i * blk_size, cur_page, blk_size);
 		}
 	}
-	free(cp1);
-	free(cp2);
+	if (cp1)
+		free(cp1);
+	if (cp2)
+		free(cp2);
 	return 0;
 
 fail_no_cp:
-- 
1.9.1


------------------------------------------------------------------------------
