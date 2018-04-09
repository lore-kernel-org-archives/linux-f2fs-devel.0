From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH v3] f2fs: stop issue discard if something wrong
 with f2fs
Date: Mon, 9 Apr 2018 19:27:31 +0800
Message-ID: <1523273251-29871-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1f5VBL-00054A-4b
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Apr 2018 11:41:55 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f5VBF-00CI7b-F9
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Apr 2018 11:41:55 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: zhangdianfang@huawei.com

This patch stop async thread and umount process to issue discard
if something wrong with f2fs, which is similar to fstrim.

v1->v2: add fs error check in not only discard thread but also umount process
v2->v3: remove redundant error message

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/segment.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5854cc4..e31d506 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1202,6 +1202,9 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 	int i, iter = 0, issued = 0;
 	bool io_interrupted = false;
 
+	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
+		return issued;
+
 	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
 		if (i + 1 < dpolicy->granularity)
 			break;
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
