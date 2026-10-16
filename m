Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7CACC6B38
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Oct 2026 02:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pl4gUlh5NBsAshmRCG8Ur0mG/L8XiD6VM9qCkEXBwWo=; b=Lcs9EoOQCgb0YFetD1lKwNmmRK
	4sTQbM347VStnOewRIr6E8APaWMMBika2utVDAhqGgk+7KHVb9YwidteDzasQ+q5uRmHR7m3xYTVT
	YL0gB3HL6/+0nNisWfKDWIK3VGgMXldw/mOrRJA93PmzVsLt1PrEm9UNF6NgZS6W3HiA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHXW7-0005qf-PV;
	Fri, 16 Oct 2026 02:17:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xHXW6-0005qZ-56
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 02:17:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L94us/dI4Z6GcNc8VtVqCl6M0xP+pjDIX04oSImnsOo=; b=M7v3m/c9ntMDCiN0Yqm2SLz4Rx
 AZjpSpN2TpmyyFSBDY5nVtsqMXnQCFQ6lLNYvajTCwHfa4bmUxaoNyI6blDG2iXhft1XCDNGqU6up
 kpyWk4cQuK4tlIcJAYFCGS1y0UIH6kIm1Szp4zYO/2Ag3V6SzucPOkyfl4cj/aKbze8I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=L94us/dI4Z6GcNc8VtVqCl6M0xP+pjDIX04oSImnsOo=; b=B
 D4Z6dBgIJp8wDLFfUNmPChxGDWsrpsSflrd7ycfuFnhSLOIr5401p69xYxigZWyOPJfMqJiE/HNPc
 +8MFMKAO9xM9X+EHyeZ5b+eGRidyrTJJBp1h3OFhbTLiBzT5Nw6bSD/lgT/YJNuycvpUxv018AMgO
 rlwve8Zi0jJe38cU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHXW2-0000Dc-9D for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 02:17:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C933D41490;
 Fri, 16 Oct 2026 02:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F188E1F000C4;
 Fri, 16 Oct 2026 02:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792117064;
 bh=L94us/dI4Z6GcNc8VtVqCl6M0xP+pjDIX04oSImnsOo=;
 h=From:To:Cc:Subject:Date;
 b=mT7GrIVYHl56Ghyh8drgVZIDxkh6da8hLUoTenII2SL7fBgbx8OHUcmHH3aXwrQiM
 dcbvuZADqHjWgx4iNxhiBbnIOoZucL9MO+EaH6MrnlKnjSp4pnb27/edeMN8Br+6uJ
 NakC3wPUUlGOwZpmrZXx/22XY9p4Me7uRJ8lTlGAIN0h5rwG09WOgC6NKFVsqsF7Nr
 hcHmwG5rAyOwACM9F/gJlwivjH9espZWMboudKjTSAokC3pffqoX28Lm/jg6a9oobx
 qhUc+VgougzxYXJTh0q/ftLEeBAVGGwj0oFgwFDJmwv6tTbrz2aCZwmAWCOFUuJu4e
 uq1p3QlPn9WUg==
To: jaegeuk@kernel.org
Date: Fri, 16 Oct 2026 10:17:37 +0800
Message-ID: <20261016021737.4121867-1-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
MIME-Version: 1.0
X-Headers-End: 1xHXW2-0000Dc-9D
Subject: [f2fs-dev] [PATCH] f2fs: fix to avoid potential reference count
 leak in do_garbage_collect()
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
Cc: stable@kernel.org, Daeho Jeong <daehojeong@google.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

In do_garbage_collect(), we have reserved reference counts on summary cache
of all segments, once gc_thread encounter freezing, we need to release all
reference counts.

Cc: stable@kernel.org
Cc: Daeho Jeong <daehojeong@google.com>
Fixes: 02d91398a602 ("f2fs: fix to freeze GC and discard threads quickly")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5bb117e5e811..ad6f604cc27f 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1901,6 +1901,9 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 		if (block_end_segno > end_segno)
 			block_end_segno = end_segno;
 
+		if (unlikely(freezing(current)))
+			goto next_block;
+
 		if (is_cursec(sbi, GET_SEC_FROM_SEG(sbi, segno))) {
 			f2fs_err(sbi, "%s: segment %u is used by log",
 							__func__, segno);
@@ -1968,12 +1971,6 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 				sbi->next_victim_seg[gc_type] =
 					(cur_segno + 1 < sec_end_segno) ?
 					cur_segno + 1 : NULL_SEGNO;
-
-			if (unlikely(freezing(current))) {
-				f2fs_put_cache(sum_entry, false);
-				f2fs_put_cache(sum_entry, false);
-				goto stop;
-			}
 		}
 next_block:
 		f2fs_put_cache(sum_entry, false);
@@ -1981,7 +1978,6 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 		segno = block_end_segno;
 	}
 
-stop:
 	if (submitted)
 		f2fs_submit_merged_write(sbi, data_type);
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
