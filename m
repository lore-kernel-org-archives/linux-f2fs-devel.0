Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27932CA5FC4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Sep 2026 23:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6Nc14fnHNTYQ4NfGMUHjUDndL4dgSAYjaKO6kCix+cw=; b=GUZosTmIChi0GrMQEbpqHT9pVM
	ife/szqc7EfW4oqaZADQKe10/QrAA4WvC9C2r0VhTNb0+yMOxNx3g5OOxYibHyX2eUbejGMu5Ea8U
	tv6DObeQ0cFsc0Ut6pXy6qsxjwVkuYzAFBEpQ1nyVa5Bqg7CDYi8sIQCzOssFeTm7ei8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xC48Q-0006hL-P8;
	Wed, 30 Sep 2026 23:54:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xC48N-0006hD-Gy
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 23:54:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LLgbJMciNYXzfOaMeH8TIVdRk5weLJbhP8q1PNI6ADw=; b=X+3SsRqsviYQmvvCAqlwfR56Pn
 G7tb8hV001pZTqMwXpnsrJBURq3I3HLNENeIdPB0NunTOPZKHA83H9jH8606fERRa3J6YSs6BSwiq
 l1iK+L5gKYse3jfck7Ex1lNQdsa/chcQI1jMmf7G5oLbiijzZiVl4kZtyEkqJmPbTxMg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LLgbJMciNYXzfOaMeH8TIVdRk5weLJbhP8q1PNI6ADw=; b=P
 sAFvtp2Y5QYjA6tzWB/c5iCe4wyiSqjMiBlFrCn90lQh6WFjbhonw0hu8VQ/VTCj1mkM1KGVjbyrp
 YCsXzXnfd30nBrUa4GybzobaGoVzd5bDVjBEOJRwv8daV47XnMzsSsFYpwzdyU2COmCot9MkNUYOM
 j5h88jQX85t/5RV0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xC48N-0002KJ-Kr for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 23:54:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F0A40601FF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 23:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27C61F000FF;
 Wed, 30 Sep 2026 23:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790812481;
 bh=LLgbJMciNYXzfOaMeH8TIVdRk5weLJbhP8q1PNI6ADw=;
 h=From:To:Cc:Subject:Date;
 b=WIkU2sJtnTGPhQtXkWtnyDs+DQjrUhwvJ1epEhSB4+iDfyUB/oNFYJJJi21XSrd2z
 dHkGpOVnUCLOJYCBC0frKDfpRKwpDCryj4qzCgaT8nuXezr1BoZqlyFfpz7jCHAmTS
 wEhLLcwi1tMJkQ4UjimSazBx9M5aN9znjX/yLocoQU5nc7JOkelSOb3CZBmmj7qGJX
 1k5uGrFy3bVVjqH5FOl5sVRnc/A17+jokE/ZMHRuvIOXxdZrTzVghvdh5AkJ9yAbXq
 tcTgt3HOy71TKhgOYq0ZJqDl5eXCmxSSOssWqHu1XILdxHFJ+18694BsVX4fz1PZNu
 R+3es9gT3uvHw==
To: jaegeuk@kernel.org
Date: Wed, 30 Sep 2026 23:54:34 +0000
Message-ID: <20260930235435.3789910-1-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
MIME-Version: 1.0
X-Headers-End: 1xC48N-0002KJ-Kr
Subject: [f2fs-dev] [PATCH 1/2] f2fs: cache: pin cached block in
 f2fs_end_cache_writeback()
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

Like page cache folios, writeback does not hold an active reference on
the cached block during I/O flight, relying instead on truncation or
shrinker callers to wait on F2FS_BLOCK_WRITEBACK before releasing the entry.

However, in f2fs_end_cache_writeback(), clear_and_wake_up_bit() executes
two distinct steps:
1. clear_bit_unlock(F2FS_BLOCK_WRITEBACK, &entry->state): clears the bit.
2. wake_up_bit(&entry->state, F2FS_BLOCK_WRITEBACK): hashes &entry->state
   to look up the waitqueue and wakes waiting tasks.

Once step 1 clears the bit, a concurrent waiter in f2fs_do_truncate_cache()
or f2fs_do_shrink_cache() is immediately unblocked. The waiter can proceed
to delete the entry from the radix tree, drop the final reference, and
kfree() the entry before step 2 finishes, causing wake_up_bit() to access
freed memory:

CPU 0 (I/O completion)               CPU 1 (Truncation / Shrinker)
- f2fs_cache_write_end_io()
 - f2fs_end_cache_writeback(entry)
  - clear_and_wake_up_bit()
   - clear_bit_unlock(WRITEBACK)
   : bit is cleared!
                                     - f2fs_do_truncate_cache(entry)
                                      - f2fs_cache_wait_writeback(entry)
                                      : sees WRITEBACK cleared!
                                      - radix_tree_delete(&cache->root, ...)
                                      - f2fs_put_cache(entry, true)
                                       - atomic_dec_and_test(&refcount) == 0
                                       - f2fs_do_free_cache(entry)
                                        - kfree(entry->data);
                                        - kfree(entry); <--- FREED!
   - smp_mb__after_atomic()
   - wake_up_bit(&entry->state, ...)
   : Dereferences &entry->state on freed entry! (UAF)

Mirror the logic in folio_end_writeback() by acquiring a temporary reference
via f2fs_cache_get() before clear_and_wake_up_bit() and releasing it with
f2fs_cache_put() once wake_up_bit() completes. This guarantees the entry
can not be freed until wake_up_bit() has finished.

This fixes commit 399410a90ca7 ("f2fs: cache: implement metadata cache").

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 38fc5eb17f92..7831e53f5678 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -117,7 +117,15 @@ void f2fs_end_cache_writeback(struct f2fs_cached_block *entry)
 	 */
 	f2fs_cache_update_tag(entry, F2FS_CACHE_TAG_WRITEBACK,
 						F2FS_CACHE_TAG_NONE);
+	/*
+	 * Writeback does not hold an entry reference of its own, relying
+	 * on truncation to wait for the clearing of F2FS_BLOCK_WRITEBACK.
+	 * But here we must make sure that the entry is not freed and
+	 * reused before clear_and_wake_up_bit().
+	 */
+	f2fs_cache_get(entry);
 	clear_and_wake_up_bit(F2FS_BLOCK_WRITEBACK, &entry->state);
+	f2fs_cache_put(entry);
 }
 
 static int f2fs_cache_refcount(struct f2fs_cached_block *entry)
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
