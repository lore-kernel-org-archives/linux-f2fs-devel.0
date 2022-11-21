Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BBFC433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Nov 2022 11:44:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ox5EL-00055e-NN;
	Mon, 21 Nov 2022 11:44:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <3R197YwYKABY274z0D2AA270.yA8@flex--glider.bounces.google.com>)
 id 1ox5EJ-00055P-If for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Nov 2022 11:44:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V3ROk7430AgCjRwu8JCLeHALA6B0dvLhERaon//wlR0=; b=kU+r8iink81swE2yv5lOc+RlS0
 m3kSlFlybdYnIxQivqX7WIeopskfWz41gp5Zt1ZUV9lBdMxmE2+yV6RpfZkIs474ze7KlRI9MLvry
 MuHAfWLA6OQPAkmM6zPHJJ+jY0Z76eXHmyZZIKX+HgExMkGVB9f1NLUKtmhx3H24LfPM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=V3ROk7430AgCjRwu8JCLeHALA6B0dvLhERaon//wlR0=; b=OO5YVxyw+n4WRHejS2OM8RyXOt
 HDTGcASNq7b6Rn8rtDef8n/NaJhAnI0uPNUQXJW5AQGayaZd/DdjBzfMwGphoWYSvL+pVDfK5PbPp
 fU5eRpcGO1N81s+jOv7kqBcDxM1sKnBaZEROyX4ykz/2SGy02Wr4msh8u8hnXwLnt4RI=;
Received: from mail-wm1-f73.google.com ([209.85.128.73])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ox5EJ-0005re-0Z for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Nov 2022 11:44:51 +0000
Received: by mail-wm1-f73.google.com with SMTP id
 ay40-20020a05600c1e2800b003cf8aa16377so6373007wmb.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 21 Nov 2022 03:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=V3ROk7430AgCjRwu8JCLeHALA6B0dvLhERaon//wlR0=;
 b=VyCfbuWOem8BwV+1kbZt92/iURKerhApO5tHJL82Q3g8gJjhEf8Gf81lkNXinPV0WG
 33XKENJFJcX8AOPHW1fpifSRoqxXlHBwqxVqieU0qAQ3CQLak9yv9kSmC8Cd+mpuXWqA
 dMw4MYS/tqwBn9HATfin7JwAng24nM99T15wf8oiaR3VGtSchxTXvOchJ46VW/seRWPz
 sXs38pJvJqRP0PnnJsEFB9KY5UE+hWn5HdPDuNxMBW9IoYXeVIqpE2I6F0yMLJyOGUuI
 BmntwbMnaWN9YoJTyImpLCf9dUeBmBP1Zw2C7sgj5r2JExdS6DMuSGOCl6Jd1Ab+9sfj
 6cPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V3ROk7430AgCjRwu8JCLeHALA6B0dvLhERaon//wlR0=;
 b=dEAlqE/N09BRcv8dBz0SewayO0dYlnKB3pvWLzIzEwF+Go1bjTPPTnlKZJH2OGIs/b
 SHrIOMEqoj5ucxE4N2qyuovHq4cH1Nfz1su0lvQHxBsIAj8GQoYIA4t2jfxMdtsG2loM
 /iMKZi8aGzp+ximfA16q+Vhii1QK893mV0ZVQ9X4ZEZk2Y76Hby8lrtuYEeQ87UJcrfJ
 6F8lzmY7XLeysPC+K/S4Dp4hyFNbDsZBcORVWcfvfIKh+T3gsOQNraUsopUUjjWSpDXS
 0dpe2hEh8jTZOUy0i+X6ewypROfVAipCH77pH13NdQRCQzEULlj5g7x+pmLmaKczdhic
 7Cfg==
X-Gm-Message-State: ANoB5pk9+bujCMw2SJ1E1NW1pHFbPzS94ebByvFjNG3UJeGzcbU5pfWM
 M9CT9r15gaAPs+hH2la+ZWfsFZ3WiVo=
X-Google-Smtp-Source: AA0mqf4lwPSD6Y7DTAtXw3/2Z+F5J2o+aieN11Xy71eaA/djePFQf5kKRgdlXgAOixk8oilkdCgBRF7Z9oo=
X-Received: from glider.muc.corp.google.com
 ([2a00:79e0:9c:201:db68:962:2bf6:6c7])
 (user=glider job=sendgmr) by 2002:a5d:6706:0:b0:241:cf90:ab1e with SMTP id
 o6-20020a5d6706000000b00241cf90ab1emr1020206wru.685.1669029703858; Mon, 21
 Nov 2022 03:21:43 -0800 (PST)
Date: Mon, 21 Nov 2022 12:21:32 +0100
In-Reply-To: <20221121112134.407362-1-glider@google.com>
Mime-Version: 1.0
References: <20221121112134.407362-1-glider@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221121112134.407362-3-glider@google.com>
To: glider@google.com
X-Headers-End: 1ox5EJ-0005re-0Z
Subject: [f2fs-dev] [PATCH 3/5] fs: f2fs: initialize fsdata in
 pagecache_write()
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
From: Alexander Potapenko via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Alexander Potapenko <glider@google.com>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 akpm@linux-foundation.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When aops->write_begin() does not initialize fsdata, KMSAN may report
an error passing the latter to aops->write_end().

Fix this by unconditionally initializing fsdata.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Fixes: 95ae251fe828 ("f2fs: add fs-verity support")
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 fs/f2fs/verity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index c352fff88a5e6..3f4f3295f1c66 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -81,7 +81,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 		size_t n = min_t(size_t, count,
 				 PAGE_SIZE - offset_in_page(pos));
 		struct page *page;
-		void *fsdata;
+		void *fsdata = NULL;
 		int res;
 
 		res = aops->write_begin(NULL, mapping, pos, n, &page, &fsdata);
-- 
2.38.1.584.g0f3c55d4c2-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
