Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACADCA5FCB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Sep 2026 23:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FqLuqIQ2jPeMVGko9sGGPlk+uqc7PN8j1wdWZ5y+adg=; b=I8dR08k0ILIbeYoIWyQn4XsIcm
	0myBZE7iYDvJ+5esbFBBzNb4akaPF4a2uYi0hRjWvQWCXj0PlYvIXOnviHkAkNx4Yc+kuepck5Tk1
	rIFvwMtZJQueq5si0BL+SaB2G8ilNV65Zr+jE7Q3y/629vAb0P6xXz07EBPItolbEJ7Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xC48S-0004v8-Sc;
	Wed, 30 Sep 2026 23:54:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xC48R-0004v0-F9
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 23:54:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7V6HxPW35u3T18aRl4kVKV9kWmiy0G03c0FyrS7TH1I=; b=jnu0wPtW3UEzpFxcDIGlflzdnc
 FIU/5jexp7h6utpZiTE9VXWsolCr/T+17BtrMgy6W3KEDr+GRNAZBeFP1gSwosfVaBGEyQ6Jmoorb
 S52pNyB3ZVyAyJUOuPb3sfrrBgnDfXDlIhkj1HDvn8aibgm0EwBEzAjbBZgvGly7wAU8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7V6HxPW35u3T18aRl4kVKV9kWmiy0G03c0FyrS7TH1I=; b=bAf/a+VezIUrmtcV/ZcFkINRhQ
 iQfX/AZ6hXYWP7f7bLux4SomT3IckzRhO3pMVYD/lZ0UOngpyrVcFCnvZ16gyoFVHux2bfawsTuXF
 TzSXjN1H9sAWfm1fpaGnYK5gcvGmYyKbtndZdeWeyAHL9q6D5C5Y32EwMFtLaIm8Ycpw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xC48O-0002KK-BF for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 23:54:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 017F743687
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 23:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EE01F00899;
 Wed, 30 Sep 2026 23:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790812482;
 bh=7V6HxPW35u3T18aRl4kVKV9kWmiy0G03c0FyrS7TH1I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ktfyt73Fn2tSbpuvT1sGhv/9EveUfkXPwa9IAea1aF5haUSi7XyGk9XlWMbraQKBY
 C55LiCwlla+NlvZLV7CH93w4KkjwXks9Ao1QiuZkqIgRgzo+I0bA1RNKzwwyr/DF84
 LahjmohMnc4eg1C0jFR+92EmFi4WSpKn/AGAmYJi1gyLUpKLG3GBdzJYx+B9KwHwb2
 Jcqo2QWwJFwWa/ukm6ISjrUx2bmOOe0lX4729SSF128cy6zS44OubOSONUiVXoKC7Y
 8smr0NeowPEcalHwFFt1zuyL+i5XNkpPREOjEuq59DAtVsulhFPied9M88cIqFAj+m
 BiflJ1iLyw81g==
To: jaegeuk@kernel.org
Date: Wed, 30 Sep 2026 23:54:35 +0000
Message-ID: <20260930235435.3789910-2-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930235435.3789910-1-chao@kernel.org>
References: <20260930235435.3789910-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xC48O-0002KK-BF
Subject: [f2fs-dev] [PATCH 2/2] f2fs: cache: pin cached block in
 f2fs_unlock_cache()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

During asynchronous read readahead (e.g., in f2fs_ra_node_cache()), the
caller drops its own reference via f2fs_put_cache(entry, false) immediately
after issuing the read bio, leaving only the radix tree holding an active
reference during I/O flight.

In f2fs_unlock_cache(), clear_and_wake_up_bit() executes two steps:
1. clear_bit_unlock(F2FS_BLOCK_LOCKED, &entry->state): clears the bit.
2. wake_up_bit(&entry->state, F2FS_BLOCK_LOCKED): hashes &entry->state
   to find the waitqueue and wake sleeping waiters.

Once step 1 clears the bit, a concurrent waiter in f2fs_lock_cache()
(such as in f2fs_truncate_cache() or f2fs_drop_cache()) is immediately
unblocked. The waiter can acquire the lock, delete the entry from the
radix tree, drop the remaining reference, and kfree() the entry before
step 2 completes. This causes wake_up_bit() to dereference freed memory:

CPU 0 (Read I/O completion)         CPU 1 (f2fs_drop_cache / Truncation)
- f2fs_cache_read_end_io()
 - f2fs_unlock_cache(entry)
  - clear_and_wake_up_bit()
   - clear_bit_unlock(LOCKED)
   : bit is cleared!
                                    - f2fs_lock_cache(entry)
                                    : acquires lock!
                                    - f2fs_truncate_locked_cache(entry)
                                     - radix_tree_delete(&cache->root, ...)
                                     - entry->cache = NULL;
                                     - atomic_dec(&entry->refcount);
                                    - f2fs_unlock_cache(entry);
                                    - f2fs_put_cache(entry, false);
                                     - atomic_dec_and_test(&refcount) == 0
                                     - f2fs_do_free_cache(entry)
                                      - kfree(entry->data);
                                      - kfree(entry); <--- FREED!
   - smp_mb__after_atomic()
   - wake_up_bit(&entry->state, ...)
   : Dereferences &entry->state on freed entry! (UAF)

Like commit ("f2fs: cache: pin cached block in f2fs_end_cache_writeback()"),
acquire a temporary reference via f2fs_cache_get() before clear_and_wake_up_bit()
and release it with f2fs_cache_put() once wake_up_bit() completes.

This fixes commit 399410a90ca7 ("f2fs: cache: implement metadata cache")

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 7831e53f5678..04b5408cbc58 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -18,6 +18,8 @@
 #include <trace/events/f2fs.h>
 #include "segment.h"
 
+static bool f2fs_cache_put(struct f2fs_cached_block *entry);
+
 void f2fs_cache_wait_writeback_cond(struct f2fs_cached_block *entry,
 					enum page_type type)
 {
@@ -314,7 +316,19 @@ void f2fs_lock_cache(struct f2fs_cached_block *entry)
 
 void f2fs_unlock_cache(struct f2fs_cached_block *entry)
 {
+	/*
+	 * In asynchronous read I/O completion (e.g. from f2fs_ra_node_cache()),
+	 * the I/O completion does not hold a reference of its own. Once
+	 * clear_and_wake_up_bit() clears F2FS_BLOCK_LOCKED, a concurrent waiter
+	 * in f2fs_lock_cache() (e.g. from f2fs_truncate_cache()) can wake up,
+	 * truncate the entry, and drop the final reference before wake_up_bit()
+	 * finishes.
+	 * Pin the entry here to make sure it is not freed before wake_up_bit()
+	 * completes.
+	 */
+	f2fs_cache_get(entry);
 	clear_and_wake_up_bit(F2FS_BLOCK_LOCKED, &entry->state);
+	f2fs_cache_put(entry);
 }
 
 bool f2fs_put_cache(struct f2fs_cached_block *entry, bool unlock)
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
