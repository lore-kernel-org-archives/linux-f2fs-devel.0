From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: declare static functions
Date: Fri, 10 Mar 2017 09:53:35 -0800
Message-ID: <20170310175335.26013-2-jaegeuk@kernel.org>
References: <20170310175335.26013-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cmOjc-0004qW-4a
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 17:53:48 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cmOjb-0000cr-Dc
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 17:53:48 +0000
In-Reply-To: <20170310175335.26013-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Fengguang Wu <fengguang.wu@intel.com>

This is to avoid build warning reported by kbuild test robot.

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 94967171dee8..a0a060c2979b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1823,7 +1823,8 @@ static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
 		kmem_cache_free(free_nid_slab, i);
 }
 
-void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid, bool set)
+static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
+					bool set)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	unsigned int nat_ofs = NAT_BLOCK_OFFSET(nid);
@@ -2383,7 +2384,7 @@ static void __adjust_nat_entry_set(struct nat_entry_set *nes,
 	list_add_tail(&nes->set_list, head);
 }
 
-void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
+static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 						struct page *page)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
@@ -2638,7 +2639,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
-int init_free_nid_cache(struct f2fs_sb_info *sbi)
+static int init_free_nid_cache(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 
-- 
2.11.0


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
