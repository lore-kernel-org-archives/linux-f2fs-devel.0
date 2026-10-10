Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4A8CA6017
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 10 Oct 2026 06:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8TijGtfcpFNL7XPN0fsU48KXVfAQHlk2KzkJcYCeg/M=; b=irQa6xpzLR/IqGmdgB78IcHrrO
	EdG2hv6DTXvzuvF0U11tb/gffXhTUmum3XO+3hGbzN2McXM7MQD1PO952R/LOtHmvd3flevoOvcbQ
	2+0Hgyp+IUr/m6urWjO1o+QVgb8fJ3oUiJGHySqtVnzKEuPZXXZX+TG41Pxgoare+DX8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFR02-0001qC-Os;
	Sat, 10 Oct 2026 06:56:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xFQzx-0001pl-9F
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 06:55:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QRWnPGtWKckNp3hs8edix9eHlTIjDYrtAUIeCheZUps=; b=L7SJN2abZEDDAgkXZ9VDzSIsUy
 0PSmGtQ4LB+ROOziTLzCqd/FTfFomD5ITYOWUYSutNyYPPiHX2jQiXcMYdV6ZJdgkVcTeqJp5OZqN
 mheL16b2/+WxGGLeRL//ttY6XsyblM5KI4klY9zWPekg1XLkzLCrdR3dBrjPbJErDjBA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QRWnPGtWKckNp3hs8edix9eHlTIjDYrtAUIeCheZUps=; b=j
 E42RT4fFl3C1iOlScuzNjUz2FHkSRKVixgUmL5nPFHHXhWxSEzTxkJIB1O7YvaQAH87xqatu+GJwS
 F+acCSm3s3KIL+ds5KxCE5QucQarjZTyO/Z6T6f6y2BNt+EnC3d6ZTqMuQhxTms4wJOFLCqJBcFMT
 A1ljesV2/AaKAtOw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFQzt-0001kM-RW for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 06:55:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 31D5060211
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 10 Oct 2026 06:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5C91F000FF;
 Sat, 10 Oct 2026 06:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791615351;
 bh=QRWnPGtWKckNp3hs8edix9eHlTIjDYrtAUIeCheZUps=;
 h=From:To:Cc:Subject:Date;
 b=OH80fbb7FijIsySrCttb8hNTS0py1Tro1H3JnuxrFmx6UbThO+JXzIiQfsKTusWFR
 a0rkAQXZbpoQagFC2GpYv4ZulK6+YIpEDCCJPm6VSLGYXrExGljrmqmT49ot2SynbO
 9JWskV+pdL3psv0K1YBQjMlKqVV4pHhiLLK9PKbmIqJc/i6yMq0qZgdUHHW0CShS3a
 V3Vwuw1ss9y5W/THs75nt7GrwV2wjSarT7MjdCrx5XcBwBVWd61y8RRFDZ6/PbtjmF
 FyByD0FJbS5FUxLPSfHZDPbR2WBceWcdA+r6ZWHeDOu3P5uv48APr6GIAx2XFT5Jxo
 5ObqeGhvZ5V0w==
To: jaegeuk@kernel.org
Date: Sat, 10 Oct 2026 14:55:45 +0800
Message-ID: <20261010065546.1762091-1-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
MIME-Version: 1.0
X-Headers-End: 1xFQzt-0001kM-RW
Subject: [f2fs-dev] [PATCH 1/2] f2fs: fix to use bio_in_atomic() in
 f2fs_write_end_io()
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

f2fs_write_end_io() uses in_atomic() to decide whether a write bio which
exceeds max_atc_write_bio_size or max_atc_write_bio_entry_cnt should be
completed in sbi->wq rather than in the current context.

However, in_atomic() is not meant to be used outside core kernel code
(checkpatch.pl warns about it), as it only looks at preempt_count(): it
misses irqs-disabled and RCU read-side critical sections, and on kernels
without CONFIG_PREEMPT_COUNT it cannot see spinlock-held sections at all.
In those contexts, a large write bio will still be completed inline,
which defeats the purpose of the above knobs.

The block layer provides bio_in_atomic() for exactly this purpose, it
checks rcu_preempt_depth() and preemptible(), and conservatively returns
true if CONFIG_PREEMPT_COUNT is disabled, let's use it instead. The
difference is as below:

 Context                              | in_atomic()    | bio_in_atomic()
 -------------------------------------+----------------+----------------
 Hard IRQ / softirq                   | true           | true
 IRQs disabled, preempt count 0       | false (missed) | true
 RCU read lock (CONFIG_PREEMPTION)    | false (missed) | true
 Kernel w/o CONFIG_PREEMPT_COUNT      | IRQ ctx only   | always true

Note that on kernels without CONFIG_PREEMPT_COUNT, write bios exceeding
the thresholds will always be offloaded to sbi->wq, since there is no way
to tell whether the current context is atomic. The thresholds default to
UINT_MAX, so the default behavior is not changed.

Cc: stable@kernel.org
Fixes: 3de6b8094115 ("f2fs: Run f2fs_write_end_io() asynchronously")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2613e8821af6..86150f7a372c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -398,8 +398,9 @@ static void f2fs_write_end_io(struct bio *bio)
 
 	sbi = bio->bi_private;
 
-	if (in_atomic() && (bio->bi_iter.bi_size > sbi->max_atc_write_bio_size ||
-			F2FS_BIO(bio)->entry_cnt > sbi->max_atc_write_bio_entry_cnt)) {
+	if (bio_in_atomic() &&
+	    (bio->bi_iter.bi_size > sbi->max_atc_write_bio_size ||
+	     F2FS_BIO(bio)->entry_cnt > sbi->max_atc_write_bio_entry_cnt)) {
 		struct work_struct *w;
 
 		w = &container_of(bio, struct f2fs_bio, bio)->work;
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
