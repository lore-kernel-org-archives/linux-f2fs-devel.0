From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: should get a victim from retrials
Date: Mon, 28 Sep 2015 14:43:35 -0700
Message-ID: <20150928214335.GA19248@jaegeuk-mac02.mot.com>
References: <1442862777-22537-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442862777-22537-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Change log from v1:
 o avoid __get_victim call twice, since each call registers the victim in bitmap

>From 45c3aaea805751e5c1899dd9c76d89e6f73a7a8f Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 18 Sep 2015 17:33:00 -0700
Subject: [PATCH] f2fs: should get a victim from retrials

If we do not call get_victim first, we cannot get a new victim for retrial
path.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b6e03eb..343b096 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -799,8 +799,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi, unsigned int segno,
 
 int f2fs_gc(struct f2fs_sb_info *sbi)
 {
-	unsigned int segno = NULL_SEGNO;
-	unsigned int i;
+	unsigned int segno, i;
 	int gc_type = BG_GC;
 	int sec_freed = 0;
 	int ret = -1;
@@ -812,6 +811,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi)
 
 	cpc.reason = __get_cp_reason(sbi);
 gc_more:
+	segno = NULL_SEGNO;
+
 	if (unlikely(!(sbi->sb->s_flags & MS_ACTIVE)))
 		goto stop;
 	if (unlikely(f2fs_cp_error(sbi)))
-- 
2.1.1
