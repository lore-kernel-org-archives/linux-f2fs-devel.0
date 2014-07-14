From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3.15 2/2] f2fs: check bdi->dirty_exceeded when
	trying to skip data writes
Date: Mon, 14 Jul 2014 07:52:51 -0700
Message-ID: <1405349571-20058-2-git-send-email-jaegeuk@kernel.org>
References: <1405349571-20058-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1X6hch-0004np-K6
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Jul 2014 14:52:59 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X6hcg-0005TE-Ex for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Jul 2014 14:52:59 +0000
In-Reply-To: <1405349571-20058-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

commit dd6b9bf5883c3ca9c17bac80ccd8615fe5a452a3 upstream.

If we don't check the current backing device status, balance_dirty_pages can
fall into infinite pausing routine.

This can be occurred when a lot of directories make a small number of dirty
dentry pages including files.

Reported-by: Brian Chadwick <brianchad@westnet.com.au>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a9c0495..5696bde 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -42,6 +42,8 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
 		mem_size = (nm_i->nat_cnt * sizeof(struct nat_entry)) >> 12;
 		res = mem_size < ((val.totalram * nm_i->ram_thresh / 100) >> 2);
 	} else if (type == DIRTY_DENTS) {
+		if (sbi->sb->s_bdi->dirty_exceeded)
+			return false;
 		mem_size = get_pages(sbi, F2FS_DIRTY_DENTS);
 		res = mem_size < ((val.totalram * nm_i->ram_thresh / 100) >> 1);
 	}
-- 
2.0.1.472.g6f92e5f


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck&#174;
Code Sight&#153; - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
