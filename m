From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs crypto: fix incorrect release for crypto ctx
Date: Fri, 15 May 2015 11:14:34 +0800
Message-ID: <015d01d08ebd$5f5edd00$1e1c9700$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

When encryption feature is enable, if we rmmod f2fs module,
we will encounter a stack backtrace reported in syslog:

"BUG: Bad page state in process rmmod  pfn:aaf8a
page:f0f4f148 count:0 mapcount:129 mapping:ee2f4104 index:0x80
flags: 0xee2830a4(referenced|lru|slab|private_2|writeback|swapbacked|mlocked)
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
bad because of flags:
flags: 0x2030a0(lru|slab|private_2|writeback|mlocked)
Modules linked in: f2fs(O-) fuse bnep rfcomm bluetooth dm_crypt binfmt_misc snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm
snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device joydev ppdev mac_hid lp hid_generic i2c_piix4
parport_pc psmouse snd serio_raw parport soundcore ext4 jbd2 mbcache usbhid hid e1000 [last unloaded: f2fs]
CPU: 1 PID: 3049 Comm: rmmod Tainted: G    B      O    4.1.0-rc3+ #10
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
00000000 00000000 c0021eb4 c15b7518 f0f4f148 c0021ed8 c112e0b7 c1779174
c9b75674 000aaf8a 01b13ce1 c17791a4 f0f4f148 ee2830a4 c0021ef8 c112e3c3
00000000 f0f4f148 c0021f34 f0f4f148 ee2830a4 ef9f0000 c0021f20 c112fdf8
Call Trace:
[<c15b7518>] dump_stack+0x41/0x52
[<c112e0b7>] bad_page.part.72+0xa7/0x100
[<c112e3c3>] free_pages_prepare+0x213/0x220
[<c112fdf8>] free_hot_cold_page+0x28/0x120
[<c1073380>] ? try_to_wake_up+0x2b0/0x2b0
[<c112ff15>] __free_pages+0x25/0x30
[<c112c4fd>] mempool_free_pages+0xd/0x10
[<c112c5f1>] mempool_free+0x31/0x90
[<f0f441cf>] f2fs_exit_crypto+0x6f/0xf0 [f2fs]
[<f0f456c4>] exit_f2fs_fs+0x23/0x95f [f2fs]
[<c10c30e0>] SyS_delete_module+0x130/0x180
[<c11556d6>] ? vm_munmap+0x46/0x60
[<c15bd888>] sysenter_do_call+0x12/0x12"

The reason is that:

since commit 0827e645fd35
("f2fs crypto: shrink size of the f2fs_crypto_ctx structure") is merged,
some fields in f2fs_crypto_ctx structure are merged into a union as they
will never be used simultaneously in write path, read path or on free list.

In f2fs_exit_crypto, we traverse each crypto ctx from free list, in this
moment, our free_list field in union is valid, but still we will try to
release memory space which is pointed by other invalid field in union
structure for each ctx.

Then the error occurs, let's fix it with this patch.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/crypto.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/f2fs/crypto.c b/fs/f2fs/crypto.c
index e36eddd..0a66c9b 100644
--- a/fs/f2fs/crypto.c
+++ b/fs/f2fs/crypto.c
@@ -233,14 +233,6 @@ void f2fs_exit_crypto(void)
 	struct f2fs_crypto_ctx *pos, *n;
 
 	list_for_each_entry_safe(pos, n, &f2fs_free_crypto_ctxs, free_list) {
-		if (pos->w.bounce_page) {
-			if (pos->flags &
-				F2FS_BOUNCE_PAGE_REQUIRES_FREE_ENCRYPT_FL)
-				__free_page(pos->w.bounce_page);
-			else
-				mempool_free(pos->w.bounce_page,
-						f2fs_bounce_page_pool);
-		}
 		if (pos->tfm)
 			crypto_free_tfm(pos->tfm);
 		kmem_cache_free(f2fs_crypto_ctx_cachep, pos);
-- 
2.3.3
