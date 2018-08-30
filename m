From: Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] f2fs: add additional sanity check in
 f2fs_acl_from_disk()
Date: Thu, 30 Aug 2018 21:33:31 +0800
Message-ID: <20180830133331.5503-1-cgxu519@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <cgxu519@gmx.com>) id 1fvN58-0007jW-H7
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 13:33:54 +0000
Received: from mout.gmx.net ([212.227.15.18])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fvN56-003lm3-ME
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 13:33:54 +0000
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
Cc: Chengguang Xu <cgxu519@gmx.com>, linux-f2fs-devel@lists.sourceforge.net

Add additinal sanity check for irregular case(e.g. corruption).
If size of extended attribution is smaller than size of acl header,
then return -EINVAL.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 fs/f2fs/acl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 111824199a88..79e9ea773070 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -53,6 +53,9 @@ static struct posix_acl *f2fs_acl_from_disk(const char *value, size_t size)
 	struct f2fs_acl_entry *entry = (struct f2fs_acl_entry *)(hdr + 1);
 	const char *end = value + size;
 
+	if (size < sizeof(f2fs_acl_header))
+		return ERR_PTR(-EINVAL);
+
 	if (hdr->a_version != cpu_to_le32(F2FS_ACL_VERSION))
 		return ERR_PTR(-EINVAL);
 
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
