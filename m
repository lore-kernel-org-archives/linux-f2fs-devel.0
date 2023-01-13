Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA3BC54EBE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Jan 2023 12:59:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pGJea-0007Zu-6r;
	Fri, 13 Jan 2023 12:59:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qxy65535@gmail.com>) id 1pGJeY-0007Zn-Pz
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Jan 2023 12:59:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=krjTcP+Olcn9DsdB5Mkg9+Rakj50UWZJ91qIIjSVYfo=; b=QkRdUSPaEQigaJE3GmOSwcAZR6
 D62nRUsjFhLrhO4oGOTnNjeGugPZJ8AD6V5LKMWomTSwhezhqhcqV2ybTlp1sfEzYwd7byDMRSFen
 a9ejdV6vPMqE+ezIPyIQe1lQn2Wjdr7fJICIc972aEs+Lks5RvPDoDK90J0Uo0Fix/Ns=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=krjTcP+Olcn9DsdB5Mkg9+Rakj50UWZJ91qIIjSVYfo=; b=i
 1Me8oN7EYjJ5q5+ftq9jLPfKxjw4lw8o4wm/Olci6iwrlZ/ICSvr1kFO1ufgakvJN16SfmAEhw91K
 yS49H/HrZahBtComqIm4155R1E5eC6pf7IkuZWELN3GIdlbVj2VhULX00LO7W64w4UYF5t6szxiQ0
 uDjQYzwQm46k4k+c=;
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pGJeX-00046I-EG for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Jan 2023 12:59:25 +0000
Received: by mail-pl1-f180.google.com with SMTP id y1so23373607plb.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 13 Jan 2023 04:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=krjTcP+Olcn9DsdB5Mkg9+Rakj50UWZJ91qIIjSVYfo=;
 b=VV85mTEQK8exgFDT+XzgtYq+QugP5JE+PB6JlYPa9LAViXHvUXXi9pkeXQoygkxM8q
 ydImAB4McSvmNf5y7RSPUkFL6vu6OEqJly0/OM6h/y1QV3QGmQbWriasYxiBl1GBiuOX
 8JX/IvhF+uw/tySM1pT4zK1+LaZvUPWUDH5VMY0gptUBESE4PbpKKaKqRkefhrkZspBk
 9YaI9FD/z+HVhhWMxqUReQSzJJtaYTfijWbe+xXuu2ssDbOQNsAofz9G1s20TuFvh6h9
 cuXBrZoWARdcTprcOWTzuwfdu4g6NnsYjhokDzuEPOoEa5506v4qYW7oA/levKXOTDyG
 r93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=krjTcP+Olcn9DsdB5Mkg9+Rakj50UWZJ91qIIjSVYfo=;
 b=EdInqF6oIS1T/9rWwd/wWw0RmyVjOwCoHPHirN8HN3Li/ssJ2fPPVJULBd1JsF9wqz
 2FXP6MLmzjPpyGp4s/TAwpAqTyEiRsRfT34C7himVNjN+gXTD1+h1h9ihim0k/KC/tMY
 1cm0aERQyUKAijwyiRZAnWK5s9SesYDjDeNqjCzrWWw/SvNWuLtLKmEBIduDnigZmzKm
 hjKdfmspruX52QbyJLQW4BvDZrzgLTH6iGZWjxrv5I/YDWYV5iGXTc5Uq42DTPPM+q7U
 ZNfSARA7CW8/adnxy1S5gU0tFiS4W6sEwNrR02SkmMB2HOxlpNF07/N3l7al/WwWriWp
 QSjg==
X-Gm-Message-State: AFqh2ko0CaHZiSojj2vX5tAaxK8vbX16yHZqAIRS+USeD9nKinGr1oPd
 Oz6L0kPR4ExQsETv2gpMxCw=
X-Google-Smtp-Source: AMrXdXvgn07KG5wMlDNEbDZr8oWO9g6pnJe6P4oA+ehqvt3qrwt1UvniqAt25BeVV0jBblXuVkbrEg==
X-Received: by 2002:a17:902:c948:b0:188:a6ea:279f with SMTP id
 i8-20020a170902c94800b00188a6ea279fmr109457559pla.12.1673614759801; 
 Fri, 13 Jan 2023 04:59:19 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.252])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a170903028300b001944bf0b57asm5453820plr.204.2023.01.13.04.59.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Jan 2023 04:59:19 -0800 (PST)
From: qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Fri, 13 Jan 2023 20:58:58 +0800
Message-Id: <20230113125859.15651-1-qixiaoyu1@xiaomi.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Headers-End: 1pGJeX-00046I-EG
Subject: [f2fs-dev] [PATCH 1/2] f2fs: fix wrong calculation of block age
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
Cc: xiongping1@xiaomi.com, qixiaoyu1 <qixiaoyu1@xiaomi.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Currently we wrongly calculate the new block age to
old * LAST_AGE_WEIGHT / 100.

Fix it to new * (100 - LAST_AGE_WEIGHT) / 100
                + old * LAST_AGE_WEIGHT / 100.

Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
---
 fs/f2fs/extent_cache.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 342af24b2f8c..93a1ab186517 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -874,11 +874,7 @@ void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
 static unsigned long long __calculate_block_age(unsigned long long new,
 						unsigned long long old)
 {
-	unsigned long long diff;
-
-	diff = (new >= old) ? new - (new - old) : new + (old - new);
-
-	return div_u64(diff * LAST_AGE_WEIGHT, 100);
+	return new - new / 100 * LAST_AGE_WEIGHT + old / 100 * LAST_AGE_WEIGHT;
 }
 
 /* This returns a new age and allocated blocks in ei */
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
