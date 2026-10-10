Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7B1CA9EC1
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 10 Oct 2026 06:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3g9O8RCy83q/9SM+1vk2JhSk3DaifGYuB0W+CpU5UDY=; b=IUS+dtKaFcR7BeMpoMHbHWsOxY
	IzPfFDsKTr3T3bHdz7PkAMxCr2qniNmfHmNg8bMN6/Xld/Ivte86m9/uXESE6i6z8mg6nA3q6Ey1S
	s4Qb4Jsb29im0/12MuAeH2RUvfM1bVjTz9NOoumZPEVanqZ6AMLjHbDypaENVqDE4xFc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFR01-0002cg-4N;
	Sat, 10 Oct 2026 06:56:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xFQzv-0002cB-C1
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 06:56:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JOiUkN7r2Yeqd3aPeXM7mU/7MNeWq1sCh7vWVmWB6IM=; b=YgvEeGc0Q69MlJstIY9rvQUG7I
 jS5rz4KiHUD5IGaDZhnMUa5M8thwJtWVoDrqNjMzjD4u75msxyiOYPWr7Bd4mNn7j38lB8ycEPE9v
 ic4UX4RhHkkpUhyB8UeDdb6EXNZfmiz1IvTpGZcg2moab/lGRQWJzB54fIlgZUmbvH8A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JOiUkN7r2Yeqd3aPeXM7mU/7MNeWq1sCh7vWVmWB6IM=; b=Cp78jAEGJ+pu+LktNpMKvpNX0b
 r/ePczajw1g8usmXKYwRbklCpkA6TF5LYXvtUaCt8gb6z3Q6xH6vaM5+Av8EqYg9tQCp/3YPYfpdb
 OxJlSHlRWrDXem5cesa2iHMpWLFURVqsyQQghnV52zXWrTDrF8Aw5yp7HkCvVvfPmcGw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFQzu-0002be-PR for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 06:56:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6B1EF4058B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 10 Oct 2026 06:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B90A1F00893;
 Sat, 10 Oct 2026 06:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791615353;
 bh=JOiUkN7r2Yeqd3aPeXM7mU/7MNeWq1sCh7vWVmWB6IM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GdCJdeCVWTngnRoJPARDVzsKUxv9wJM3oQuo+SGP3xA5kRR4+R9NeH3R2OTSVQHVX
 iK1v5dDlh01XBndl3MZfj0ERycFAuzdXy/cedmu2NyNErjGfjzm0LbVmJJRiwynvsS
 0DEhYkHOoLWaWthnwNCtcBSGSL2tUmGx/eXFRWmyo57547W+iJjqTMCCAeUVdaZRpZ
 esAmxMXpAU1bLqiBQqvWSABUmgu5xgwvrCgSu+Li8X0QpMWE7DfrMHqALzIoPaSdTJ
 iKYF7axicYp5V1mzjqVItI67N/6Zxo5IeMU7tdaYoOaij6EvaXtNVsdFhgn+DHiofg
 RPv8PFbO/yNHQ==
To: jaegeuk@kernel.org
Date: Sat, 10 Oct 2026 14:55:46 +0800
Message-ID: <20261010065546.1762091-2-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261010065546.1762091-1-chao@kernel.org>
References: <20261010065546.1762091-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xFQzu-0002be-PR
Subject: [f2fs-dev] [PATCH 2/2] f2fs: fix to use bio_in_atomic() in
 f2fs_read_end_io()
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

f2fs_read_end_io() uses "in_task() && !irqs_disabled()" to decide
whether it is safe to sleep, the result is passed down as @in_task to:
- f2fs_put_dic() -> f2fs_free_dic() -> f2fs_release_decomp_mem()
  -> vm_unmap_ram(), which may sleep.
- f2fs_end_read_compressed_page() -> f2fs_cache_compressed_page()
  -> f2fs_grab_cache() -> f2fs_lock_cache(), which may sleep in
  wait_on_bit_lock().

However, the check still treats below task contexts as sleepable:
- with spinlock held via spin_lock(), i.e. preempt count != 0 while
  irqs are enabled.
- with BH disabled via local_bh_disable().
- inside an RCU read lock on kernels with CONFIG_PREEMPTION.
- with any spinlock held on kernels without CONFIG_PREEMPT_COUNT.

So the "sleeping function called from invalid context" issue fixed by
commit 08a7efc5b02a ("f2fs: vm_unmap_ram() may be called from an
invalid context") can still be triggered.

The block layer provides bio_in_atomic() for exactly this purpose, it
checks rcu_preempt_depth() and preemptible(), and conservatively returns
true if CONFIG_PREEMPT_COUNT is disabled, let's use it instead. The
difference is as below:

 old: intask = in_task() && !irqs_disabled()
 new: intask = !bio_in_atomic()

 Context                              | old intask     | new intask
 -------------------------------------+----------------+----------------
 Hard IRQ / softirq                   | false          | false
 IRQs disabled                        | false          | false
 spin_lock() held, IRQs enabled       | true (wrong)   | false
 BH disabled by local_bh_disable()    | true (wrong)   | false
 RCU read lock (CONFIG_PREEMPTION)    | true (wrong)   | false
 Spinlock held, w/o PREEMPT_COUNT     | true (wrong)   | false

Note that on kernels without CONFIG_PREEMPT_COUNT, bio_in_atomic()
always returns true, so dic freeing will always be offloaded to sbi->wq,
and compressed pages will not be cached in f2fs_read_end_io(); this is
the price of correctness, since there is no way to tell whether the
current context can sleep.

Cc: stable@kernel.org
Fixes: 08a7efc5b02a ("f2fs: vm_unmap_ram() may be called from an invalid context")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 86150f7a372c..8da443fec0a6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -271,7 +271,7 @@ static void f2fs_read_end_io(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi = F2FS_F_SB(bio_first_folio_all(bio));
 	struct bio_post_read_ctx *ctx;
-	bool intask = in_task() && !irqs_disabled();
+	bool intask = !bio_in_atomic();
 
 	iostat_update_and_unbind_ctx(bio);
 	ctx = bio->bi_private;
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
