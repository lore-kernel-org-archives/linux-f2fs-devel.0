From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] f2fs: fix building on 32-bit architectures
Date: Wed, 13 May 2015 22:49:58 +0200
Message-ID: <2179770.3R5P5nr1c7@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Yossi Goldfill <ygoldfill@radianmemory.com>, linux-f2fs-devel@lists.sourceforge.net, Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

A bug fix to the debug output extended the type of some local
variables to 64-bit, which now causes the kernel to fail building
because of missing 64-bit division functions:

ERROR: "__aeabi_uldivmod" [fs/f2fs/f2fs.ko] undefined!

In the kernel, we have to use div_u64 or do_div to do this,
in order to annotate that this is an expensive operation.

As the function is only called for debug out, we know this
is not performance critical, so it is safe to use div_u64.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: d1f85bd38db19 ("f2fs: avoid value overflow in showing current status")
---
This patch is required for ARM allmodconfig builds.

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index efbc83f07305..75176e0dd6c8 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -113,10 +113,10 @@ static void update_sit_info(struct f2fs_sb_info *sbi)
 			ndirty++;
 		}
 	}
-	dist = MAIN_SECS(sbi) * hblks_per_sec * hblks_per_sec / 100;
-	si->bimodal = bimodal / dist;
+	dist = div_u64(MAIN_SECS(sbi) * hblks_per_sec * hblks_per_sec, 100);
+	si->bimodal = div_u64(bimodal, dist);
 	if (si->dirty_count)
-		si->avg_vblocks = total_vblocks / ndirty;
+		si->avg_vblocks = div_u64(total_vblocks, ndirty);
 	else
 		si->avg_vblocks = 0;
 }
