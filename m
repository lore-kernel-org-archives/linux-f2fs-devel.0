Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558F2C982D8
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 20 Sep 2026 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=80nf8Of/S+jCz7nxS6Aef7JaZIwVhuXhf+AyDMb/FlE=; b=Td+hxHscV/B55wA0A1ijrb6g7+
	9bJ3J4Slcwbf/tQgqnB+kcg6h0b8lcJlPsSQa+QglDH1pDm/OkTxAl4VBSJf+QMKRvJGfffGvAD5v
	H9Cnbkpz34hoBFLUCOGEyUQ4bu/3gsPbzZVGaBHFzJJBBLNRu87ooSNG/BMuymHK+7jw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8Jto-0006Dm-Tw;
	Sun, 20 Sep 2026 15:56:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1x8Jte-0006Da-Oe
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 20 Sep 2026 15:56:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hy0fiEvJf8BgINQGiOsxZaXAYGTquZ+7FPR1Y8QNrqw=; b=ZQx2aQjwHBE23LxxkU0Nz1mwPB
 nJ4w9+FI/1IyjXnvFPFLvGM/LgPjwpCjJAhukN2vQv8e8n/yj7vbLXJWhKOFn2AXQtOLFJ2N9YMbs
 qEfZqjTU1j0lXGhhk3Su6ZsJaXpMpEDMIG6NNhPIaOxfgV7fJ3AyXYfP5aR0XO2VO+jM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Hy0fiEvJf8BgINQGiOsxZaXAYGTquZ+7FPR1Y8QNrqw=; b=RGitPtr3Mz5K42zI1140BVaMpp
 NFyH2+PRKn0ssCBQDdHaZEGE5WRs03fqSWBZTowFVHKA7EHGpUuuSqRrB+UBzPO7u1KgAfPLQ2O4r
 /g5HKMojfi4Q+IkF+Fd4VXJs6IIQfg16rnIL7+xrxjYJKJZ97FZHkOwxE5KiBhqdjUdI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8Jte-000737-SO for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 20 Sep 2026 15:56:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8458E4183E;
 Sun, 20 Sep 2026 15:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56041F000FF;
 Sun, 20 Sep 2026 15:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789919761;
 bh=Hy0fiEvJf8BgINQGiOsxZaXAYGTquZ+7FPR1Y8QNrqw=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To;
 b=U5EoRaenbscR15G9ukqE2alcM2qMNVKiOKi7pRkYAmrAPJkfJbvVzFB6U07rd5Jd8
 864Za2kKnv4/C0SYzY1kiq6p0BwRnRN1Zt97Hzj6dhal7f40i6QCjjLUwvpBmKdIuv
 N9XtRJBxh2D8gvn5JbSDZqPqBBSz7UMPFMTJPaCJb/HlsMDHv2HehxvGuXgSN/12GP
 88nxGG6Kno8B20JH3kTJBJ42qsRZpTHzSgx1+IYO8B/G1GREfPuSTn6saXPbN7jxWB
 u2DjlU8V9GP4ZQyqyvsRmzZKNlqzDvoZgy5xYwYOYaRdTga9Z+YdtZTDaZfOr65Z5Z
 cMrTgg9cUR7NQ==
Message-ID: <9ef8ba86-6ebb-4b50-8e3d-fd8bf8483c24@kernel.org>
Date: Sun, 20 Sep 2026 23:55:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: zlang@kernel.org
References: <cover.1784949154.git.asj@kernel.org>
 <ba6c3800-d89a-49dc-b6c3-bf51277b2107@kernel.org>
Content-Language: en-US
In-Reply-To: <ba6c3800-d89a-49dc-b6c3-bf51277b2107@kernel.org>
X-Headers-End: 1x8Jte-000737-SO
Subject: Re: [f2fs-dev] [PATCH v8 0/13] fstests: add test coverage for
 cloned filesystem ids
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
From: Anand Suveer Jain via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Suveer Jain <asj@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Thanks for the review, Zorro. Based on the recent regression report [1]
and its fix [2], I will likely need to adjust one or two of these test
cases and add a new one. I'm waiting for the kernel fix to land in
for-next to confirm the behavior before updating the tests accordingly.

[1]
https://lore.kernel.org/linux-btrfs/be0c08f5-2f31-40f5-8a3b-f2f58b3e00ff@intel.com/

[2]
https://lore.kernel.org/linux-btrfs/b18b4324-6bd6-4231-bcb6-1f1f136222e0@kernel.org/

Anand



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
