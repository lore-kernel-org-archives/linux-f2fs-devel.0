From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] fsck.f2fs: check validity of nat journal
Date: Fri, 11 Jan 2019 11:42:36 +0800
Message-ID: <20190111034236.46800-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

As reported by Aravind:

I built f2fs tools from source (at tag v1.12.0) and was able to get this backtrace in gdb:

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff7f8eb54 in f2fs_set_bit (nr=1041170432,
    addr=0x7fffff621010 <error: Cannot access memory at address 0x7fffff621010>) at libf2fs.c:312
312        mask = 1 << (7 - (nr & 0x07));
(gdb) where
    addr=0x7fffff621010 <error: Cannot access memory at address 0x7fffff621010>) at libf2fs.c:312

> [ 5338.040024] nats:8781, sits:6
> [ 5338.040027] F2FS-fs (sda2): Failed to initialize F2FS segment manager
> [ 5338.128893] nats:8781, sits:6
> [ 5338.128895] F2FS-fs (sda2): Failed to initialize F2FS segment manager

nat_count/nid/blkaddr recorded in journal may be corrupted, let's do
sanity check on them, skip loading invalid ones during build_node_manager().

Reported-by: Aravind R S <aravindet@gmail.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- truncate journal->n_nats if it exceeds max nat count in journal
- check blkaddr as well.
 fsck/mount.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 3966525104a7..72f37a365a13 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1066,11 +1066,27 @@ static int f2fs_init_nid_bitmap(struct f2fs_sb_info *sbi)
 			f2fs_set_bit(nid, nm_i->nid_bitmap);
 	}
 
+	if (nats_in_cursum(journal) > NAT_JOURNAL_ENTRIES) {
+		MSG(0, "\tError: f2fs_init_nid_bitmap truncate n_nats(%u) to "
+			"NAT_JOURNAL_ENTRIES(%lu)\n",
+			nats_in_cursum(journal), NAT_JOURNAL_ENTRIES);
+		journal->n_nats = cpu_to_le16(NAT_JOURNAL_ENTRIES);
+	}
+
 	for (i = 0; i < nats_in_cursum(journal); i++) {
 		block_t addr;
 
 		addr = le32_to_cpu(nat_in_journal(journal, i).block_addr);
+		if (!IS_VALID_BLK_ADDR(sbi, addr)) {
+			MSG(0, "\tError: f2fs_init_nid_bitmap: addr(%u) is invalid!!!\n", addr);
+			continue;
+		}
+
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
