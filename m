Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5ADCCA5FCE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Oct 2026 19:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yvurHEjIbnsapaqecX3gASwJEqmOvLOCw3eD2qGQnAU=; b=IBr11AfWFOYKVXuzPy3kwWwwgv
	5ANcDRH7+uSbtzRu50K2x2O+r+JHH7etS/UpgF7fgc1ZWc1O7zXv18pGzRykIkpftQx4TDbn93g9z
	LbjfumVboiYVFRGneoeIeIhMs8PoFgyYL5uRPo0dNkLpKviIS6KXLLZDEObced5Y4S/Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xDoFc-00066H-JN;
	Mon, 05 Oct 2026 19:21:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xDoFb-000665-IN
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 19:21:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZEnRrgsQfhAwpSCq6/7foeNKRR+8Ltv0O6gdOmb9ryo=; b=NkHp1Mgtgk6n+yqmmSB2xmNzsO
 QqK61rINzbdIMs8xAdl0EkkI5lhSSmx9OPokUaQDUj/c0JsfYCrvwB3KDCExfu5lRlj9YZ3nfY7Ew
 E9xXH1Js+sEkjxPs0b94ylol2dQKitVyjwvDA+G5vO2g36dOgNHeDNuna7lkbO8vw9/U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZEnRrgsQfhAwpSCq6/7foeNKRR+8Ltv0O6gdOmb9ryo=; b=j
 9UZVJem2/Dv8MGh/Tr/kcHDCB/WpoNH3Athsg+UmoA+qzC76nOhS0bUXGvegKktOq3ooSe+Zo26va
 FwGnh9NWkUYaJsXQaUwwoAN9UAStilATIKkDcq83fYCKoEgWtkba+F9Re+DAzIOMv75d+HJEjzLc4
 FrvZ7XlPsTovsSRo=;
Received: from mail-pj2-f42.google.com ([74.125.227.170])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDoFZ-0007ua-PN for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 19:21:28 +0000
Received: by mail-pj2-f42.google.com with SMTP id
 98e67ed59e1d1-396ccb65437so1147295a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791228080; x=1791832880; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZEnRrgsQfhAwpSCq6/7foeNKRR+8Ltv0O6gdOmb9ryo=;
 b=ABVC+U7z93GYXv62EI3KuFY/Wbq9cAyKCwFlCwOXw89b1vFXN7JZxpHUS3DFZjndUX
 37kSRBa92cAkl5/uOi0t+O2rPZRcckoIbgwbCPKz/L/ClYn54ofbfumCx5aNxsodI3TG
 79TYBdu5PO66ZLhrVpoZ+7lFcxhNP3qfJ+6yKK1PZLwRbfcZ0ZFeccvPDbhW+HzhABgW
 QolPX5EzGR6B32CB+MucFr515QLFcMWdVYi5EaMWijv3a3c+jaHpp4LUV3fd0OsOjSay
 aP59LCnkhDfolau6zJCtpQcrs9TGdIRTFT1xc/mxV9Khxx4qOu186D2/rXgAAGrKWWjj
 CL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791228080; x=1791832880;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZEnRrgsQfhAwpSCq6/7foeNKRR+8Ltv0O6gdOmb9ryo=;
 b=cdP38nuFT3tTg/yPtmCMWloRQp/faf/HAqSHPRIuUIZcE3DSAM8P92VsqeoNxMqqgM
 kP0KsPzST2zobc/Xfjk9JR1d887aWHwMY4OET6lBw52HFqA0jjD9f7vTFBiHi4x8ji0E
 4tq4ZvNVnBLnu9kWOzh8K4H1IJ3fP74MV+kozIBeDkWT0iL5ZRihAhMKzr/aUIpLY1bN
 +o6QOdBr8ZiaMpz9ScEOJUyNtWc9E0ZtpLi2wy7dgdGoNCVmcuAW7rqxB8WAtOFUzrUA
 9pRhAihkgj9p4qt+f8AK0kJVDD8Gua5yk7Fpay0E8eL3HtiBfUTMcbPGa2hf4eaBfGSf
 zaJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVhwlzblx88pE+1ENovVn/zgb73edS8/T98MUo22LnaBz6DAa5P3jvBmj/JrQ+MTZoWzVSrNrFZ7XoqsSycKHm@lists.sourceforge.net
X-Gm-Message-State: AFq9FYK86+KFeT3g5MFr8D7r+RlAcDUQF2+smUQmdXNr2k/a9vYxsz4A
 cyCGk9OCAQOoYOjBwNJXdxN9Y0gH9Ujhb+nA8glRtJDHhZSizd27O4Q7IcAjRg==
X-Gm-Gg: AYBFou3MHdVy44R70sgFbNKkxlpXfgE5SZeVMnf3xVjDseZoltLgKKSEnYSKufy4wGp
 kRtMNVJ0I0povHBkAoLn3QngOPoDK0BqOXlIIo1u7H+zlcyFTW3x2+sMD4kLkM7FzoYx1c7Komx
 GZqsVMgQrIrmsFxgz9Cm1OTRAaBhNNZppSg5kKJdu3bhAGTPBLIb2io39ECTp2vJaBYow3Zdunw
 dUYFu6tZh3+FxAoKDuuqk9cK/ob5DvVy1gNZ9hgaAhgnhiL+1LjRq9Wj2zq9ascEY+ji5aNcs6O
 cZ69pZqw1CuNjNr5U6EouRsGIofn5KmCF9NofgfxnUV7sSIoaI5EIMxG3WjvAx4irMjORbm1DER
 srral9+WdkD8bVjpa6TBQ5WPBNveLk7ahtcYj530XB9AGoV8oo5x2e5ys0AXoXZwnF7eiRvVKaW
 iq1PwjfcHmrpo9lh2ToTG9iHGYMUNH0LRMfNixpBNrnr7ZXx4b2OCTb5zeyZM59Mi9inbMfgIKO
 Qv/b79sb2F5laTlXFY2Jwr0jAFfOgumLgUZdm+XOcmX8GpksMIOGAEzutnK8kwhkrLMte6gYhhT
 zjb54y9IUWZBZSs=
X-Received: by 2002:a17:90a:dfc5:b0:3a1:8b70:d46b with SMTP id
 98e67ed59e1d1-3a6ce80d87amr8315562a91.42.1791228079952; 
 Mon, 05 Oct 2026 12:21:19 -0700 (PDT)
Received: from f2fs-test.c.googlers.com.com
 (225.134.16.34.bc.googleusercontent.com. [34.16.134.225])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a85436fb54sm820286a91.10.2026.10.05.12.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 12:21:18 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  5 Oct 2026 19:21:13 +0000
Message-ID: <20261005192114.1511660-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
MIME-Version: 1.0
X-Headers-End: 1xDoFZ-0007ua-PN
Subject: [f2fs-dev] [PATCH] f2fs: cache: count the temporary pins apart from
 the regular references
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

f2fs_unlock_cache() and f2fs_end_cache_writeback() take a temporary
reference on the entry around clear_and_wake_up_bit(), so that the entry
is not freed before wake_up_bit() returns. f2fs_destroy_cache() waits
for the LOCKED and WRITEBACK bits and then expects the refcount to be 1,
but the bit waits can return as soon as the bit is cleared, before the
I/O completion drops the temporary reference. When the completion runs
in process context and is preempted there (e.g. dm-flakey in
generic/311), umount hits:

  kernel BUG at fs/f2fs/cache.c:567!
  f2fs_destroy_cache+0x260/0x268
  f2fs_put_super+0x1fc/0x428

Count the temporary references in units of F2FS_CACHE_PIN_BIAS, like
GUP_PIN_COUNTING_BIAS for folios, and check only the regular references
in f2fs_destroy_cache(). A leaked regular reference is still caught
there, without waiting for the completion.

The pinned entry is freed by whichever of f2fs_cache_put() and
f2fs_cache_unpin() drops the refcount to zero, as before. The shrinker
still skips an entry while it is pinned, since the refcount is then
neither 1 nor below 3.

Fixes: 6e392158cf54 ("f2fs: cache: pin cached block in f2fs_end_cache_writeback()")
Fixes: 61ba87b33e87 ("f2fs: cache: pin cached block in f2fs_unlock_cache()")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/cache.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 04b5408cbc5..a75578cd4e3 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -18,7 +18,7 @@
 #include <trace/events/f2fs.h>
 #include "segment.h"
 
-static bool f2fs_cache_put(struct f2fs_cached_block *entry);
+static void f2fs_free_cache(struct f2fs_cached_block *entry);
 
 void f2fs_cache_wait_writeback_cond(struct f2fs_cached_block *entry,
 					enum page_type type)
@@ -111,6 +111,27 @@ void f2fs_start_cache_writeback(struct f2fs_cached_block *entry)
 				F2FS_CACHE_TAG_WRITEBACK);
 }
 
+/*
+ * The temporary references taken around clear_and_wake_up_bit() are counted
+ * in units of F2FS_CACHE_PIN_BIAS, like GUP_PIN_COUNTING_BIAS for folios, so
+ * that they can be told apart from the regular references.
+ */
+#define F2FS_CACHE_PIN_BIAS	(1 << 16)
+
+static void f2fs_cache_pin(struct f2fs_cached_block *entry)
+{
+	atomic_add(F2FS_CACHE_PIN_BIAS, &entry->refcount);
+}
+
+static void f2fs_cache_unpin(struct f2fs_cached_block *entry)
+{
+	int ref = atomic_sub_return(F2FS_CACHE_PIN_BIAS, &entry->refcount);
+
+	WARN_ON_ONCE(ref < 0);
+	if (!ref)
+		f2fs_free_cache(entry);
+}
+
 void f2fs_end_cache_writeback(struct f2fs_cached_block *entry)
 {
 	/*
@@ -125,9 +146,9 @@ void f2fs_end_cache_writeback(struct f2fs_cached_block *entry)
 	 * But here we must make sure that the entry is not freed and
 	 * reused before clear_and_wake_up_bit().
 	 */
-	f2fs_cache_get(entry);
+	f2fs_cache_pin(entry);
 	clear_and_wake_up_bit(F2FS_BLOCK_WRITEBACK, &entry->state);
-	f2fs_cache_put(entry);
+	f2fs_cache_unpin(entry);
 }
 
 static int f2fs_cache_refcount(struct f2fs_cached_block *entry)
@@ -135,6 +156,12 @@ static int f2fs_cache_refcount(struct f2fs_cached_block *entry)
 	return atomic_read(&entry->refcount);
 }
 
+/* the number of regular references, excluding the temporary ones */
+static int f2fs_cache_users(struct f2fs_cached_block *entry)
+{
+	return f2fs_cache_refcount(entry) & (F2FS_CACHE_PIN_BIAS - 1);
+}
+
 static void f2fs_do_free_cache(struct f2fs_cached_block *entry)
 {
 	kfree(entry->data);
@@ -326,9 +353,9 @@ void f2fs_unlock_cache(struct f2fs_cached_block *entry)
 	 * Pin the entry here to make sure it is not freed before wake_up_bit()
 	 * completes.
 	 */
-	f2fs_cache_get(entry);
+	f2fs_cache_pin(entry);
 	clear_and_wake_up_bit(F2FS_BLOCK_LOCKED, &entry->state);
-	f2fs_cache_put(entry);
+	f2fs_cache_unpin(entry);
 }
 
 bool f2fs_put_cache(struct f2fs_cached_block *entry, bool unlock)
@@ -564,7 +591,8 @@ void f2fs_destroy_cache(struct f2fs_cached_block_list *cache)
 	f2fs_bug_on(cache->sbi, f2fs_cache_test_dirty(entry));
 	f2fs_bug_on(cache->sbi, f2fs_cache_test_writeback(entry));
 	f2fs_bug_on(cache->sbi, !list_empty(&entry->list));
-	f2fs_bug_on(cache->sbi, f2fs_cache_refcount(entry) != 1);
+	/* the I/O completion may not have unpinned the entry yet */
+	f2fs_bug_on(cache->sbi, f2fs_cache_users(entry) != 1);
 	f2fs_put_cache(entry, true);
 	goto next;
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
