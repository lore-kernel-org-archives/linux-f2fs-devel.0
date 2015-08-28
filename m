From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: avoid accessing NULL pointer in f2fs_drop_largest_extent
Date: Fri, 28 Aug 2015 18:18:57 +0800
Message-ID: <001a01d0e17b$1301daa0$39058fe0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

If extent cache is disable, we will encounter oops when triggering direct
IO as below:

BUG: unable to handle kernel NULL pointer dereference at 0000000c
IP: [<f0b9c61e>] f2fs_drop_largest_extent+0xe/0x30 [f2fs]
*pdpt = 000000002bb9a001 *pde = 0000000000000000
Oops: 0000 [#1] SMP
Modules linked in: f2fs(O) fuse bnep rfcomm bluetooth nfsd dm_crypt nfs_acl auth_rpcgss oid_registry nfs binfmt_misc fscache lockd
sunrpc grace snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer
snd_seq_device snd soundcore joydev psmouse hid_generic i2c_piix4 serio_raw ppdev mac_hid parport_pc lp parport ext4 jbd2 mbcache
usbhid hid e1000
CPU: 3 PID: 3608 Comm: dd Tainted: G           O    4.2.0-rc4 #12
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
task: ef161600 ti: ebd5e000 task.ti: ebd5e000
EIP: 0060:[<f0b9c61e>] EFLAGS: 00010202 CPU: 3
EIP is at f2fs_drop_largest_extent+0xe/0x30 [f2fs]
EAX: 00000000 EBX: ddebc000 ECX: 00000000 EDX: 00000000
ESI: ebd5fdf8 EDI: 00000000 EBP: ebd5fd58 ESP: ebd5fd58
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
CR0: 80050033 CR2: 0000000c CR3: 2c24ee40 CR4: 000006f0
Stack:
 ebd5fda4 f0b8c005 00000000 00000001 00000000 f0b8c430 c816cd68 ddebc000
 ddebc088 00001000 00000555 00000555 ffffffff c160bb00 00055501 00000000
 00000000 00000100 00000000 ebd5fe20 f0b8c430 00000046 ef161600 00001000
Call Trace:
 [<f0b8c005>] __allocate_data_block+0x1a5/0x260 [f2fs]
 [<f0b8c430>] ? f2fs_direct_IO+0x370/0x440 [f2fs]
 [<c160bb00>] ? down_read+0x30/0x50
 [<f0b8c430>] f2fs_direct_IO+0x370/0x440 [f2fs]
 [<c113e115>] generic_file_direct_write+0xa5/0x260
 [<c10b53f8>] ? current_fs_time+0x18/0x50
 [<c113e38b>] __generic_file_write_iter+0xbb/0x210
 [<c113e50f>] ? generic_file_write_iter+0x2f/0x320
 [<c113e63c>] generic_file_write_iter+0x15c/0x320
 [<f0b77f29>] f2fs_file_write_iter+0x39/0x80 [f2fs]
 [<c11984d9>] __vfs_write+0xa9/0xe0
 [<c1199227>] vfs_write+0x97/0x180
 [<c119955b>] SyS_write+0x5b/0xd0
 [<c160dcd0>] sysenter_do_call+0x12/0x12
Code: 10 8b 50 1c 89 53 14 eb ca 8d 74 26 00 85 f6 74 86 eb a6 0f 0b 90 8d b4 26 00 00 00 00 55 89 e5 3e 8d 74 26 00 8b 80 d4 02 00
00 <8b> 48 0c 39 d1 77 0e 03 48 14 39 ca 73 07 c7 40 14 00 00 00 00
EIP: [<f0b9c61e>] f2fs_drop_largest_extent+0xe/0x30 [f2fs] SS:ESP 0068:ebd5fd58
CR2: 000000000000000c
---[ end trace a38c07026a1afffd ]---

This is because when extent cache is disable, extent_tree pointer in struct
f2fs_inode_info should be NULL, but in f2fs_drop_largest_extent we access
this NULL pointer directly without checking state of extent cache, then,
the oops occurs. Let's fix it by checking state of extent cache before
accessing.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/extent_cache.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index c6f685d..0227260 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -155,7 +155,7 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 	return count - et->count;
 }
 
-void f2fs_drop_largest_extent(struct inode *inode, pgoff_t fofs)
+static void __drop_largest_extent(struct inode *inode, pgoff_t fofs)
 {
 	struct extent_info *largest = &F2FS_I(inode)->extent_tree->largest;
 
@@ -163,6 +163,14 @@ void f2fs_drop_largest_extent(struct inode *inode, pgoff_t fofs)
 		largest->len = 0;
 }
 
+void f2fs_drop_largest_extent(struct inode *inode, pgoff_t fofs)
+{
+	if (!f2fs_may_extent_tree(inode))
+		return;
+
+	__drop_largest_extent(inode, fofs);
+}
+
 void f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -414,7 +422,7 @@ unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 	dei.len = 0;
 
 	/* we do not guarantee that the largest extent is cached all the time */
-	f2fs_drop_largest_extent(inode, fofs);
+	__drop_largest_extent(inode, fofs);
 
 	/* 1. lookup first extent node in range [fofs, fofs + len - 1] */
 	en = __lookup_extent_tree_ret(et, fofs, &prev_en, &next_en,
-- 
2.4.2
