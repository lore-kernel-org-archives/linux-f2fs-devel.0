Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EE9CD3427
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  5 May 2026 12:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cdff/YWvcCV4ExJwRloO1ToSFelC5UkiH8puChJyna8=; b=ZREaxOCBDmb07I/977GeI8GnLT
	uhSEJC7w0XcVRlnnIgS4TGnUZdJI8iJOf9YRNfEPEqXbeEpRz4J0+NbJyMIi1n8LdeyB8xnyJIrUh
	Sq27p0WzHvnrrFJLllQgEJVxIGzfOS7En1nR23XMr3Elhgsc7XD4GAofqpPV1nfY9WTM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wKFJT-0001BK-8V;
	Tue, 05 May 2026 12:55:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zzzccc427@gmail.com>) id 1wKFJL-0001Ad-RZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 May 2026 12:55:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O+1kudbJjsIZWx5ktJq6nZJOu+l9qVFRwHZqcHLY8EQ=; b=juWDYnBOSVR+zp+f08SlQr9q0f
 R6zObR5SyLIrEg8USEVnSmYRbNp/NF0ArYfCTqq12FCBF1dTLZrthNwERLdg2DuTOfrqPf40ATAdC
 I4xF48/0or0i8JkTWrrGbdQU0ot/czHkQt7QtPp/zqwviwtsvg/hAK+kqZC4H3feEu/Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=O+1kudbJjsIZWx5ktJq6nZJOu+l9qVFRwHZqcHLY8EQ=; b=W
 YFGBfpf4lM+XuTrhhHiGMNurM3nv7BMKj4TgA5/lCXghXzCJpy3RWfltxauV+d3h+7B5EVV7xibTj
 06hob12QeXJyUjVihIkHYeMhcB1X616aQw0S6XvBXIuBfUiozyRBpuDi8ZjLK/ZPl7rEbncnubpY4
 jRYNPeQ1hDyYUvZM=;
Received: from mail-pl1-f176.google.com ([209.85.214.176])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wKFJI-0001XG-Nq for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 May 2026 12:55:40 +0000
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2b788a98557so42883705ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 05 May 2026 05:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777985726; x=1778590526; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O+1kudbJjsIZWx5ktJq6nZJOu+l9qVFRwHZqcHLY8EQ=;
 b=INQBUl4j7m2ze3diOKqb9egBImN2hFf6pAWzZI2dinDjKU+FuHJtCVHG1U6ZEP1LM9
 i9UfBGxK1CP7ppiFjuis8anqhG0fMRWDFVjslCxlEhxdoA6/ngW9mXvPBKb85YfLLK/v
 kUOHTScMmqFkP/46s3Q7c8iS0+PlvYMyZJ6dMFwizvo2DoUFsbYNcrltwfeVcC3mnLKJ
 oBGMOKSmt3nDiG42j7f8OR0JLQN1YntZx7LgasdF18yvPujN2ZXqpKCE/S4l8J3nHCLj
 TbnXPBMTgZjL6OOXDVQnfsjzS5QcF1FGh0owqFZQNNig++aAP2m5dBoFsunZSftQ6OaB
 kNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777985726; x=1778590526;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+1kudbJjsIZWx5ktJq6nZJOu+l9qVFRwHZqcHLY8EQ=;
 b=XX365JlM7EC5F9yxwLj8Sl6LfZeIgZAmA9Hv+miJkWV4omYoVwHUnkHypyDocrvpv4
 xDdDRLxbYv/469Xa7uNqNv7EYfteiAosCPawNc5gNywguIlYdczlDpBr2WkXhzw2aQAr
 Bq2z+QAYzpIa4Ah7hSh79Bak6bYTta+M8FqvnNAwaUNETYthCUGfK9Vy6+e3Jy7NTo4C
 93lY2r33qJqJ0Bl4QpCVGTLOOfJYrCa8RtqC0qIVv8qSU0tzuS3cR8FKL0ciso25h39t
 INndJTszvYhePdGPi7bjSjkjlRGDbT58eMJ5V8nUG3aFJrNVpTnklH7uadCz+2YIkFoE
 K46g==
X-Gm-Message-State: AOJu0YyvHcNuB8vJosrtn5n4iA9BKg2pmDL9AhTghCfAwaDVTnHjWUBH
 XvxLXkkPsUtzkOv0GP/7g1Tv9fRKJMUPrLShXoeyWO/ElnCbpd6Qs0Wr
X-Gm-Gg: AeBDiesqdM25H5oNXadnz5JR/83tC85UMz5UlXOzv8eEaGuAY1pCyGNKrNUmnAnDDIx
 /zUSNeQl6XrsqNOfKSyyzclBc06yI70l2ciIPCvNmOIMTPk1uqfwBg1LOsdNXDtQbRgcTaXk8fq
 jf6QRlQ4qaV4UpQldKL9678/FEC29dJ2Ju1JOrHqXKw+UOtGZNy5CIM1ghMSyB1VwYOB8qnvPZI
 UxtYg0eyeKE2TTxCNCkb4HG3hNl3LRtpRoDhjANA3jV6A+UFEiJ3BPPaAkqOKrQHgbwyua/vXdE
 u+iUQmpgSo7AyCc3AIFIWvWDHmISuDiCm4RgZ3pOZeDcBKTvgtXLzZ+CQwZZmUcXbzNftgHJhNJ
 IcwTx5/doCXfjeRFadl4bkhZF5Q9Yo3ixdUCjljvK//ILYJuav9Y0DpxapfkNPXfCfG/E/eG2Gi
 gnh44xuBulcs93C2ebb5kdK7Q1VYpC
X-Received: by 2002:a17:903:1ab0:b0:2ba:1202:4fa8 with SMTP id
 d9443c01a7336-2ba1202518emr95899755ad.20.1777985725288; 
 Tue, 05 May 2026 05:55:25 -0700 (PDT)
Received: from localhost ([111.228.63.84]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caad2bd7sm158423855ad.36.2026.05.05.05.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 05:55:24 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue,  5 May 2026 20:55:10 +0800
Message-Id: <20260505125510.1369132-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Headers-End: 1wKFJI-0001XG-Nq
Subject: [f2fs-dev] [PATCH] f2fs: annotate lockless NAT counter reads
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
Cc: baijiaju1990@gmail.com, Cen Zhang <zzzccc427@gmail.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

nat_cnt[] is updated while callers hold nat_tree_lock, but F2FS samples
the counters locklessly in f2fs_available_free_memory(),
excess_dirty_nats(), and excess_cached_nats(). Those helpers only steer
cache reclaim and background sync heuristics; they do not control NAT
entry lifetime or checkpoint correctness.

Document the intent with data_race(READ_ONCE()) and a short comment
instead of adding locking to the balance path.

Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 fs/f2fs/node.c | 6 +++++-
 fs/f2fs/node.h | 8 ++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 74992fd9c9b6..8318c747600d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -72,7 +72,11 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 				sizeof(struct free_nid)) >> PAGE_SHIFT;
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 2);
 	} else if (type == NAT_ENTRIES) {
-		mem_size = (nm_i->nat_cnt[TOTAL_NAT] *
+		/*
+		 * nat_cnt[] is heuristic accounting. Sample it locklessly here
+		 * to avoid taking nat_tree_lock in the balance path.
+		 */
+		mem_size = (data_race(READ_ONCE(nm_i->nat_cnt[TOTAL_NAT])) *
 				sizeof(struct nat_entry)) >> PAGE_SHIFT;
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 2);
 		if (excess_cached_nats(sbi))
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 824ac9f0e6e4..c1aa41b31d66 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -129,13 +129,17 @@ static inline void raw_nat_from_node_info(struct f2fs_nat_entry *raw_ne,
 
 static inline bool excess_dirty_nats(struct f2fs_sb_info *sbi)
 {
-	return NM_I(sbi)->nat_cnt[DIRTY_NAT] >= NM_I(sbi)->max_nid *
+	/* nat_cnt[] is heuristic accounting sampled locklessly here. */
+	return data_race(READ_ONCE(NM_I(sbi)->nat_cnt[DIRTY_NAT])) >=
+					NM_I(sbi)->max_nid *
 					NM_I(sbi)->dirty_nats_ratio / 100;
 }
 
 static inline bool excess_cached_nats(struct f2fs_sb_info *sbi)
 {
-	return NM_I(sbi)->nat_cnt[TOTAL_NAT] >= DEF_NAT_CACHE_THRESHOLD;
+	/* nat_cnt[] is heuristic accounting sampled locklessly here. */
+	return data_race(READ_ONCE(NM_I(sbi)->nat_cnt[TOTAL_NAT])) >=
+					DEF_NAT_CACHE_THRESHOLD;
 }
 
 enum mem_type {
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
