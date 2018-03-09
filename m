From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH 3/3] ext4: do not allow mount with
 test_dummy_encryption if encrypt not set
Date: Fri, 9 Mar 2018 15:53:12 +0800
Message-ID: <20180309075312.62357-4-shengyong1@huawei.com>
References: <20180309075312.62357-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1euCqR-0005l9-Av
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Mar 2018 07:53:39 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1euCqN-009nqN-D3
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Mar 2018 07:53:39 +0000
In-Reply-To: <20180309075312.62357-1-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, ebiggers@google.com, tytso@mit.edu
Cc: linux-fscrypt@vger.kernel.org, miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

When mounting with test_dummy_encryption option, if encrypt feature
is not set, return fail instead of setting encrypt feature forcely.

CC: linux-ext4@vger.kernel.org
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/ext4/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 39bf464c35f1..c424af0ccda9 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4151,8 +4151,9 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 
 	if (DUMMY_ENCRYPTION_ENABLED(sbi) && !sb_rdonly(sb) &&
 	    !ext4_has_feature_encrypt(sb)) {
-		ext4_set_feature_encrypt(sb);
-		ext4_commit_super(sb, 1);
+		ext4_msg(sb, KERN_ERR,
+			 "Encrypt does not support or filesystem is read-only");
+		goto failed_mount_wq;
 	}
 
 	/*
-- 
2.14.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
