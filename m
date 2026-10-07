Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A28CA5FFC
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OrXnCU4/Eh4KNLTL1aGiishArRYNLkAeQdnHT5yFWTo=; b=D6URaNoJD/Jz8VS2XQuT76JZNK
	HXem6K0VjGP4MOEi95ovYRfrB1C2DZLhI6ZVxQuPKYhK2ouHDD5m4kSC1hf64HjxyULtk2b23TO4m
	U9BZ0S7kIOwWqlLdF/akgAQMG2cngJBLtexUlMoGD2e5ERSJIcGr1TRjXvDaq0QOQGsw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xEQA3-0004mM-Dm;
	Wed, 07 Oct 2026 11:50:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xEQ9z-0004m6-Eq
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 11:50:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x41muMHTfMYZOVwgw5U3Ok4EV+qcMUNKpCjaY2C03kg=; b=SQxvlunVC0nvBJq4ulPygme5/Q
 kJ1Rn0P2PVcnJapXEQLkEjBiSglm7LicccKHI6aCoxkdrBJMLeUxrALELmsQ6JldjKHP1EUnIgTnl
 1Q0n+NM5L5juJ4i4mivK3Bx3zztJwwK3YHg+P72/i+z48yNPc/FM4FpvdluWE8Av8mWY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=x41muMHTfMYZOVwgw5U3Ok4EV+qcMUNKpCjaY2C03kg=; b=EkD1p82pevFQLU2V56WxmS+Tkd
 QH2oetUMlWDqqMYc1SkvMGhR3ixAYi/Mp7DgfVWo5FqwMLcWvcie9D0mZ1I/IT3fUZDvocsUWzYnt
 9UFne+aRQYvFp4NrK3HZOyq/B1Bx2Soddr6odUu2iZI/NHiyINILOlpVsgcOsir2VP+w=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xEQ9u-0001IJ-6E for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 11:50:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3C58424B6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  7 Oct 2026 11:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DBF1F008A0;
 Wed,  7 Oct 2026 11:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791373800;
 bh=x41muMHTfMYZOVwgw5U3Ok4EV+qcMUNKpCjaY2C03kg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RreF8+oRw/MjNGMozbyaHuQ1Huy01BkG5v0ePhuNVvkMBwvM3RcfcoOM/B2ykFLCF
 bP8ZrC3DiSMkCQlqrqFnhwqUktIc1k01bVPmPglJsti+zUDUs8DcjOAPBtmFjXTmM3
 CIgGb0n//562HDLc9CiL2WkHL6nM1D6EvMSKPi8G5RYIZoxwfGGhhQg4V39uzEdxVR
 Isw0S6a5U3sHW2LbE4pzxXn8l2lMjdQGZiOaGra34BkHfGs/boZAZIX2pgSBJvbYPI
 VtXgKCaPv8i5+ftRW25SJ6jxe4KZRi7yyjtsKla/SU9ybQTWul8R8k9nKNAr3wr+pX
 ZwDk/vkboQqaA==
To: jaegeuk@kernel.org
Date: Wed,  7 Oct 2026 11:49:48 +0000
Message-ID: <20261007114949.2428048-4-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20261007114949.2428048-1-chao@kernel.org>
References: <20261007114949.2428048-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xEQ9u-0001IJ-6E
Subject: [f2fs-dev] [PATCH 4/5] f2fs: cache: support asynchronous
 write_end_io
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

Currently, f2fs_cache_write_end_io() synchronously traverses all
cached blocks in the write bio to perform node footer sanity checks,
warm node cleanup, and writeback completion. If called from atomic
context (e.g. interrupt context) with a large batch of metadata
blocks, this traversal can induce significant IRQ latency.

Furthermore, f2fs_write_end_io() already implements asynchronous
offloading via workqueue when in atomic context and exceeding the
max_atc_write_bio_size threshold.

To avoid code duplication and mitigate atomic context latency for
metadata cache writes:
1. Unify the write completion handler by pointing all write bios to
   f2fs_write_end_io() with bio->bi_private = sbi.
2. In f2fs_write_end_bio(), check f2fs_is_cache_bio(bio) to dispatch
   to f2fs_cache_write_end_bio().
3. Simplify f2fs_zone_write_end_io() to call f2fs_write_end_io() directly.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 92 +++++++++++++++++++++++---------------------------
 1 file changed, 42 insertions(+), 50 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6d4ba5e77906..0a6aa24caa07 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -298,6 +298,40 @@ static void f2fs_read_end_io(struct bio *bio)
 	f2fs_verify_and_finish_bio(bio, intask);
 }
 
+static void f2fs_cache_write_end_bio(struct bio *bio)
+{
+	struct f2fs_cached_block *entry = F2FS_BIO(bio)->entry;
+	struct f2fs_sb_info *sbi = entry->cache->sbi;
+	struct f2fs_cached_block *next;
+
+	if (bio->bi_status != BLK_STS_OK)
+		f2fs_stop_checkpoint(sbi, true,
+			STOP_CP_REASON_WRITE_FAIL);
+
+	while (entry) {
+		next = entry->next_entry;
+		entry->next_entry = NULL;
+
+		if (f2fs_is_node_cache(entry)) {
+			f2fs_sanity_check_node_footer(sbi, entry,
+				entry->index, NODE_TYPE_REGULAR, true);
+			f2fs_bug_on(sbi, entry->index != nid_of_node(sbi, entry));
+		}
+		if (f2fs_in_warm_node_list(sbi, entry))
+			f2fs_del_fsync_node_entry(sbi, entry);
+
+		dec_cache_count(sbi, F2FS_WB_CP_DATA);
+
+		if (!get_nr_caches(sbi, F2FS_WB_CP_DATA) &&
+				wq_has_sleeper(&sbi->cp_wait))
+			wake_up(&sbi->cp_wait);
+
+		f2fs_end_cache_writeback(entry);
+		entry = next;
+	}
+	bio_put(bio);
+}
+
 static void f2fs_write_end_bio(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi = bio->bi_private;
@@ -306,6 +340,11 @@ static void f2fs_write_end_bio(struct bio *bio)
 	if (time_to_inject(sbi, FAULT_WRITE_IO))
 		bio->bi_status = BLK_STS_IOERR;
 
+	if (f2fs_is_cache_bio(bio)) {
+		f2fs_cache_write_end_bio(bio);
+		return;
+	}
+
 	bio_for_each_folio_all(fi, bio) {
 		struct folio *folio = fi.folio;
 		enum count_type type;
@@ -404,45 +443,6 @@ static void f2fs_cache_read_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-static void f2fs_cache_write_end_io(struct bio *bio)
-{
-	struct f2fs_cached_block *entry = F2FS_BIO(bio)->entry;
-	struct f2fs_sb_info *sbi = entry->cache->sbi;
-	struct f2fs_cached_block *next;
-
-	iostat_update_and_unbind_ctx(bio);
-
-	if (time_to_inject(sbi, FAULT_WRITE_IO))
-		bio->bi_status = BLK_STS_IOERR;
-
-	if (bio->bi_status != BLK_STS_OK)
-		f2fs_stop_checkpoint(sbi, true,
-			STOP_CP_REASON_WRITE_FAIL);
-
-	while (entry) {
-		next = entry->next_entry;
-		entry->next_entry = NULL;
-
-		if (f2fs_is_node_cache(entry)) {
-			f2fs_sanity_check_node_footer(sbi, entry,
-				entry->index, NODE_TYPE_REGULAR, true);
-			f2fs_bug_on(sbi, entry->index != nid_of_node(sbi, entry));
-		}
-		if (f2fs_in_warm_node_list(sbi, entry))
-			f2fs_del_fsync_node_entry(sbi, entry);
-
-		dec_cache_count(sbi, F2FS_WB_CP_DATA);
-
-		if (!get_nr_caches(sbi, F2FS_WB_CP_DATA) &&
-				wq_has_sleeper(&sbi->cp_wait))
-			wake_up(&sbi->cp_wait);
-
-		f2fs_end_cache_writeback(entry);
-		entry = next;
-	}
-	bio_put(bio);
-}
-
 #ifdef CONFIG_BLK_DEV_ZONED
 static void f2fs_zone_write_end_io(struct bio *bio)
 {
@@ -450,10 +450,7 @@ static void f2fs_zone_write_end_io(struct bio *bio)
 
 	bio->bi_private = io->bi_private;
 	complete(&io->zone_wait);
-	if (f2fs_is_cache_bio(bio))
-		f2fs_cache_write_end_io(bio);
-	else
-		f2fs_write_end_io(bio);
+	f2fs_write_end_io(bio);
 }
 #endif
 
@@ -548,13 +545,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 		else
 			bio->bi_end_io = f2fs_read_end_io;
 	} else {
-		if (fio->is_cache) {
-			bio->bi_end_io = f2fs_cache_write_end_io;
-		} else {
-			bio->bi_end_io = f2fs_write_end_io;
-			bio->bi_private = sbi;
-		}
-
+		bio->bi_end_io = f2fs_write_end_io;
+		bio->bi_private = sbi;
 		bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi,
 						fio->type, fio->temp);
 		bio->bi_write_stream = f2fs_io_type_to_write_stream(bdev, fio->type,
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
