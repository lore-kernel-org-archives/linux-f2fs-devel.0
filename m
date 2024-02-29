Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB71C54798
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Feb 2024 09:15:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rfcVJ-0007qy-9g;
	Thu, 29 Feb 2024 09:15:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <colin.i.king@gmail.com>) id 1rfcVI-0007qW-Fn
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Feb 2024 09:15:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BzPR/m2RFv6uhgD4TF2TCBedYS7ZWfD3SFjKIsmd5XQ=; b=k20C76wk9E4HJVh4Ib+9gRS+lf
 HY5AYuHyNX9eEeuQqqdESO8Hn6hJOnUVbU5yoPozEqgtgWW7tFnLnG8+kzIHYgGb28CXZyW71F1bO
 ZYZq/BsP53wCGd9SXyh4O0TaA1wNedkGUYSGvSvGwbtLYBIAYptwGdfp+GwFJh0HlANs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BzPR/m2RFv6uhgD4TF2TCBedYS7ZWfD3SFjKIsmd5XQ=; b=B
 KYTHOO1irRA5WtDJJuwbFybXlqpY7YYaGLxpBu3ReSnZfzohFmHe80ybm3lvDMlscmi99n26YeYYC
 O769D7rXuH2AEMpydaUl4uHJONONwk2NULj3BYSWl2oLhbw0w8cayWqFT/6f/lbkT6kLQZWH7veYy
 CvBiCYJSBy8V4FCI=;
Received: from mail-lf1-f52.google.com ([209.85.167.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rfcVG-0005wr-51 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Feb 2024 09:15:01 +0000
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5132b1e66ddso71783e87.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 29 Feb 2024 01:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709198091; x=1709802891; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BzPR/m2RFv6uhgD4TF2TCBedYS7ZWfD3SFjKIsmd5XQ=;
 b=O0eIzGz5nmE38PMXltHmklHmb3rMbEaRN4P/ElY4/YnYSm0tshVNA81xNhTOHJ5i09
 AvLuCayDOaPSPQLjWkGdjtindObGG0z58xSy32Uu2zMbqt9PfUJjo0dNBiWdZYSTlAel
 C70xNSiBBGBkADSHhAqzxtBMBBcufebPoIMsRnul8tTui5iE8hRX4mFrpaDrZsMV7oCS
 hsmYXfIxXsycFM/A753hs0XmVqkHFTrxOlbg0KwxveDlAETqHaWkYiYVgm3NKl3N5nK5
 ZRYPhGMXcLHs9EQj4rel6oxDcIuR3wWi+dafHq6Kk2kLJgCBvkyNhlz3b992c5ubk+xA
 jp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709198091; x=1709802891;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BzPR/m2RFv6uhgD4TF2TCBedYS7ZWfD3SFjKIsmd5XQ=;
 b=SYLaa33pfA9nyMSfOLNl2citRaXUUfxk2SVvG0lrX9bZbSaViD3ZX7alzn/tY8qYCJ
 adu200cPaggIGTq7e5nUcfu+usYch/9VH1fzANk/5pr/ge6HCASWz/tgkMPc0xAN8JGH
 UwTGnm4e4k3FcVEoiNU/dcx8CzrWhrZn4EftQmBDBcvTWqeuF/wR3RQLnYDqwyFdHvze
 MA5Jyh7o6vHtQtBsfDObZ/DCU5vnk3BSlVFMbrkqgjeymIFTSexMez7+Walg+jKTnDNe
 QStbtRNxwjnDZccJ9zTgOOrJvgfk6LG8v3qqg1QNWNihIf4a9eZrQrAoW2ldVhzL61jx
 snRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt/K78zmzYLXNBYwF/NY17fmEocmPTF4cei7k3HUT1vUG12VtR4UNkYO+tl4gNZpo2iajLP41UT4SX7DprkGOCvJlMS0k3ZSyU4GoKT5WyfFjkhkcBkA==
X-Gm-Message-State: AOJu0YweOy08Tn04cjL3nzsdWq+mwGKmbkwhoEDiUFNUTiyKjcZ5GL78
 Wx//OywHnHCOtR9YGMrv5aQ22DXp0jm1cWdwcEL/agHX9I2aS3uX
X-Google-Smtp-Source: AGHT+IHww30pD/DmIG+i8xRd/dPP7OIbG5+LBh5J2pDzBeUzdf597VyaV4CRLyS6vRbwRGNWKL5UFw==
X-Received: by 2002:ac2:4951:0:b0:513:1829:57f with SMTP id
 o17-20020ac24951000000b005131829057fmr1048326lfi.5.1709198091210; 
 Thu, 29 Feb 2024 01:14:51 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net.
 [80.193.200.194]) by smtp.gmail.com with ESMTPSA id
 jz6-20020a05600c580600b00412b843cd2esm914807wmb.0.2024.02.29.01.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 01:14:50 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 29 Feb 2024 09:14:49 +0000
Message-Id: <20240229091449.105032-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Headers-End: 1rfcVG-0005wr-51
Subject: [f2fs-dev] [PATCH][next] f2fs: Fix two spelling mistakes in
 f2fs_zone_status array
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The array f2fs_zone_status contains two spelling mistakes in
literal strings. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/f2fs/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index bdb27e4a604b..072c4355d3d3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4921,8 +4921,8 @@ static int sanity_check_curseg(struct f2fs_sb_info *sbi)
 const char *f2fs_zone_status[BLK_ZONE_COND_OFFLINE + 1] = {
 	[BLK_ZONE_COND_NOT_WP]		= "NOT_WP",
 	[BLK_ZONE_COND_EMPTY]		= "EMPTY",
-	[BLK_ZONE_COND_IMP_OPEN]	= "IMPLICITE_OPEN",
-	[BLK_ZONE_COND_EXP_OPEN]	= "EXPLICITE_OPEN",
+	[BLK_ZONE_COND_IMP_OPEN]	= "IMPLICIT_OPEN",
+	[BLK_ZONE_COND_EXP_OPEN]	= "EXPLICIT_OPEN",
 	[BLK_ZONE_COND_CLOSED]		= "CLOSED",
 	[BLK_ZONE_COND_READONLY]	= "READONLY",
 	[BLK_ZONE_COND_FULL]		= "FULL",
-- 
2.39.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
