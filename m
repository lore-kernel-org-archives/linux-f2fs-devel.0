From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] fsck.f2fs: check validity of nid from journal
Date: Wed, 9 Jan 2019 10:41:14 +0800
Message-ID: <20190109024114.10918-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gh3oC-00072z-On
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 09 Jan 2019 02:41:32 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gh3o9-005GtV-EW
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 09 Jan 2019 02:41:31 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org

As reported by Aravind:

I built f2fs tools from source (at tag v1.12.0) and was able to get this backtrace in gdb:

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff7f8eb54 in f2fs_set_bit (nr=1041170432,
    addr=0x7fffff621010 <error: Cannot access memory at address 0x7fffff621010>) at libf2fs.c:312
312        mask = 1 << (7 - (nr & 0x07));
(gdb) where
    addr=0x7fffff621010 <error: Cannot access memory at address 0x7fffff621010>) at libf2fs.c:312

nid recorded in journal may be corrupted, let's do sanity check on them,
and skip loading invalid ones during build_node_manager().

Reported-by: Aravind R S <aravindet@gmail.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/mount.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index ea70306b0895..e0d4db245a9e 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1071,6 +1071,10 @@ static int f2fs_init_nid_bitmap(struct f2fs_sb_info *sbi)
 
 		addr = le32_to_cpu(nat_in_journal(journal, i).block_addr);
 		nid = le32_to_cpu(nid_in_journal(journal, i));
+		if (!IS_VALID_NID(sbi, nid)) {
+			MSG(0, "\tError: f2fs_init_nid_bitmap: nid(%u) is invalid!!!\n", nid);
+			continue;
+		}
 		if (addr != NULL_ADDR)
 			f2fs_set_bit(nid, nm_i->nid_bitmap);
 	}
-- 
2.18.0.rc1
