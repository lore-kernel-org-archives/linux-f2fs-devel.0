From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 4/6] f2fs: rename f2fs_set/clear_bit to
	f2fs_test_and_set/clear_bit
Date: Mon, 20 Oct 2014 17:45:51 +0800
Message-ID: <1413798353-27811-4-git-send-email-guz.fnst@cn.fujitsu.com>
References: <1413798353-27811-1-git-send-email-guz.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz@guz>) id 1XgA2o-0002sY-Qt
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 10:18:30 +0000
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XgA2n-0006Jf-LO
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 10:18:30 +0000
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by fgwmail7.fujitsu.co.jp (Postfix) with ESMTP id 137B81796544
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:04:47 +0900 (JST)
Received: from kw-mxoi2.gw.nic.fujitsu.com (unknown [10.0.237.143])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 86E163EE15F
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:04:40 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 9FB10AC062D
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:04:39 +0900 (JST)
Received: from s01.gw.fujitsu.co.jp (s01.gw.nic.fujitsu.com [133.161.11.16])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 4230F1DB8037
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2014 19:04:39 +0900 (JST)
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

Rename f2fs_set/clear_bit to f2fs_test_and_set/clear_bit, which mean
set/clear bit and return the old value, for better readability.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/f2fs.h    |    4 ++--
 fs/f2fs/segment.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3095a57..0aef88f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1020,7 +1020,7 @@ static inline int f2fs_test_bit(unsigned int nr, char *addr)
 	return mask & *addr;
 }
 
-static inline int f2fs_set_bit(unsigned int nr, char *addr)
+static inline int f2fs_test_and_set_bit(unsigned int nr, char *addr)
 {
 	int mask;
 	int ret;
@@ -1032,7 +1032,7 @@ static inline int f2fs_set_bit(unsigned int nr, char *addr)
 	return ret;
 }
 
-static inline int f2fs_clear_bit(unsigned int nr, char *addr)
+static inline int f2fs_test_and_clear_bit(unsigned int nr, char *addr)
 {
 	int mask;
 	int ret;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6fb7446..1146029 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -620,10 +620,10 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 
 	/* Update valid block bitmap */
 	if (del > 0) {
-		if (f2fs_set_bit(offset, se->cur_valid_map))
+		if (f2fs_test_and_set_bit(offset, se->cur_valid_map))
 			f2fs_bug_on(sbi, 1);
 	} else {
-		if (!f2fs_clear_bit(offset, se->cur_valid_map))
+		if (!f2fs_test_and_clear_bit(offset, se->cur_valid_map))
 			f2fs_bug_on(sbi, 1);
 	}
 	if (!f2fs_test_bit(offset, se->ckpt_valid_map))
-- 
1.7.7


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
