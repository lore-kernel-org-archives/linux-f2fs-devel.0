From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 7/7] f2fs: xattr simplifications
Date: Tue, 22 Sep 2015 14:26:52 +0200
Message-ID: <1442924812-9384-8-git-send-email-agruenba@redhat.com>
References: <1442924812-9384-1-git-send-email-agruenba@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <agruenba@redhat.com>) id 1ZeMfX-0008Oh-VM
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Sep 2015 12:27:35 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZeMfW-0004nz-JY
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Sep 2015 12:27:35 +0000
In-Reply-To: <1442924812-9384-1-git-send-email-agruenba@redhat.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>, Chao Yu <chao2.yu@samsung.com>, linux-f2fs-devel@lists.sourceforge.net

Now that the xattr handler is passed to the xattr handler operations, we
have access to the attribute name prefix, so simplify
f2fs_xattr_generic_list.

Also, f2fs_xattr_advise_list is only ever called for
f2fs_xattr_advise_handler; there is no need to double check for that.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/f2fs/xattr.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index e643173..862368a 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -30,33 +30,27 @@ static size_t f2fs_xattr_generic_list(const struct xattr_handler *handler,
 		const char *name, size_t len)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(dentry->d_sb);
-	int total_len, prefix_len = 0;
-	const char *prefix = NULL;
+	int total_len, prefix_len;
 
 	switch (handler->flags) {
 	case F2FS_XATTR_INDEX_USER:
 		if (!test_opt(sbi, XATTR_USER))
 			return -EOPNOTSUPP;
-		prefix = XATTR_USER_PREFIX;
-		prefix_len = XATTR_USER_PREFIX_LEN;
 		break;
 	case F2FS_XATTR_INDEX_TRUSTED:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		prefix = XATTR_TRUSTED_PREFIX;
-		prefix_len = XATTR_TRUSTED_PREFIX_LEN;
 		break;
 	case F2FS_XATTR_INDEX_SECURITY:
-		prefix = XATTR_SECURITY_PREFIX;
-		prefix_len = XATTR_SECURITY_PREFIX_LEN;
 		break;
 	default:
 		return -EINVAL;
 	}
 
+	prefix_len = strlen(handler->prefix);
 	total_len = prefix_len + len + 1;
 	if (list && total_len <= list_size) {
-		memcpy(list, prefix, prefix_len);
+		memcpy(list, handler->prefix, prefix_len);
 		memcpy(list + prefix_len, name, len);
 		list[prefix_len + len] = '\0';
 	}
@@ -123,9 +117,6 @@ static size_t f2fs_xattr_advise_list(const struct xattr_handler *handler,
 	const char *xname = F2FS_SYSTEM_ADVISE_PREFIX;
 	size_t size;
 
-	if (handler->flags != F2FS_XATTR_INDEX_ADVISE)
-		return 0;
-
 	size = strlen(xname) + 1;
 	if (list && size <= list_size)
 		memcpy(list, xname, size);
-- 
2.4.3


------------------------------------------------------------------------------
