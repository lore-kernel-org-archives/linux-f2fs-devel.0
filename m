Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D72CA5FC4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Oct 2026 00:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fF/fokOF2x5nyFoSzAC4ewfpnqBqKXFf2z+91IffKmY=; b=bnixPvkrYoX8NyMMDXso8MPDKr
	p8hwDrleqeYYCO1w/MUJi0dLmU7MCDiTWqlI35LRAw0bu0UYQ/xurqYyqBhw9M7rEDK6QN+93cDd1
	sJkPH85vUCqq/LZe7c5P3ooTWxZ4ksfHj5+G5AyMB1j6z9LjvR4fALQF0fmOtUps6y+Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xC4Jk-000596-Ja;
	Thu, 01 Oct 2026 00:06:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xC4Jj-00058z-IU
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 00:06:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2G9ywOqljQFZDKdaAgU095Vl2LGT1PMAEKhFKwrILVk=; b=N8yqn/dx6OAq7rFo/0WLhSWN3y
 tXrC0UcXrgZNzJSRsjEph31ipyneoaK2/Qkjl+nDRl9KkBOqg7Wk8NEh6aVfjzNlkm2bYEhyDM2uy
 3R9co2GAFd/cb46ROyXA6c5nu2VWBwmotNQoYuGflffipjjbija7H1mtbtfRwYcCE09U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2G9ywOqljQFZDKdaAgU095Vl2LGT1PMAEKhFKwrILVk=; b=T
 HZjOriGHmIqW6h7s3R64zvVRLqT8PqcsY9Q6fY44kfmZIIBDfpUDvLHrKWpI5EC/nesX0xDYrW5ZV
 JAAXqj/M+FQAMTk9zLsyrkymnH5enEj1oH2hox4jrhLW1QY+n1NXtV8sk7zODT/8WRTCjXk0ZOnv9
 ehv+FJ/WMwRz4BXs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xC4Ji-0002QF-5n for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 00:06:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8482D60229
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  1 Oct 2026 00:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3708C1F000FF;
 Thu,  1 Oct 2026 00:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790813184;
 bh=2G9ywOqljQFZDKdaAgU095Vl2LGT1PMAEKhFKwrILVk=;
 h=From:To:Cc:Subject:Date;
 b=Snr02TK+vCzf27xXFL943eO7wkvP2tmSHU2ACuNCzYuIYU58ind1uqX0QktO9BsQW
 CtYGxGcm1UYZkCwcLTWGeMcmHtxG9yds8vi90JZfFd/hthsoHGehJZN3xr5XfwRpF0
 wQFl809/gWNtva4Cl6oW7NninwTs4vs3ZedTHfZVJJ9lWMP9p4C9Lt68JGDU/4L1mb
 CslDkIjgGnDu67XFC8KPzVQA9PZnwXu3eU0/gtc4X6LHR4P67hHZFPapLe59c32WzI
 WHLPnKxmAb2eFyJr8oSpYzeMtH3PqLVe9IUbhmKLD82i4uQQGhJv1MsDpfeikdexDZ
 mj+3+bfaPbSjA==
To: jaegeuk@kernel.org
Date: Thu,  1 Oct 2026 00:06:16 +0000
Message-ID: <20261001000616.3824366-1-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
MIME-Version: 1.0
X-Headers-End: 1xC4Ji-0002QF-5n
Subject: [f2fs-dev] [PATCH] f2fs: fix to check continuousness in
 f2fs_sync_meta_pages() correctly
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

In f2fs_sync_meta_pages(), whenever i becomes zero inside while loop,
below check may be skipped, it failed to check the continuousness:

	if (nr_to_write != LONG_MAX && i != 0 &&
		folio->index != prev +
		folio_nr_pages(fbatch.folios[i-1])) {

Cc: stable@kernel.org
Fixes: 580e7a492608 ("f2fs: convert f2fs_sync_meta_pages() to use filemap_get_folios_tag()")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 7b89bb838946..2e5e0ee5feb2 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -606,7 +606,7 @@ void f2fs_write_meta_caches(struct f2fs_sb_info *sbi)
 long f2fs_sync_meta_caches(struct f2fs_sb_info *sbi, long nr_to_write,
 				bool sync, enum iostat_type io_type)
 {
-	pgoff_t index = 0, prev = ULONG_MAX;
+	pgoff_t index = 0, next = ULONG_MAX;
 	struct f2fs_cached_block *entries[F2FS_ONSTACK_CACHES];
 	long nwritten = 0;
 	int nr;
@@ -629,8 +629,8 @@ long f2fs_sync_meta_caches(struct f2fs_sb_info *sbi, long nr_to_write,
 				goto stop;
 			}
 
-			if (background && i != 0 &&
-					entry->index != prev + 1) {
+			if (background && next != ULONG_MAX &&
+					entry->index != next) {
 				f2fs_cache_gang_release(entries, nr);
 				goto stop;
 			}
@@ -657,7 +657,7 @@ long f2fs_sync_meta_caches(struct f2fs_sb_info *sbi, long nr_to_write,
 				break;
 			}
 			nwritten++;
-			prev = entry->index;
+			next = entry->index + 1;
 			if (unlikely(nwritten >= nr_to_write))
 				break;
 		}
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
