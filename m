Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F24BC5DF97
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 23 Aug 2026 12:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A16j8lVVQ9e+6WMhoLnZbXTWh79m3F8uEEbT6AZ9xDY=; b=GtE4DFh96PWo8aIdu7fmEHWOXl
	UzupCYQq0fSwmv5xFAzwT+7cDrolD8b8XDb2IR8+klkGYPk4V71RY1Tgu6UedkFXWBGULSD5kP2SX
	WgWio/9lNEWe60DQtluRrO9nX2mqBCIDYfYuwDUGcq8VvTLwXv1cRZ/N7/tFhBtwNaDM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wy7jy-0000pP-8I;
	Sun, 23 Aug 2026 12:55:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wy7jx-0000pG-JW
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 12:55:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cl+35oh2UryerTbpMC4kFyCA5UcSef0P0LKJuEXBCXY=; b=a2EkXVfhOhsy4wLop1n/gEa7Kl
 eVk+8EdEgoq4hVGUVmcLGCC7J5bfZdidgLoY9wZbxAAagidzRyTX6MOlQmIyCVV+b5KqURU2NNBP4
 OgGzfC7xKkLjbtan0BOzMhPbR9Tdo2p09E7nViWFbqBTky2YBdvSxZQZ6d4Kt4X5cH9g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cl+35oh2UryerTbpMC4kFyCA5UcSef0P0LKJuEXBCXY=; b=eSC1YiiE9RjFyswmPxUR24hxf1
 V0u2VGRT1DnYe2p9/okwa6C8msiVIkQ53AfBKzMFabBWgR+XIqczrD8Hus3clQb4pcg5I83JrYeFF
 Qy2ztZfhO6cjuz7JXsODnM7XUUNsrb2FgmqHIbkr+mZ7iAxHRbPbUivgYaHDp5cxdw+4=;
Received: from mail-pl1-f170.google.com ([209.85.214.170])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wy7jy-0006uS-0p for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 12:55:58 +0000
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cacb8416a1so21597495ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 23 Aug 2026 05:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787489752; x=1788094552; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cl+35oh2UryerTbpMC4kFyCA5UcSef0P0LKJuEXBCXY=;
 b=tN6BImTNG9jcUVulxk8RRxbPsmNQPHcwTyh4wwo4yK0i8g/7cWKKC2W+k/xlwasapg
 yFMvOy7wmBsWlQZpV4/EI9satd1Jw76F4GZWV/AqZtVSN+suzSkvc4ZmbEe34A+lDJEM
 QHl0q2W8EE+ZpTw0PNYFK60DzOmY3/0lBP33L4WC2hjxn8OsY/G86Eef8UDrdzQ2QeT9
 XloSvekpVPkVpT4Tb8MEX1xw4E4Qa+Oxj5bAwqiIoysNRpOcg41fmnvER+SWVeuryA05
 O4rgJmH98s3FTcSRSw5K3wvPH49I11xWIwhR36xBCG3Na5e1ZOeE1oRaf/nhN7QCo5qH
 MFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787489752; x=1788094552;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cl+35oh2UryerTbpMC4kFyCA5UcSef0P0LKJuEXBCXY=;
 b=O7y9qEnMAXurY8ZuQcC4x78XHnujXigFrzHPHKaZP6akLtLXdf+WOfFM3HD6r6A1qA
 L5jNqj9BNhHi60YSGKPJPjyxqdEWLoxd+i8J2RS6PEcowPk7Yn88erO/B9TuBrP11/kT
 G/jaufyQqS5fVSjhxS+09RT3uUtcLL2Zj40lc31WqPWvDq8/ReEaCrqtLeAr8UPrJmdY
 66NKkdEP8C8DS2itnN1M3eOZ1OThiBYLEUnlyT/rw64qRkuZHtLSdWFwRsmCDlAFAUja
 RaRZ8sYC0v1hbwhtUSn62aO48pTCo/m7IBgYh+XpXwr3/MEz7i4R5haSjF+PWta/z8GG
 IVxA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqWafx85ncK2KPhyTQ6lSC7BiOSGZnk9AR4MUG1lM5DKy6pxEG7SvqgvQAlvIqBlZ+0pgDjqS79boWa0tMne5HT@lists.sourceforge.net
X-Gm-Message-State: AFuF++mT9x4mDC2w2FhbGUzNkZ2MmEC8Cv0LgOWcfOPpgbWPyQ5pV4kx
 uNeVVjcE3McXoc6jz6K8fIMgLTo7pDWs6KisRL0JqD6jOZeBjxNH91BoLuD2NSjh
X-Gm-Gg: AR+sD12/lmRDER2+czsqYL0z4C2MNzpSlNzkC6vmG5aZv916wXM8NLO+KQialt/KjU4
 qIAv0GmT+q0tGeVWaijMr50xcBV0Q/MAqbStqJklJVxHHwpfqsZ875SAbmKm8TK7/Geapiyyalc
 sgHcvhAG9KwHqPCtqYrzRjtUtPuBb68Nov0B8/DpEX0c+auDjHCRB1nv8xQdfeAIrE1sg4pS+fp
 xkE1mVIpQBe6KWY6GWvJKSKd6azYxwHyUciUuEheBduisw7RW66hBCugdh3bxVyHR+E3J+HHFZG
 vgFN1NCvcYRDsI0ypx7eXVO6hmsMOwaHGeMZv1PJRz3o6N2PsM6NpUyLEB8WokooL1Mp8rNaeRI
 ibutBgY/b1SQqJfAYhK5+LuODJd2xlrQgnspkhhQYsrPQ7di+hpSGNZT3zdtlUDXLQ7owJGfpTJ
 wDyzWqVOFrQKp9YPag8nX9300f5ba1xHkgFMgPIUcMD6hBIUcNEa0fzWvd6S/9R4SZvRr8ZQgFL
 RAz/rVK92dgAGTduxesinzA
X-Received: by 2002:a17:903:1206:b0:2ca:1b97:70c5 with SMTP id
 d9443c01a7336-2d64adaff50mr307529455ad.4.1787489752176; 
 Sun, 23 Aug 2026 05:55:52 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d676792dfdsm9248875ad.26.2026.08.23.05.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 05:55:51 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Sun, 23 Aug 2026 20:55:46 +0800
Message-ID: <20260823125546.3229535-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820031721.12218-6-chao@kernel.org>
References: <20260820031721.12218-1-chao@kernel.org>
 <20260820031721.12218-6-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wy7jy-0006uS-0p
Subject: Re: [f2fs-dev] [PATCH v1 05/12] f2fs: cache: use meta cache
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
Cc: qwjhust@gmail.com, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Wenjie Qi <qiwenjie@xiaomi.com>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

> struct f2fs_cached_block *f2fs_get_sum_cache(struct f2fs_sb_info *sbi,
> 		unsigned int segno)
> {
> 	if (unlikely(f2fs_cp_error(sbi)))
> 		return ERR_PTR(-EIO);
> 	return f2fs_get_meta_cache_retry(sbi, GET_SUM_BLOCK(sbi, segno));
> }
>
> entry = f2fs_get_sum_cache(sbi, GET_SUM_BLOCK(sbi, segno));

`f2fs_get_sum_cache()` applies `GET_SUM_BLOCK()` to its argument.  Its other
callers pass a logical segment number, while this packed-SSA path passes an
already translated value.

Is the argument contract of `f2fs_get_sum_cache()` a logical segment number
or an already translated block address?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
