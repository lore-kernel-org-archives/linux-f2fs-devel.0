From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v2] f2fs: Remove lock from check_valid_map
Date: Sun,  7 Sep 2014 11:38:30 +0800
Message-ID: <1410061110-31081-1-git-send-email-ying.huang@intel.com>
References: <1410059104-9060-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ying.huang@intel.com>) id 1XQTJI-0000FM-TY
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 07 Sep 2014 03:38:40 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XQTJI-0005C5-1y for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 07 Sep 2014 03:38:40 +0000
In-Reply-To: <1410059104-9060-1-git-send-email-ying.huang@intel.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Only one bit is read in check_valid_map, holding a lock to do that
doesn't help anything except decreasing performance.

Signed-off-by: Huang, Ying <ying.huang@intel.com>
---

v2: Fixed a build warning.

---
 fs/f2fs/gc.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -378,14 +378,11 @@ static void put_gc_inode(struct list_hea
 static int check_valid_map(struct f2fs_sb_info *sbi,
 				unsigned int segno, int offset)
 {
-	struct sit_info *sit_i = SIT_I(sbi);
 	struct seg_entry *sentry;
 	int ret;
 
-	mutex_lock(&sit_i->sentry_lock);
 	sentry = get_seg_entry(sbi, segno);
 	ret = f2fs_test_bit(offset, sentry->cur_valid_map);
-	mutex_unlock(&sit_i->sentry_lock);
 	return ret;
 }
 

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
