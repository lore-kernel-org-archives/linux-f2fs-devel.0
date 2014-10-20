From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 6/6] f2fs: set raw_super default to NULL to avoid
	compile warning
Date: Mon, 20 Oct 2014 17:45:53 +0800
Message-ID: <1413798353-27811-6-git-send-email-guz.fnst@cn.fujitsu.com>
References: <1413798353-27811-1-git-send-email-guz.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz@guz>) id 1Xg9z5-0005Dt-Nj
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 10:14:39 +0000
Received: from fgwmail8.fujitsu.co.jp ([192.51.44.38])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xg9z4-0006Aa-IG
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 10:14:39 +0000
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by fgwmail8.fujitsu.co.jp (Postfix) with ESMTP id A17431795938
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:06:47 +0900 (JST)
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [10.0.237.134])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 2B3863EE0AE
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:06:41 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 40FA1AC0627
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:06:40 +0900 (JST)
Received: from s00.gw.fujitsu.co.jp (s00.gw.nic.fujitsu.com [133.161.11.15])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id E3A4AE08001
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:06:39 +0900 (JST)
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

Set raw_super default to NULL to avoid the possibly used
uninitialized warning, though we may never hit it in fact.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/super.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 41d6f70..ed59c8e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -922,7 +922,7 @@ retry:
 static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct f2fs_sb_info *sbi;
-	struct f2fs_super_block *raw_super;
+	struct f2fs_super_block *raw_super = NULL;
 	struct buffer_head *raw_super_buf;
 	struct inode *root;
 	long err = -EINVAL;
-- 
1.7.7


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
