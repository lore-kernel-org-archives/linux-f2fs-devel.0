From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 1/6] f2fs: remove the seems unneeded argument
	'type' from __get_victim
Date: Mon, 20 Oct 2014 17:45:48 +0800
Message-ID: <1413798353-27811-1-git-send-email-guz.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz@guz>) id 1XgA1N-0002Jz-VZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 10:17:02 +0000
Received: from fgwmail8.fujitsu.co.jp ([192.51.44.38])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XgA1M-0007io-PX
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 10:17:01 +0000
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by fgwmail8.fujitsu.co.jp (Postfix) with ESMTP id D00361796421
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:01:45 +0900 (JST)
Received: from kw-mxoi1.gw.nic.fujitsu.com (unknown [10.0.237.133])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 532BA3EE0C1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:01:39 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5E578AC066A
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:01:38 +0900 (JST)
Received: from s01.gw.fujitsu.co.jp (s01.gw.nic.fujitsu.com [133.161.11.16])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 0D8CA1DB8038
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:01:38 +0900 (JST)
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

Remove the unneeded argument 'type' from __get_victim, use
NO_CHECK_TYPE directly when calling v_ops->get_victim().

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/gc.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2a8f4ac..7151d7d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -646,12 +646,14 @@ next_iput:
 }
 
 static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
-						int gc_type, int type)
+			int gc_type)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	int ret;
+
 	mutex_lock(&sit_i->sentry_lock);
-	ret = DIRTY_I(sbi)->v_ops->get_victim(sbi, victim, gc_type, type, LFS);
+	ret = DIRTY_I(sbi)->v_ops->get_victim(sbi, victim, gc_type,
+					      NO_CHECK_TYPE, LFS);
 	mutex_unlock(&sit_i->sentry_lock);
 	return ret;
 }
@@ -709,7 +711,7 @@ gc_more:
 		write_checkpoint(sbi, &cpc);
 	}
 
-	if (!__get_victim(sbi, &segno, gc_type, NO_CHECK_TYPE))
+	if (!__get_victim(sbi, &segno, gc_type))
 		goto stop;
 	ret = 0;
 
-- 
1.7.7


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
