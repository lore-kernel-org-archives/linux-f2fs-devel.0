From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2 v2] f2fs: skip checkpoint if there is no dirty
 segments
Date: Tue, 11 Aug 2015 22:09:16 -0700
Message-ID: <20150812050916.GA22780@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <1439256205-8906-1-git-send-email-jaegeuk@kernel.org>
 <1439256205-8906-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1439256205-8906-2-git-send-email-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Change log from v1:
 - fix skipping gc incorrectly

>From 06f90d3757a6b7ff524cc112168488f31bbf830f Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 11 Aug 2015 21:59:49 -0700
Subject: [PATCH] f2fs: skip checkpoint if there is no dirty and prefree
 segments

We should avoid needless checkpoints when there is no dirty and prefree segment.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index fcb263a..98bf538 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -811,7 +811,8 @@ gc_more:
 
 	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, nfree)) {
 		gc_type = FG_GC;
-		write_checkpoint(sbi, &cpc);
+		if (dirty_segments(sbi) || prefree_segments(sbi))
+			write_checkpoint(sbi, &cpc);
 	}
 
 	if (!__get_victim(sbi, &segno, gc_type))
-- 
2.1.1

