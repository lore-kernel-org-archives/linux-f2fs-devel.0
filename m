Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244C5C5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JUxLFEOCUBg4mgKCUlsiiLKLVvBcG0qTWV6ye0nj7eQ=; b=hRN3A87kg+/rnMJdQKwBIa4MAC
	7+oIYdevThqLVOj7MOzD/Lau4HP0Tqtwv6gpeKgnq7qP9AhJlyw0AcRokDE6MrSKgTxOHgzLIMO6g
	rNOBpZCjNgxzFmXlz2uizo78lbzl4LaXaCrLNtrE6z7GKD1/fW+ddCePQr/XMHWELsAw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyko9-0002yQ-32;
	Tue, 25 Aug 2026 06:38:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyko7-0002yG-A4
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 06:38:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PhnLXxGykIFhNbscdRmaimiCulgHoIJgLR4CORvL77A=; b=YlohiEn8lT6FZ8r14KgCBXCuHI
 vu9EBuPzJInRC0OSC6BGEEmVQxhMDBWmMC1NXnmKoU4RV33DM5BOWlalIwPdyAOhRxI7qH9G8TdMl
 i7eonor1hYjSkmabyejuT4ycgTenInuIELR/TUvfnwBGXsmxaiojX/CDBwzxrO5x8UFs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PhnLXxGykIFhNbscdRmaimiCulgHoIJgLR4CORvL77A=; b=hy80cZ2oNwc8NBHWjcec7yfOe2
 OmxiKd9pcw2UV2kKtLCgWZBDYxO91pgRk0+FEDb9kTIhbDpifk+cA9ztl654eQooHSux3UWzvUVt5
 wIP+59oNLrMm8WM5dliR94up3DvA1i27pUODakq/dY8iVvaMQzwdZhWPqB8Kbf43Hw50=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyko6-0005Cc-Lq for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 06:38:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 58C2041859;
 Tue, 25 Aug 2026 06:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207BC1F000E9;
 Tue, 25 Aug 2026 06:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787639925;
 bh=PhnLXxGykIFhNbscdRmaimiCulgHoIJgLR4CORvL77A=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Nsx3B7G/2k8YXy/kXtELJNzGJwi5GOyStXoOfkA3fAwA7FhGrw/bb+AaLQI8I2KH3
 83PIHDzDjUFByvHX7ut6cGM0vpduUsa1WVw1oRps51iX3D0yKVetRIRQOWS2PejyEN
 vd3Hv4CuzCS9NKQid0H1CfCnN7969hHzqp8FgnSctLqcqeXFfWKffJ4EAERN+O65Ex
 yRSMcROdy58c7sl3OE+REQ150e6CQEyyc6b+7hQJLDvBTh44+eFD2UVLsx7t/S/mrb
 4FLv2x8g+d4FOrU+8pPHurQkyR4Q/JkpFTaCddrtr2dayjcsmMKQeKVG1a5S3vKJ3B
 NE9ci8s5GZVig==
Message-ID: <260d39d2-b619-4caa-b087-d165211b229a@kernel.org>
Date: Tue, 25 Aug 2026 14:38:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>
References: <20260824134731.3704352-1-chao@kernel.org>
 <20260824134731.3704352-8-chao@kernel.org>
 <20260825054309.400026-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260825054309.400026-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wyko6-0005Cc-Lq
Subject: Re: [f2fs-dev] [PATCH v2 07/12] f2fs: cache: use node cache
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/25/26 13:43, Wenjie Qi wrote:
> Hi Chao,
> 
>> entry = xa_load(&META_CACHE(sbi)->root, nid);
>> if (entry)
>> 	return;
>>
>> entry = f2fs_grab_node_cache(sbi, nid);
> 
> The first lookup uses `nid` against `META_CACHE`, whose keys are physical
> block addresses, while the subsequent cache operation uses the NID-keyed node
> cache.
> 
> Is the lookup here intended to test the PBA-keyed meta cache or the NID-keyed
> node cache?

Yeah, nice catch! I encountered a panic due to this issue, have fixed this
locally, thanks for pointing it out anyway.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
