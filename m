Return-Path: <SRS0=2AeP=6K=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99525C54FCB
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 26 Apr 2020 22:55:46 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44763206DD
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 26 Apr 2020 22:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="nQCt7w/U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="UDuS5Yf7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="PQHhUt4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44763206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jSqBc-0006K4-UK; Sun, 26 Apr 2020 22:55:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <guoqing.jiang@cloud.ionos.com>) id 1jSqBb-0006Jt-NQ
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 26 Apr 2020 22:55:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EVShq73FSgP/iPd7sAu/gmu6WN22oBRzfyOsdhWlH7E=; b=nQCt7w/Ub6T2XrU5y3AS2ZIG3T
 Vg2eRMn2QI3hU5bzsGdfus4gcY4Ft6CDUV0ShHkyx99N3Vk/M0fhRbDAl8f9vuMemFtg7qlrSbnYy
 e8Cyu/59sbVtz2vhzIYZOLNtu7yxiJjizx83qAtr9tDgTMuJWd7o9huHXDfLfjXUTktY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EVShq73FSgP/iPd7sAu/gmu6WN22oBRzfyOsdhWlH7E=; b=UDuS5Yf7uVJhBBFnfg2WoG32Fg
 LXRxlRjjaAcq+1qjl2YLYSaPTkNh1BvqXH3Ej2NCY2i/uHdk0W5SVnFeVrBh7M28ReEl10g09+Rmu
 Vp8bbN/tSmBtINerpnBNKjXoHUtYTnYQQeHfqdkvXIe5Op7snVlfPBP9sCawdQyoDCWs=;
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jSqBa-00FmPe-3i
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 26 Apr 2020 22:55:43 +0000
Received: by mail-wr1-f65.google.com with SMTP id t14so18351301wrw.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 26 Apr 2020 15:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=EVShq73FSgP/iPd7sAu/gmu6WN22oBRzfyOsdhWlH7E=;
 b=PQHhUt4QYQ2lcD4jntv56PBlw8VdGuIt0HSBR79UTYajgyZK0++h/tPZu2kqq35XIu
 VQv5xha59bI/qnB/aXKoYi6BjZIINrM77x90Cgp6DjnmaHXEsm8ljA77zdoEMfWSD+fI
 3f4bUgA12mwtiRNTtGM3Q13n5EcbuVHKwT8C2ih3iEjeaa9/d4NW/1V0gsbc1ikhBIDI
 /1LZ5Vzn6deZu3/DnXr2bR20wJJjvM+5C9qPDftdJdgSrwBaTLd+3F3ISpapRW24rpKR
 y2Lt4zcbxvN74rzniBO05POHASY5jnQlgLyAqNPyp9MtgdgEeV9UXduqimBOYxBDV6BO
 cn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=EVShq73FSgP/iPd7sAu/gmu6WN22oBRzfyOsdhWlH7E=;
 b=B1RrhDDoX0ESe6MxM3qHY7tNDrTmyc0srOhXxnfFrJ8EliSFkWdNN3SexZDjPBt4rc
 paTfEsuIyWs9BK1+oGLgJcTjPS/QHWtpo+Zu9GOFWZXsCcOtmEyRh/gV8iBJq9BKegjX
 kM1lj2uS7XR4qGZsDzv4c20/cFeWkeSaVjj5Lo0tmlwEdt7rSQYCD7duY0sMGUoX6Tbs
 8TSY5scIOHezNPAe6lz2fepnCAHO/BV/l6V5aT0QBisBRYyV9jnjUFewMosU7JFV2aFi
 54oljUkrO1EyjQ4ciOlcOVHh/3/8o+csql0BNZkMD4FzXtBW6xOpD9Ol+R3zwgKuRx7D
 VFcA==
X-Gm-Message-State: AGi0Pub7+wLXYWMCAkNeBT+MmdJESoayv8Vkv5zIJWqMexGfklkJnYAi
 WNtJKHyZcADbS6L2cqyJSx6HQGmSevryyrkU
X-Google-Smtp-Source: APiQypIEBGSwt/5p1EI0EPh1JLjp11svK9dHJaYN2weAh6ctv9R1LUU52PMHSz/H21K9Jnelbw7huw==
X-Received: by 2002:a17:906:7e5a:: with SMTP id
 z26mr17585240ejr.168.1587937791521; 
 Sun, 26 Apr 2020 14:49:51 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:fab1:56ff:feab:56b1])
 by smtp.gmail.com with ESMTPSA id ce18sm2270108ejb.61.2020.04.26.14.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2020 14:49:50 -0700 (PDT)
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Sun, 26 Apr 2020 23:49:21 +0200
Message-Id: <20200426214925.10970-6-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
X-Headers-End: 1jSqBa-00FmPe-3i
Subject: [f2fs-dev] [RFC PATCH 5/9] f2fs: use set/clear_fs_page_private
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
Cc: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, david@fromorbit.com,
 willy@infradead.org, linux-f2fs-devel@lists.sourceforge.net, hch@infradead.org,
 Jaegeuk Kim <jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Since the new pair function is introduced, we can call them to clean the
code in f2fs.h.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 fs/f2fs/f2fs.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ba470d5687fe..70ad8c51e0fc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3051,19 +3051,12 @@ static inline void f2fs_set_page_private(struct page *page,
 	if (PagePrivate(page))
 		return;
 
-	get_page(page);
-	SetPagePrivate(page);
-	set_page_private(page, data);
+	set_fs_page_private(page, (void *)data);
 }
 
 static inline void f2fs_clear_page_private(struct page *page)
 {
-	if (!PagePrivate(page))
-		return;
-
-	set_page_private(page, 0);
-	ClearPagePrivate(page);
-	f2fs_put_page(page, 0);
+	clear_fs_page_private(page);
 }
 
 /*
-- 
2.17.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
