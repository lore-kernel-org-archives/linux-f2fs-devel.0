Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB8DCD98DA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 12 Jun 2026 11:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZxdfbA9Pwfu6Lkt3pIlCPdXL0KcA+95/kDIURm35CWA=; b=hwmO7oFsYDiZO6hf0fAzUfRzvc
	UqtQ1ODlsAmUn8n7JektHch4Ru7vb8lAwHXW/nNUbA2IYHkqoFnv+7AIBZykB2RyQSXDX42kIse68
	3bzgnKqB/Wef/vNF5s8mbN/t/7eAXqeuUxAxouUgMTyOe1tVGtdRB6fi0eIAjuh+BGqk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wY0Xg-00058a-Bp;
	Fri, 12 Jun 2026 11:59:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@gmail.com>) id 1wY0Xe-00058U-Qe
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 11:59:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e8zOa/msy1iwHr4fejWbXdA/75oF3Mi164Ym8AXdPCw=; b=iu2vkSdMxomwt6V3uDo2BQrs/v
 a71xt8HXASNLFgVnU9aiibVbQkkvOlipo0IQLkRkOGsqAe6QpjnFiPRqoemrCWi172lwX/6Ht33+t
 DEQNC098MslTduElG59HBIHxMrG4ceqsbxaxnzrfTXugLT2GSDn+9P0hyv5VdOQuC3V0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=e8zOa/msy1iwHr4fejWbXdA/75oF3Mi164Ym8AXdPCw=; b=TfbDB+CXLncXUSLW+Pd81Q6D6U
 lOFY5ZTx55+BacL5Y8tn061jNPTLiNrFnwMxdU0480ArgXA0OZuEYjqabxuzjVkXxmc8iX/UWiHg1
 Jt1DOrdzrEDlus804u1Z/GmP32kynOuE/HQywf1QqT0p06+C6u640gJ3pmENqYs2FfDY=;
Received: from mail-pf1-f171.google.com ([209.85.210.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wY0Xd-0001ke-Mq for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 11:59:19 +0000
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-842288702fbso453346b3a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 12 Jun 2026 04:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781265552; x=1781870352; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e8zOa/msy1iwHr4fejWbXdA/75oF3Mi164Ym8AXdPCw=;
 b=KcebVQCJiEpwd14bcycl2rDdXdHE4Umu4qCjzdcOcA1/VGx4Mfz0CRnh4QhIC0d5Pp
 Mb03N/mWF6oO42AEsiSCRl/QGFLadyyIOUrjhPySjMSAq0o9b2R5+uZnXucrteIxPcyT
 FcclDoV3PQNtbcIusgkHAm+IX9shC+jleLkQ7owIpNYAzSF7eX1YOi5Os2Pn+sF8/mPD
 VcKPrTWdXek6jK86AGw+uvIs2AoMi8WNEDEymdRbAzyGyXRhf7C0xhR3SY6tfCZQB6oV
 Tvody1rfj3xt6Fq0KJ9dgIYWgglpa34lPCJBf2Pv5+8g8rHyoW5AKZPokVbLNAM5cDQt
 Ieqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781265552; x=1781870352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e8zOa/msy1iwHr4fejWbXdA/75oF3Mi164Ym8AXdPCw=;
 b=cYJfRbxsDjy41s3RJ9l406f5yM7pbob/TVPpFzhjVaq+Q5BpPh5HXhBWbj3ahB4+kp
 q937DdHETSJTeCmV3Fh0CgOMx5eUhRysznfmGboQBbmQveQ+Cf6KJ+Wd+1teb2BOMMIw
 JPCoh+3JQlpleGKFc6yeBR+gMbnZTnLoQEnif9C6B0Y4qfHZISTOMYfM1U6brixiaNQ/
 HXQ1wb7ILrfMOJM6ljYKchD0xpGvgU2ID0IC4qbDuhaW4pAAjrud885PH0679bH7ZOPo
 LHIBuYzipWD1ys6ofSxumQv7Qbv5QXheMZi5sYAeMN2EmdO/rNGGrIbN8Dsh+2AJa1d5
 RUKA==
X-Gm-Message-State: AOJu0YyRn+79u89jjKWbBgdoEpcFI2KpvLFb93uFOS2RKcJXmE/V93Yi
 vm+//odmhBRqh3XtLi7hacT72+g02FtvcLjoWNlw445TvJZOMP6RgH9A
X-Gm-Gg: Acq92OGEJ4u+PxB0eZqVf+gEtlXf4h1vb3KikW71JA/LQk1c4mZsP+AObF1M8f+FDLK
 Bq6lU2WR6UbNsp6atRjKlYfcmprbBMXZ55aVHFHdBUzKXWJ2cu0+wa3F7BFHQGrlNGE2aY4oWrv
 oPpSUTWwfOaNhjnYt7XHkC+/NKoxe5Y3V9nAYj1XYG5H+sLP8/18QCf7hqV0quXjPf8YmqtycbS
 jRxQNr5SzVj6ItpjvPehZGtra42kNU49AL9pS2Vtvs7Z0PQZ0nLjN70JLQEGX3+OAATeQ/aKq1W
 2ClGRqhqPNoJ2H+yWNOkqQvIE/6/QIpIltUW/cjR8HgWqsT4zZOSPl8ICaAIPcGxJrbpi33hDGS
 pN5i2yUQEooeLLLLxvBAuBYyR5PTnRvXpMBMTtjudzT+KGW9Fo3XQQqVAL+IFtfqAbp2H2G7N8R
 SA+rIDUkomFJu74NQC/fPqLWbg2aZj9WcSyqDsoRG7vsDEBHbqC/HKg7U/U51SRA68e2aPVw==
X-Received: by 2002:a05:6a00:21cf:b0:843:4726:e3df with SMTP id
 d2e1a72fcca58-8434ce991c4mr2900869b3a.35.1781265552390; 
 Fri, 12 Jun 2026 04:59:12 -0700 (PDT)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434acf2ac9sm2131197b3a.21.2026.06.12.04.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 04:59:12 -0700 (PDT)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 12 Jun 2026 19:58:37 +0800
Message-ID: <20260612115839.2065903-3-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612115839.2065903-2-yangyongpeng.storage@gmail.com>
References: <20260612115839.2065903-2-yangyongpeng.storage@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1wY0Xd-0001ke-Mq
Subject: [f2fs-dev] [PATCH RESEND 2/5] f2fs: only initialize largest extent
 without extent_node at inode init
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

The largest extent takes effect during both read mapping and write
mapping lookups, while read mapping does not need to access the
extent_node. For write mapping, the case where the largest extent is
not in the extent tree can already be handled by the merge logic, and
cases that cannot be merged do not require the largest extent to
participate either.

Therefore, the largest extent does not need to initialize a
corresponding extent_node, reducing memory footprint.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/extent_cache.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index aa368a01b035..f8d94db60dc6 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -410,10 +410,8 @@ static void __drop_largest_extent(struct extent_tree *et,
 void f2fs_init_read_extent_tree(struct inode *inode, struct folio *ifolio)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_tree_info *eti = &sbi->extent_tree[EX_READ];
 	struct f2fs_extent *i_ext = &F2FS_INODE(ifolio)->i_ext;
 	struct extent_tree *et;
-	struct extent_node *en;
 	struct extent_info ei = {0};
 
 	if (!__may_extent_tree(inode, EX_READ)) {
@@ -435,21 +433,7 @@ void f2fs_init_read_extent_tree(struct inode *inode, struct folio *ifolio)
 	if (atomic_read(&et->node_cnt) || !ei.len)
 		goto skip;
 
-	if (IS_DEVICE_ALIASING(inode)) {
-		et->largest = ei;
-		goto skip;
-	}
-
-	en = __attach_extent_node(sbi, et, &ei, NULL,
-				&et->root.rb_root.rb_node, true);
-	if (en) {
-		et->largest = en->ei;
-		et->cached_en = en;
-
-		spin_lock(&eti->extent_lock);
-		list_add_tail(&en->list, &eti->extent_list);
-		spin_unlock(&eti->extent_lock);
-	}
+	et->largest = ei;
 skip:
 	/* Let's drop, if checkpoint got corrupted. */
 	if (f2fs_cp_error(sbi)) {
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
