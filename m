Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A205CA600E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GEuJZr0RRJTJzDMfCkrlILOEwwXFrvDKVRQUBLcvpbU=; b=WcIGTho1g3c/Unczt0FvzG1dfe
	XF8vuoVs6LwoalR3v/xqbKpsirOUsuP8IcKxmPwhS1JJFTIu27G1xmLUOVk4o4J18foyfRH7BH2Sb
	j0TG1mjdYcAWS9WQxyE03tdCxP8MNP7sE3ebesx+vvhvRxq9Lsh3nghP5UlDWdqQAcdg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xEkbI-0001RE-Vo;
	Thu, 08 Oct 2026 09:39:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1xEkbH-0001R8-TX
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 09:39:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r9Vukk6N1YBRmizRaHPB1EZVWo8i9kMuh2xPWHg64/0=; b=gNaSCcJrsO6Cc5HOcG8bGNpgGK
 wQTSX9WqmOIwTA2Vd5bLISNGGzM5pno5rhPXucAdcWjTsy20jwcT5UnPZqjmps+rU+jdSAUZnCydy
 V/RtI/wmNPYcxHCEr76XBlKi14I02/7VH5jAXsEp3iCUyGygIisE/iCRleAeW3/2xnU0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=r9Vukk6N1YBRmizRaHPB1EZVWo8i9kMuh2xPWHg64/0=; b=i
 pf5TZImSqLQZcqgmVSEXLaazecEEHWMOc3I6072AZ7E5UzQ0P/9+sVXmWsk1rJwzT83l9NZprSrZO
 IJrBNFF28KAJNwt5exb0+VCgkXLC4cUYhL3wf0OCKgtgqx8p5BsORj3mu6Msb5jBhYllEUu/2/LLx
 IkgG++JLVdWgF/u4=;
Received: from mail-pj1-f50.google.com ([209.85.216.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEkbE-0004iK-CD for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 09:39:41 +0000
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3aacde0cc0fso301822a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 02:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791452375; x=1792057175; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=r9Vukk6N1YBRmizRaHPB1EZVWo8i9kMuh2xPWHg64/0=;
 b=fYIBqnQR0zyPvBUFcNytyWHVNaoBOlmwaoWQ+ayujsXv4MN6Q3OqZmjKX1lhmyTNLl
 h+byoBgybSCKpfHm6rAoPYH7mVRzyua6SYUWPrSeg7FpV/wfx8mfXQhR8O7ey1IVZ05Z
 za6UpwRL2I+BIyju5zCYLpwhu9e5vDAnGLbUpqhU0Zi2ETDfCfqYoJV3UgeahMxQNWXx
 Ien/HCrQSTXVtCecS9TSltSWqwVg7fJp81fNfpnoGkNxFy9rzA9Mpt2iQY6EQkRRDXGR
 bacD+voH4UguQNrIgA2KQdw4gNhY6BkX2NjY3I1T/8kwmnzdt62Z7ZlFMvYm4et6DEXY
 RAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452375; x=1792057175;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r9Vukk6N1YBRmizRaHPB1EZVWo8i9kMuh2xPWHg64/0=;
 b=bUT6QlZ79AvjOtkr6V16mzbVvXiBdHyyy5/yEVXHhc3ftErgDz9Ypqrq4ydGh6sKcG
 W/PYz2EpDKNYC+xoSLzVLfFbiZHECvDJUIjnw6Fjpo7oFp2wDJcJmatMPqS7/IBfw2oh
 yN2lKYwym1VtmaVwhjqWKX1csl3hivSvQxpvSBRBMSLt0oPrmCIMIfTrdEEnR2iboYq8
 ORWHAjzLQ//YoWO5HxoFbvPH/6BJXQ5Hbe3JyOpVHiC319WmDZ6MkAF29UU3N0Zk1amu
 38iuK07PxShipI803MaIB9qN45xTspdU9hlFS728rl2tW5hrkUbsMX4etAjravaoqkvY
 3jUg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz20i0qmBiBA5kq8C+2RLt5o3uG9ll2Pp+4yRiLrQwtOVqI7L0ZntNtcxXAc96P+63Eb64ZrhWAKkbkb0iV/gga@lists.sourceforge.net
X-Gm-Message-State: AFq9FYL6tQq0xkDSliPYH3eI6+OntiUtaAbY3CBVQpTxkczjj94NedPy
 aK7SLMz7tGvgr10Q11U9fff64YUP6dUZc2sPxQcHrRRAkpz9buZihTm4
X-Gm-Gg: AYBFou1Qs/v8dGredScP8H4d/qYFJkvZrjcFfSWxmdtv/2lb5LWYtujpuOksFsof91C
 5FeMIABG5IitwZEgqXHEDkE4iW4CPQJaqkGXDxDfAUEhifgMe/If/MdLaqyN7/6sbEW++8Y1smA
 qDJfUiB+xxU9Ej5VjswZtfhv723jcmoW3dzgsgUzbmxXqyPmB99wx1OK8vgHkpO4FTvAFiIp9VY
 2Pt4IiFz78WB2OxKbUCRc7r8FoTuTvzuVXmgAK7trqXJdijF15CZnADHcgobBZD38KO0fGN4Ht9
 rmvzGXcB7z8UpXdQAEFxXavZ2bZEyRQ/KHs3ioKECgexEB5GVqd7S470D9lNi97Uo2+AxKF3t29
 TOfbRE+VPRoj8SXruh8Z0C/lcxZf1d2ikM7PAFi5GZE3Bw9MdaYkCQlDAU05ApRhsrttkM0+tOE
 Tyqiw+RkeH/9vO/B/BnFjr6A+L9Pgrb8Jyf3cUWVmHVugKN7QpgoeNiq8dhjvrEg1HSh9lvL5yy
 yPaAxjCZOmDlbp9quUg/7TY05vYp9TlaVA=
X-Received: by 2002:a17:90b:4d88:b0:3a4:6ff5:778 with SMTP id
 98e67ed59e1d1-3a8a117520cmr3439584a91.44.1791452374691; 
 Thu, 08 Oct 2026 02:39:34 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a9f1a7e9e4sm3564410a91.7.2026.10.08.02.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 02:39:33 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu,  8 Oct 2026 17:39:21 +0800
Message-ID: <20261008093921.2748828-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1xEkbE-0004iK-CD
Subject: [f2fs-dev] [PATCH] f2fs: use submitted bio size for completion
 offload
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
Cc: qwjhust@gmail.com, linux-kernel@vger.kernel.org, qiwenjie@xiaomi.com,
 bvanassche@acm.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

blk_update_request() advances bio->bi_iter before completing a bio.
As a result, f2fs_write_end_io() may see bi_size == 0 and fail to
offload large write bios according to max_atc_write_bio_size.

Save the submitted bio size and use it for the completion offload check.

Fixes: 3de6b8094115 ("f2fs: Run f2fs_write_end_io() asynchronously")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Based on f2fs/dev-test at ce439a2b0690. This includes the entry-count
threshold change; its condition is preserved by this patch.

 fs/f2fs/data.c | 7 +++++--
 fs/f2fs/f2fs.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2613e8821af6d..a5c11cbfda813 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -398,8 +398,9 @@ static void f2fs_write_end_io(struct bio *bio)
 
 	sbi = bio->bi_private;
 
-	if (in_atomic() && (bio->bi_iter.bi_size > sbi->max_atc_write_bio_size ||
-			F2FS_BIO(bio)->entry_cnt > sbi->max_atc_write_bio_entry_cnt)) {
+	if (in_atomic() &&
+	    (F2FS_BIO(bio)->submitted_size > sbi->max_atc_write_bio_size ||
+	     F2FS_BIO(bio)->entry_cnt > sbi->max_atc_write_bio_entry_cnt)) {
 		struct work_struct *w;
 
 		w = &container_of(bio, struct f2fs_bio, bio)->work;
@@ -614,6 +615,8 @@ static void f2fs_submit_write_bio(struct f2fs_sb_info *sbi, struct bio *bio,
 {
 	WARN_ON_ONCE(is_read_io(bio_op(bio)));
 	trace_f2fs_submit_write_bio(sbi->sb, type, bio);
+	/* bi_iter may be advanced by the block layer before end_io. */
+	F2FS_BIO(bio)->submitted_size = bio->bi_iter.bi_size;
 	iostat_update_submit_ctx(bio, type);
 	blk_crypto_submit_bio(bio);
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0acbc4d299af1..1b2390f39a68e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1779,6 +1779,7 @@ struct f2fs_bio {
 	struct work_struct work;
 	struct f2fs_cached_block *entry;
 	unsigned int entry_cnt;
+	unsigned int submitted_size;
 	struct bio bio;
 };
 
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
