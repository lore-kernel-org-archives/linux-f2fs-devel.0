Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88C7C5B543
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Jun 2025 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wxv6RAEZJ+OwoMDsIRSqiD0uzZKe45A18GLn7nsagJM=; b=EgTbVqcHbLvRi1e6DzB0yiHvuD
	frewTIO6znO22u7SpV1Sh3uksHRRH1ck0AH9HeUM+3l7ea2d3rzAET7QwAJdWTtnGLdY8Sql3X6c5
	H7bcTXmBH80RBU5z5id+FnxdpuFeko5BcWSw/Dsxv67Cemi5qMcOwMzS6+Qq3RUlLl+A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uP0c4-0005f9-8E;
	Tue, 10 Jun 2025 15:10:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <shengyong2021@gmail.com>) id 1uP0c2-0005f1-IQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Jun 2025 15:10:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LwK5iQBMTeY/Xz9AFwJju3xpXe3hteMt3ODoz0TfBaM=; b=bgirFdmZrLN5Oe7o5vKyeqEGD3
 iOD75RhYDDAXuqPynhDZCE3dxqVwfvwj6s36s93UkgkbHKYsujihgSHCuaCvmbKAfUJEGjl4JvFkj
 /jNoz70xJPA4ftaDEVM4Lz0BkNMnwaiKMtlqh3Gvqrv7dZfgyHGIVUuIc8kbBRc8kh+Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LwK5iQBMTeY/Xz9AFwJju3xpXe3hteMt3ODoz0TfBaM=; b=hK8Xw8ZXRvsknsIzTjO7S7zsgI
 e85TbR6k97tdxEO6u9v74pixjiOdVa/Z12wKBJkwL4CCO92gF0HoNQvH/M0ub62MTyQB+WXu4o8y+
 1zNjp89JA2ORDWLSrFRw0n709fM/9xZL64MbTKP/H2J1JI8RuYJ79lR1CaY4+Wu3tvNs=;
Received: from mail-yw1-f171.google.com ([209.85.128.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1uP0c2-0002ZM-7g for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Jun 2025 15:10:06 +0000
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-70e23e9aeefso41042437b3.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 10 Jun 2025 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749568195; x=1750172995; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LwK5iQBMTeY/Xz9AFwJju3xpXe3hteMt3ODoz0TfBaM=;
 b=igfQxDVgQb2eEbR/l4dN0ifyf2CHLQhz2QuuPndyhMldoFjaIsU1lBS0JL3v/yBLmI
 lPZNp4Fb0vU+ruV1ksC7bXCmJEU7IXBRcDJtxOHjazOLRCsYIG8neWsgPDXDe4DQAweX
 b+WqOcQYy3vyxBNbrXyqKC0m8/m9GleA36ZAE5ghM+6fwa9fremRXxUq9uJk4gHrNqHc
 h68rav/pnJUGakWi688wJ7G7KvrpUAaCbVvT107ic/OstMEafDuOtUqGtYTB7l0+KRov
 2feCbSEkvEJRR4CniPqyVN+0eyyMzUFpsntQz9Wrmsm2IjzTPuhieqanzOXzBfRk1afk
 0iXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749568195; x=1750172995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LwK5iQBMTeY/Xz9AFwJju3xpXe3hteMt3ODoz0TfBaM=;
 b=T6vMtLRvrL9MeNN8Q7QoO2H7ceOYJFVYzHYPomZ5JRYYO9w3ivttU2lCzT4AgO8yO8
 p4z0NzGAGOeqE8oj5tjyz+ZZRwzDZWBgncWpbVhf7QjSAjEOAwJqhpUglfN3WgKaK+wm
 +Oq0t9wnPhS8wSK81QvMptbybZv+m4t7wE9k+XBj0S3TgaBEVJ30CiVXUHclZb1+6l8P
 34U7g76pljXtSnfwTIEBOAnh1WyuR/OcPYe6jLcL8cHC0dZdzYcGE7VbIsZk5iW2ZvWy
 LxzFOJ6jnvYG0IIGELXsJl2fQxubUewyagggAyd0v6PKB7DfiixSKeTWEIkYMpB668JM
 eFfw==
X-Gm-Message-State: AOJu0YyGblhSyZRcT5rbF66yWSuO5WpmJN1U0mRSZUHDHVOgun/MD/UW
 XlHM2P8dKHyMrEbq3p5UiTwUt3NiSz88ymSIrLeMMqpZcnr5kNg+HBLCf8DJrg==
X-Gm-Gg: ASbGnct3gGqPqLof87uM+NK4byevZFgfQlZmLTHbLLGllD04Z5CSmeRNsQXLJ8CAy6S
 V7bTqpqa2sGoTrHwgzdjikzrxyjuMron53XWLAfUY429noWSceB85EukuRqOVL30uT7fS5xbqM8
 7sBGy/11+MuzXZb1m3cmN2wgWPqmQnz2GSvaHXtANpT5qljmPr8BjR7pXHdNfc8KpPq+/hLYyOB
 hu0XYlbWcxwgUm1sEwGZKxRUoaLQd8Lr9Qp58Xz/ZmVrx/HCPKFVzrY1yYl795w0SXDEniTPlAn
 SRljWWBBnzQhY1Nyw0llQjdtIOly0EG6Fcj/Poqmdl66DypC8T342YUQkp+D+wAkph1W
X-Google-Smtp-Source: AGHT+IG66BRsZSRq1hKt8DeywND9iVW6tJoltODvHmcv0ylCzbD9cdoxaj38EfM2HNZ/KXSknVWtug==
X-Received: by 2002:a05:6a00:4fc5:b0:740:9a4b:fb2a with SMTP id
 d2e1a72fcca58-74827f39e8fmr25529284b3a.20.1749559083893; 
 Tue, 10 Jun 2025 05:38:03 -0700 (PDT)
Received: from PC.mioffice.cn ([43.224.245.249])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0847aesm7539815b3a.105.2025.06.10.05.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 05:38:03 -0700 (PDT)
From: Sheng Yong <shengyong2021@gmail.com>
X-Google-Original-From: Sheng Yong <shengyong1@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue, 10 Jun 2025 20:37:11 +0800
Message-ID: <20250610123743.667183-2-shengyong1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610123743.667183-1-shengyong1@xiaomi.com>
References: <20250610123743.667183-1-shengyong1@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1uP0c2-0002ZM-7g
Subject: [f2fs-dev] [RFC PATCH v2 01/32] fsck.f2fs: do not finish/reset zone
 if dry-run is true
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
Cc: shengyong1@xiaomi.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Sheng Yong <shengyong1@xiaomi.com>

Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
---
 lib/libf2fs_zoned.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
index 6730bba0da82..92791a768807 100644
--- a/lib/libf2fs_zoned.c
+++ b/lib/libf2fs_zoned.c
@@ -429,7 +429,7 @@ int f2fs_reset_zone(int i, void *blkzone)
 	struct blk_zone_range range;
 	int ret;
 
-	if (!blk_zone_seq(blkz) || blk_zone_empty(blkz))
+	if (!blk_zone_seq(blkz) || blk_zone_empty(blkz) || c.dry_run)
 		return 0;
 
 	/* Non empty sequential zone: reset */
@@ -484,7 +484,7 @@ int f2fs_reset_zones(int j)
 		blkz = (struct blk_zone *)(rep + 1);
 		for (i = 0; i < rep->nr_zones && sector < total_sectors; i++) {
 			if (blk_zone_seq(blkz) &&
-			    !blk_zone_empty(blkz)) {
+			    !blk_zone_empty(blkz) && !c.dry_run) {
 				/* Non empty sequential zone: reset */
 				range.sector = blk_zone_sector(blkz);
 				range.nr_sectors = blk_zone_length(blkz);
@@ -513,7 +513,7 @@ int f2fs_finish_zone(int i, void *blkzone)
 	struct blk_zone_range range;
 	int ret;
 
-	if (!blk_zone_seq(blkz) || !blk_zone_open(blkz))
+	if (!blk_zone_seq(blkz) || !blk_zone_open(blkz) || c.dry_run)
 		return 0;
 
 	/* Non empty sequential zone: finish */
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
