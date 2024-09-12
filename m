Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C1FEED621
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Sep 2024 17:00:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sonAw-0005ee-Id;
	Thu, 12 Sep 2024 17:00:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1sonAv-0005eX-HE
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Sep 2024 17:00:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NIVKZWUip3GLsx70oKEFoxX4dCo2eU2HKBSzLiNYHak=; b=R1d6r0fppw/NcPu/YlQDHESjF6
 yCXvGc+GnstVFQYucnSlsgSIoAjbxA+10ciR07ltylhFL+cr2OqfzHe0E/nY7N6r3/gE+p4lW+Q/j
 RxvPN0DPKNAjOH1CdB49dmw9wjTINxJIzHb1BIb7uLwjsOq0f+QJvT5EvkwnmchgznOw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NIVKZWUip3GLsx70oKEFoxX4dCo2eU2HKBSzLiNYHak=; b=f
 anpzBPFs5gxhKLEgop3Nw9hN4YXYpDuZ2cHHeDYYHbAql+3ljPWHyeir4qb3lPYW1H5Z34/gM3t09
 S356B43rg8Mdd88B3cWbMk39RbmBJ9VU3CQd8kUrPbITlGyo67TqpRZQaP0j6LGTBBLJiuQbmjYxv
 CJllQfrw/l1FOq6M=;
Received: from mail-pl1-f182.google.com ([209.85.214.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1sonAv-0002Zv-JT for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Sep 2024 17:00:10 +0000
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2053525bd90so34115ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Sep 2024 10:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726160404; x=1726765204; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NIVKZWUip3GLsx70oKEFoxX4dCo2eU2HKBSzLiNYHak=;
 b=AJCIbXTIQbsbHZdFQilksewkafwCR13CmytuiViabKgQXD/XW3AqKqmt0dL1uDyU9r
 BGe8wO9M5syaR40wL8a/l/AWjCcRvXAaGF/D+CWgJELWrZKNhQuwBYLMUV8jtXyB+tWC
 kenS+mykZl6+e13WaY3pvH0YY6FNC05KR6IvNMcOqE/4w5JYZHpH55CpoHGexWHBaQze
 KDfp/EjFvZwQt9Eu+kWEg51iJpugLOOHVzmvQSnwdTR+CtuMq0D3XX0r1+vfa94SoDI7
 e1GL+cUtkobDYB5ZF4KkbifzvHpNclOg8+I355+iuUXP0Cwuh7XW9McrBxJTo7fBIAey
 TFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726160404; x=1726765204;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NIVKZWUip3GLsx70oKEFoxX4dCo2eU2HKBSzLiNYHak=;
 b=KPKh8FsM6ctl5PhjG6Q6uN/eDFqQstM2NxZMjroMI3Ey5fg2G/UFhfO3kq4afNXGmT
 ovIDEMp7e9wbXW25B7/6gmJfu8xhGbD3vTdyCSRo22ng1LobVB3EgOvKDGxegP9Iy/zV
 YbGGDOHlLR95KRgGptbjnCRV/4WbelGPuisXNGJ26q9fZUmuMpSzXvXTm28Jg4SMGKg7
 wYIhar6Yyji3xdhH2HlL3ym0/GBZwD/J3E/MM3RaoVAi4wuONw/jae2RGx+mLk4JiGty
 /eUokxg4pqi/AEmEGOj+EDtSYuKZE/bosfQTWKJjM8BPTQ/ZmCDTZAdMnmQhe9rtkXtw
 c8Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeXi4/vZM5w2rDaJTcKmdhJa5FqV/tvIL3/WWuYGkks3Tf0SNXBfx2cS0PVIKkZgRWdXgnk8Wy2l3QbZH9QatN@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yxvl81R0y98FvK7adehkQZQGMzRRPndMYHKWzICrauDskAyZ5W+
 VyIERQ8plWM+la4pSwn7poXGwf5iQyLWTmiqS1uOh/MmGlOzJ9C/
X-Google-Smtp-Source: AGHT+IE02vl34aJqOrFB6OC4nqdE9Xan48RKJeN7El4vbOPifqBDLjurvNnyBh3MHNswUt5tytY8sw==
X-Received: by 2002:a17:903:41d1:b0:206:d6ac:854f with SMTP id
 d9443c01a7336-2076e3157aemr52560915ad.3.1726160403556; 
 Thu, 12 Sep 2024 10:00:03 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e14:7:a5d8:3c37:f48b:3b20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076b01a093sm16309775ad.276.2024.09.12.10.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 10:00:03 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu, 12 Sep 2024 09:59:58 -0700
Message-ID: <20240912165958.386947-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
MIME-Version: 1.0
X-Headers-End: 1sonAv-0002Zv-JT
Subject: [f2fs-dev] [PATCH v2] f2fs: forcibly migrate to secure space for
 zoned device file pinning
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

We need to migrate data blocks even though it is full to secure space
for zoned device file pinning.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
---
v2: change to fit on a new prototype of do_garbage_collect
---
 fs/f2fs/gc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d3e3104c4492..baa98c3bd667 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2070,8 +2070,7 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 		};
 
-		do_garbage_collect(sbi, segno, &gc_list, FG_GC,
-						dry_run_sections == 0, false);
+		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, false);
 		put_gc_inode(&gc_list);
 
 		if (!dry_run && get_valid_blocks(sbi, segno, true))
-- 
2.46.0.662.g92d0881bb0-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
