From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 5/6] f2fs: remove the redundant function
	cond_clear_inode_flag
Date: Mon, 20 Oct 2014 17:45:52 +0800
Message-ID: <1413798353-27811-5-git-send-email-guz.fnst@cn.fujitsu.com>
References: <1413798353-27811-1-git-send-email-guz.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz@guz>) id 1Xg9yV-0005CY-0w
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 10:14:03 +0000
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xg9yT-0007lS-Pd
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 10:14:02 +0000
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by fgwmail7.fujitsu.co.jp (Postfix) with ESMTP id BBF6C1794F54
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:05:47 +0900 (JST)
Received: from kw-mxq.gw.nic.fujitsu.com (unknown [10.0.237.131])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 248683EE0BB
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:05:41 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id EF0F0AC07EF
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:05:39 +0900 (JST)
Received: from s01.gw.fujitsu.co.jp (s01.gw.nic.fujitsu.com [133.161.11.16])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6A881E38002
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:05:39 +0900 (JST)
In-Reply-To: <1413798353-27811-1-git-send-email-guz.fnst@cn.fujitsu.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Use clear_inode_flag to replace the redundant cond_clear_inode_flag.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/acl.c  |    4 ++--
 fs/f2fs/f2fs.h |    9 ---------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 83b9b5a..e8d78fb 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -229,7 +229,7 @@ static int __f2fs_set_acl(struct inode *inode, int type,
 	if (acl) {
 		value = f2fs_acl_to_disk(acl, &size);
 		if (IS_ERR(value)) {
-			cond_clear_inode_flag(fi, FI_ACL_MODE);
+			clear_inode_flag(fi, FI_ACL_MODE);
 			return (int)PTR_ERR(value);
 		}
 	}
@@ -240,7 +240,7 @@ static int __f2fs_set_acl(struct inode *inode, int type,
 	if (!error)
 		set_cached_acl(inode, type, acl);
 
-	cond_clear_inode_flag(fi, FI_ACL_MODE);
+	clear_inode_flag(fi, FI_ACL_MODE);
 	return error;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0aef88f..d227dc6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1096,15 +1096,6 @@ static inline void set_acl_inode(struct f2fs_inode_info *fi, umode_t mode)
 	set_inode_flag(fi, FI_ACL_MODE);
 }
 
-static inline int cond_clear_inode_flag(struct f2fs_inode_info *fi, int flag)
-{
-	if (is_inode_flag_set(fi, FI_ACL_MODE)) {
-		clear_inode_flag(fi, FI_ACL_MODE);
-		return 1;
-	}
-	return 0;
-}
-
 static inline void get_inline_info(struct f2fs_inode_info *fi,
 					struct f2fs_inode *ri)
 {
-- 
1.7.7


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
