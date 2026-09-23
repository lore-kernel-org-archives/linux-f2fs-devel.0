Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2B4C982FA
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Sep 2026 02:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TfT4O00jGBpPLK59kqt5CSN2etQGd4Ml6VyAqa6HwTg=; b=fWweSvVg4PFiry+xTrAbhPIWBm
	YONmIguln9nW4XuN2IbnAGcJ89+IXEXKBHzLQgpJ8omfrdMDGKgIinG5IekmwnJam4s7iALknnJIz
	Vpt0Pn6y1jzwsRsHe8eePrRE9ot79Thq8WCDMKiKQlNJVHvScDvAlZH/eEZK/kAv1eoI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9Cj3-0005DM-8a;
	Wed, 23 Sep 2026 02:28:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhanxusheng1024@gmail.com>) id 1x9Cj2-0005DG-OA
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 02:28:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qnx3X924G9QmmHUvigsztGCTM2BJ9g+wVGTPwCOEhSE=; b=MxJr/zr+R9cNNXIKHDyB298b+X
 t/nqQsRGaG4VPVImILwwLUOQebcn2T7PSTV5BkerLF+xkkMQsV/c6rOHKiAWj4DVNV/H8K6/13ZUZ
 +32Prea0x9Er34j3Rz42CUHIGkaq5gqwmp73hn+1nWfFXNanpWlWrU77ABkCI75pUv/8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Qnx3X924G9QmmHUvigsztGCTM2BJ9g+wVGTPwCOEhSE=; b=KzoEKiOAx0m4TawG/7WJadn12J
 U7le/S7MiwJuwZdJ0IZ3jupuOqNwnn8X5U3eAEy5x9sXl3JKOzOLEJJ9f96h3ceJBhM5MS5uxwaNK
 6lwULMSLwLlq5M5migcCTgJnq2SgCIX6ynpF5UYoYin83vtLk2PnHszJlLKFk/+GMWdw=;
Received: from mail-pj2-f12.google.com ([74.125.227.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9Ciz-000129-Mx for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 02:28:46 +0000
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d91c22d27dso1664115ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 19:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790130520; x=1790735320; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qnx3X924G9QmmHUvigsztGCTM2BJ9g+wVGTPwCOEhSE=;
 b=BT+qinkUilxl6zXu6m43GaKa0T7DyJDfJUDOI4elPWMmOTdhnRWCuFnR/aMTKqia4V
 V50w4xkMaMoh6sdCuSiueUwsh9qE7aKxKiw8rpk2MSLsJkBrAIYD/P/85aEiNWSV6tQA
 J7BUvIVx5g1gu67AZKX2szDfGIWNzHefvIsW3CYwkqRMYOG51eQwz1RzM8r1+Xp8+KU7
 nUkYJIyP9N3q0FFe7hbNClPgw1faDLcho2dMUUTQBKxBuS4+p9ZdJxkH1ZmuaMoMIbTZ
 AF6E1930NbUTpRxDjX9RaQybflKHB3TCdWnIH/2vXvSelBfgXhdD+E5OesmYD25pLh5T
 j5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790130520; x=1790735320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qnx3X924G9QmmHUvigsztGCTM2BJ9g+wVGTPwCOEhSE=;
 b=vihVKdFDS2FhWb+B7nul4eMz8mGC5UvA4IqZuvXPCa7xfK1O5OJ63GO/szN93Ha7Hq
 HH3YwL9rwYNnloFgnrAKDLnvF9INZBByFlbZcEu5qMXfsR4VC/pOEAs19sAOnxYMoW84
 ILPPEejl986Ms2TP0eRWNMCh8H4ERyqZHVaALgA+w/7WiLXdOF/Y/r0X3AL6cw1BRM14
 +phO4YT+FPd3I2oSo1WQXjmQ7x9OEX17CHGbEiFQq3tJh5CZGwYdu1dHHBJv6hLwXbeg
 g7OIZtWNVHzIVfUbjCa2nzqjsGxro6o1khmLxI/GZacRQIWY2OM1lZRphezqYKCp4b0t
 dykw==
X-Forwarded-Encrypted: i=1;
 AKwUvByTL/Zhn989V5F1cJeneZuqIsYCh6phd/B3StMyOqnZTJ377IkvTcAgvkLd0rBuWdrSJWJOdQWiaYX+zQXtN/Wd@lists.sourceforge.net
X-Gm-Message-State: AFuF++ljCII2zzgYjpCaEu0WMjlFJ2BttAnVjcQohyQZ3KqakS1kJVRt
 i25f8GGfTV7oPwh6aZGr1KntbnwUCMGkEoF7rqznvbermLkEAfcSriJHAYlXfA==
X-Gm-Gg: AYBFou1tqiWDdBOXLxJWArckFYZtrrdT4TH6ZQy/4N5TWtLJ9sTVi/mwAaNBEprCiTl
 Y7rEDKvjG7L0xRlVYueM0/PSq84cNta0IudCPDLBqqD5T7zczyHDDnfUQKr4QCWf0dJHH3WUb6w
 5vR7OPbDUf1YHsAjfLYi4WdAOVpC1tyM0W83ORKb8vysBtDOU837Tfc+3Jt5Wh8YZhfzA0IzhwW
 fBokT/N+x2M3cnzthduS7u+0YUt0Rd0LVt3xVv7k5sS57Ash5zBaEzaTetES3GJ5Tk+llnyLKzk
 rAFhQS40oHSYWsEyG//mr7ViTCE7aJr+9q/sHMmwofYbxDbpzarbLejhCJQzm/tufjOGtYv5Bwr
 b4JPCS4vcJ6/oF0E12V6JEIIs78qjqY0WDVIkRQ6vAXCSTiEAgo5Tqhr3dSoit07dFbGyJsfZ8t
 aBsYDwtUjPIAmDWLygM+wpouIqkxX6jEmrrxnIoS24c/7qejgpRtiZa6Eg/Nn+2UIPUVDWea9K1
 NO6xONcsdiI/9wFnF1lAQ==
X-Received: by 2002:a17:902:f707:b0:2dd:c100:4b76 with SMTP id
 d9443c01a7336-2df69dd03e3mr11281765ad.45.1790130519921; 
 Tue, 22 Sep 2026 19:28:39 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a5a7b53sm3067265ad.21.2026.09.22.19.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 19:28:39 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Daeho Jeong <daehojeong@google.com>, Sunmin Jeong <s_min.jeong@samsung.com>
Date: Wed, 23 Sep 2026 10:28:33 +0800
Message-ID: <20260923022834.3222763-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922123443.2908902-1-zhanxusheng@xiaomi.com>
References: <20260922123443.2908902-1-zhanxusheng@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1x9Ciz-000129-Mx
Subject: Re: [f2fs-dev] [PATCH] f2fs: recompute the pinned area boundary
 after resizing
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
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>, Wenjie Qi <qiwenjie@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Wenjie's v2 from Aug 29 already covers this and more: it rejects a shrink
that would not leave the tail, which mine would have let wrap, rechecks the
tail after the freeze, and restores the boundary when the final checkpoint
rolls the resize back.

	https://lore.kernel.org/r/20260829060524.2656620-3-qiwenjie@xiaomi.com

Please drop mine.  I searched the git history but not the list.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
