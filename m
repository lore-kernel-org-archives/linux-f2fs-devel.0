From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 3/6] f2fs: introduce f2fs_change_bit to simplify
	the change bit logic
Date: Mon, 20 Oct 2014 17:45:50 +0800
Message-ID: <1413798353-27811-3-git-send-email-guz.fnst@cn.fujitsu.com>
References: <1413798353-27811-1-git-send-email-guz.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz@guz>) id 1XgA31-0002tW-3v
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 10:18:43 +0000
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XgA2z-0006K2-Rg
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 10:18:43 +0000
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by fgwmail7.fujitsu.co.jp (Postfix) with ESMTP id 00EC1179617D
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:03:48 +0900 (JST)
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [10.0.237.134])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 88ACD3EE1C7
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:03:41 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 8FA36AC05F4
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:03:40 +0900 (JST)
Received: from s00.gw.fujitsu.co.jp (s00.gw.nic.fujitsu.com [133.161.11.15])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 09C9C1DB8037
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:03:40 +0900 (JST)
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

Introduce f2fs_change_bit to simplify the change bit logic in
function set_to_next_nat{sit}.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/f2fs.h    |    9 +++++++++
 fs/f2fs/node.h    |    5 +----
 fs/f2fs/segment.h |    5 +----
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8171e80..3095a57 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1044,6 +1044,15 @@ static inline int f2fs_clear_bit(unsigned int nr, char *addr)
 	return ret;
 }
 
+static inline void f2fs_change_bit(unsigned int nr, char *addr)
+{
+	int mask;
+
+	addr += (nr >> 3);
+	mask = 1 << (7 - (nr & 0x07));
+	*addr ^= mask;
+}
+
 /* used for f2fs_inode_info->flags */
 enum {
 	FI_NEW_INODE,		/* indicate newly allocated inode */
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 8d5e6e0..acb71e5 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -192,10 +192,7 @@ static inline void set_to_next_nat(struct f2fs_nm_info *nm_i, nid_t start_nid)
 {
 	unsigned int block_off = NAT_BLOCK_OFFSET(start_nid);
 
-	if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
-		f2fs_clear_bit(block_off, nm_i->nat_bitmap);
-	else
-		f2fs_set_bit(block_off, nm_i->nat_bitmap);
+	f2fs_change_bit(block_off, nm_i->nat_bitmap);
 }
 
 static inline void fill_node_footer(struct page *page, nid_t nid,
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 2495bec..6723ccc 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -657,10 +657,7 @@ static inline void set_to_next_sit(struct sit_info *sit_i, unsigned int start)
 {
 	unsigned int block_off = SIT_BLOCK_OFFSET(start);
 
-	if (f2fs_test_bit(block_off, sit_i->sit_bitmap))
-		f2fs_clear_bit(block_off, sit_i->sit_bitmap);
-	else
-		f2fs_set_bit(block_off, sit_i->sit_bitmap);
+	f2fs_change_bit(block_off, sit_i->sit_bitmap);
 }
 
 static inline unsigned long long get_mtime(struct f2fs_sb_info *sbi)
-- 
1.7.7


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
