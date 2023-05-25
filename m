Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4CFC77B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 May 2023 01:22:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q1zgC-0000u1-1p;
	Thu, 25 May 2023 01:22:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q1zgA-0000tv-Hb
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 May 2023 01:22:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ci2ZuYowMvHm1l3V/tIf/kYihroot8eI6dwsT3SXuVs=; b=KMQdX1jtdMA/VGiaKtZHHIpijM
 FUcULhXEeYCXK4K0wijunK/a8UKLhOi93lAY3+6mfN17a2w7+lNFxcV1jJW/sxRCBCUUzCm7Bf4ii
 yq66i6vUUUpIWYK+HSY/u4TR9JJ1ICsh9ynWI7kgiyAXrP8jAxgkKcw9opMT9c2iIiGQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ci2ZuYowMvHm1l3V/tIf/kYihroot8eI6dwsT3SXuVs=; b=h6uNsFflMXq6a1Qwt/S6DKUFvj
 0qJjy4xGpRJivNHIPjaNstporQIROMfSQrnHqJPi5vXsZnGX4c/05O1so+hH7bX7MIkEWVzp1hFkU
 yMtk84fUAv9BDdVqyxx6rYd1yRt3NwF1lPZ6y0lc+ErJlFssAjXqhWhT+JDm2jEdKM5w=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q1zgA-001oSu-Pp for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 May 2023 01:22:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6AE296172F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 25 May 2023 01:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4ADC433EF;
 Thu, 25 May 2023 01:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684977724;
 bh=SaYWU6xeTOrh3nr7oY2u0RWLBtyJC+VYGWpASeyq10I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WCzBODKkRE8AKVVnbLXDHdKt6VmwKtwzB+OaSQxITHZV+Q97Es0eksLAkfgdvB34R
 U6mwwWPRk+2YXxJifkW5iQzhvRrKBszkMJ9H+6cHt31XMf6VPGLkyUw4GG2y0T6ufs
 L9zzD1e/qeJqkpmPCHbT80ibR/XaXTwNOQBOurn6xvnk3sC6GxwzRkMl1Z1naLH8+r
 wNg9jxxI0w8B1Com9EGT9vUd2gb5gL2p3/9YfxExuQ594a0t8CT+KHk1xe/4w5Q1RB
 8kcx7Ausj63cXY0jAr/2yOPf7oGK+rv/GDfZh9hFlW8nD56tOLYO32WkYuXbe8PdYA
 hytxPrLeB9jeA==
Message-ID: <df5c91f4-9d97-549e-b0ef-85fc3de36cd2@kernel.org>
Date: Thu, 25 May 2023 09:22:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230517082632.748914-1-chao@kernel.org>
 <20230517082632.748914-3-chao@kernel.org> <ZGWBFvPFvQH7qdmz@google.com>
 <a54081b2-ae51-6331-28df-f292a8009862@kernel.org>
 <ZG1rAWuHP+46AiEE@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZG1rAWuHP+46AiEE@google.com>
X-Headers-End: 1q1zgA-001oSu-Pp
Subject: Re: [f2fs-dev] [PATCH 3/4] mkfs.f2fs: cleanup w/
 alloc_next_free_block()
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/5/24 9:40, Jaegeuk Kim wrote:
> On 05/18, Chao Yu wrote:
>> On 2023/5/18 9:36, Jaegeuk Kim wrote:
>>> On 05/17, Chao Yu wrote:
>>>> Introduce alloc_next_free_block() to wrap below openned codes:
>>>>
>>>> 	blkaddr = get_sb(main_blkaddr) +
>>>> 			c.cur_seg[curseg_type] * c.blks_per_seg +
>>>> 			c.curseg_offset[curseg_type];
>>>>
>>>> Meanwhile add curseg_offset field in f2fs_configuration to record
>>>> last blkaddr in each log.
>>>>
>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>> ---
>>>>    include/f2fs_fs.h  |   2 +
>>>>    mkfs/f2fs_format.c | 101 +++++++++++++++++++--------------------------
>>>>    2 files changed, 45 insertions(+), 58 deletions(-)
>>>>
>>>> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
>>>> index 8475645..05d27ba 100644
>>>> --- a/include/f2fs_fs.h
>>>> +++ b/include/f2fs_fs.h
>>>> @@ -603,6 +603,8 @@ struct f2fs_configuration {
>>>>    	/* compression support for sload.f2fs */
>>>>    	compress_config_t compress;
>>>> +
>>>> +	block_t curseg_offset[6];
>>>
>>> NR_CURSEG_TYPE?
>>
>> The macro is defined after struct f2fs_configuration...
>>
>> How about updating all value w/ macro in below patch, as the patch
>> relocates struct f2fs_configuration?
> 
> Could you please post patches?

Sure, let revise in v2. :)

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
