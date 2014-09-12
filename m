From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH] f2fs: Fix a race condition in next_free_nid
Date: Fri, 12 Sep 2014 19:21:11 +0800
Message-ID: <1410520871-22731-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ying.huang@intel.com>) id 1XSOuq-00053S-5S
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 12 Sep 2014 11:21:24 +0000
Received: from mga01.intel.com ([192.55.52.88])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XSOup-0004B2-Ai for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 12 Sep 2014 11:21:24 +0000
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
Cc: Huang Ying <ying.huang@intel.com>, huang.ying.caritas@gmail.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

The nm_i->fcnt checking is executed before spin_lock, so if another
thread delete the last free_nid from the list, the wrong nid may be
gotten.  So fix the race condition by moving the nm_i->fnct checking
into spin_lock.

Signed-off-by: Huang, Ying <ying.huang@intel.com>
---
 fs/f2fs/node.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -115,9 +115,11 @@ static inline int next_free_nid(struct f
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *fnid;
 
-	if (nm_i->fcnt <= 0)
-		return -1;
 	spin_lock(&nm_i->free_nid_list_lock);
+	if (nm_i->fcnt <= 0) {
+		spin_unlock(&nm_i->free_nid_list_lock);
+		return -1;
+	}
 	fnid = list_entry(nm_i->free_nid_list.next, struct free_nid, list);
 	*nid = fnid->nid;
 	spin_unlock(&nm_i->free_nid_list_lock);

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
