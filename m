Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12342606A323
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Oct 2026 09:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WPzVHZhw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Q9uGRmpQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OlJW9HMO;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QLnBLVxy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z3MAqgwfURHsflJVRE1PrL28CppaW7HbAurgQcBoioM=; b=WPzVHZhwgYnsRsySba7Fe+2H2i
	nl8KoaRke+r+vHBoP2N4ao20UOCRVRjsqKchaBEdH1Bj+aQNmsqpt9qG/GsG9KDwq6r+C9AeY9Fty
	xgwRatP7SgR4ykxQSJy6FZAqUs8DijHgULa/xzr0yb5p33509b4Lk5/aGmPrZQ36GmGg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJ5v1-0001Jm-3y;
	Tue, 20 Oct 2026 09:14:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xJ5ut-0001JO-RV
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 09:13:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cBT5Tv/OCYXZ5REQMB2nW+cv403IPsf1vrinm69NgC0=; b=Q9uGRmpQOGrY9FR/ssU4wcv1Er
 T4zHGPqhQYgc1nKqtyLwxKvn3i1295/0Jz97EO4vHDWIDkyDe/8nUfUWwMqneNLPMt3TBkRQv6xMY
 AeHEA95u/x6G/JNG7AxaXMJgkteMWmp4YjgCT447EGo34pvARXt7IRxo5mtHpMDLtrUw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cBT5Tv/OCYXZ5REQMB2nW+cv403IPsf1vrinm69NgC0=; b=OlJW9HMOuQJpAMHNprtfNAesMO
 hGfq0AbAQPK2xp4zxupIHaYMtB/EftC2DUEarwOW3F3EdPa6dqp8JgImzXKEaAijwaTkt0SiDWJlv
 B3QT0er9YkVajztNmwR/TE4S5lCEYO1xEHbrUZyXA48clr5QqoZOF6SODgFDuNYYpwTU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xJ5us-0007Ho-9a for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 09:13:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ECD4B406D7;
 Tue, 20 Oct 2026 09:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD2A1F000C4;
 Tue, 20 Oct 2026 09:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792487628;
 bh=cBT5Tv/OCYXZ5REQMB2nW+cv403IPsf1vrinm69NgC0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=QLnBLVxy/rzkLd0FngifJtK1Tqe/bFoag34nXhw4wCLaJc44NxrGppj//PRtUy1/H
 y8AGW4q+q21yxVYvn8qpW0WcF8/Tc/ZRXps1P0278s/P0joZD4DcN+//jHC6ns0njD
 qq8O2Lz9kyaGWPvJY2gMEp7kJ29YG6fJxgpv4pf4WR23NCemQ/TQszc7f6Vl1ETxoe
 HS1YVWYsfA/G4Imd7LCKVwyzSum8U29rrhG4ePfRfhd6YUNAi9GXM8qhSFzdlUmkR5
 hVlp90x8/jJvzbiuya5Zko1k7XJZB48thL3G9EOk2CIH6tVHvNHjRnBMQNk9wPWqwC
 Dj5QDRHQfWhdg==
Message-ID: <5c97f2ab-0fdb-4f87-898a-0f43ef42f470@kernel.org>
Date: Tue, 20 Oct 2026 17:13:45 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261014152138.138281-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261014152138.138281-1-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJ5us-0007Ho-9a
Subject: Re: [f2fs-dev] [PATCH] f2fs: expose resizable_tail feature via sysfs
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/14/26 23:21, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Userspace has no way to know whether the kernel supports the
> resizable_tail_secno mount option before mounting. Passing it to a
> kernel without the support fails the mount with -EINVAL, and checking
> /sys/fs/f2fs/<disk>/pinned_area_max_secno requires an f2fs instance
> to be mounted already.
> 
> Export /sys/fs/f2fs/features/resizable_tail so that userspace can check
> the support before formatting or mounting a filesystem that relies on
> resizable_tail_secno, e.g. a filesystem whose tail is going to be shrunk
> online later.
> 
> Fixes: c966d29e01bb ("f2fs: support resizable tail section and unify pinned allocation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
