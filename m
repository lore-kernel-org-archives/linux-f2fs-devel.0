Return-Path: <SRS0=icLK=M4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04595C43214
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Aug 2021 13:36:18 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28DB61004;
	Thu,  5 Aug 2021 13:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C28DB61004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mBdXj-0002dA-QF; Thu, 05 Aug 2021 13:36:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1mBdXi-0002cy-4D
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Aug 2021 13:36:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2PLX9hAyvYrYWFY0IkRnLLPAM1HZm4d7Ta0uk9qlYP8=; b=Z5QmXvV8IWS6ee5/0DLlKFSGM8
 rAMDnqDq9lLfrqjZu7BaPAllN7WZvP6O9HohFqi8KyKk8kbQxEMFYCM5g2xcTlzB2ZwODPkMXQZ0o
 GC+65432B0+q3zrEk1u1NL5nZ9TZyeny1DpQSDA1vdCDmb1DCbtcGB2CSR6atdtj32Sk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2PLX9hAyvYrYWFY0IkRnLLPAM1HZm4d7Ta0uk9qlYP8=; b=nK30Qjup9ygjIguZXFpIeYpghE
 YKSx2i3cK43QX3REKLBy8Z7sWRjaJ65+QbOSAbBORqRezPxaPTDQNWy6atGb536yllyDZaMKimaBX
 XGYXVzI+YSW8Bso1wpaqRhLQXtlxk5SmpMTt5aqG8kgiN1Ejfl/llMd65hkd5qpB7/7g=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mBdXa-000505-Pg
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Aug 2021 13:36:14 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24A5F61004;
 Thu,  5 Aug 2021 13:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628170556;
 bh=CpATmNokx74QwJ4qfUqqYxtBNb1Sl8uIz0anyAYPWmM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=iB4gZBTic5a1gzXrmJgYu21Kb5v4jv7mMq9LlpK1yO0Ac/LwQl19c055lAVIEm7Vg
 zKcbynoJX7FBoYGk+EGSVYo8Z1nbfH1wW2/AgLktPT7WgUrHRAB4TrG/2U8Z3hKPg7
 YlPIG5S25At90kZsaN/wUGor/11oNHH/j+XpjXtE5crEOFUgnxSHDpVsICJQymlcov
 aq8/AkxfzzOvTK/S09E27IgB4V3nFYroAW2lRJkpGw5+SMdJn3lI5JAdg7l1hN6j1Q
 mxyNfjQwGB3nVwajqMojBU8k5D8BZRfPlL4glxyo7F2y7lZqaNwwEu4ZBRL4lqNnrs
 GGxu62KP2MRsQ==
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210804022348.1414543-1-chao@kernel.org>
 <YQsIj0wKk6YbN/FJ@google.com> <YQsmfm3ibU6bhvZr@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <bb635f86-b29b-384b-cfe0-c8b78e3c9ec5@kernel.org>
Date: Thu, 5 Aug 2021 21:35:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQsmfm3ibU6bhvZr@google.com>
Content-Language: en-US
X-Headers-End: 1mBdXa-000505-Pg
Subject: Re: [f2fs-dev] [RFC v3] f2fs: extent cache: support unaligned extent
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
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Chao Yu <chao.yu@linux.dev>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/8/5 7:45, Jaegeuk Kim wrote:
> Chao,
> 
> How about this?
> https://github.com/jaegeuk/f2fs/commit/d6bbe121bc24dfabfedc07ba7cb6e921fb70ece0
> 
> I'm digging one bug in __insert_extent_tree w/ the patch tho.
> 
> On 08/04, Jaegeuk Kim wrote:
>> On 08/04, Chao Yu wrote:
>>> Compressed inode may suffer read performance issue due to it can not
>>> use extent cache, so I propose to add this unaligned extent support
>>> to improve it.
>>>
>>> Currently, it only works in readonly format f2fs image.
>>>
>>> Unaligned extent: in one compressed cluster, physical block number
>>> will be less than logical block number, so we add an extra physical
>>> block length in extent info in order to indicate such extent status.
>>>
>>> The idea is if one whole cluster blocks are contiguous physically,
>>> once its mapping info was readed at first time, we will cache an
>>> unaligned (or aligned) extent info entry in extent cache, it expects
>>> that the mapping info will be hitted when rereading cluster.
>>>
>>> Merge policy:
>>> - Aligned extents can be merged.
>>> - Aligned extent and unaligned extent can not be merged.
>>>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>> v3:
>>> - avoid CONFIG_F2FS_FS_COMPRESSION as much as possible
>>> - clean up codes
>>>   fs/f2fs/compress.c     | 24 ++++++++++++
>>>   fs/f2fs/data.c         | 28 +++++++++++---
>>>   fs/f2fs/extent_cache.c | 88 +++++++++++++++++++++++++++++++++++++-----
>>>   fs/f2fs/f2fs.h         | 42 +++++++++++++++++---
>>>   fs/f2fs/node.c         | 18 +++++++++
>>>   5 files changed, 179 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>>> index 4aa166d3d9bf..296ff37d4b08 100644
>>> --- a/fs/f2fs/compress.c
>>> +++ b/fs/f2fs/compress.c
>>> @@ -1719,6 +1719,30 @@ void f2fs_put_page_dic(struct page *page)
>>>   	f2fs_put_dic(dic);
>>>   }
>>>   
>>> +/*
>>> + * check whether cluster blocks are contiguous, and add extent cache entry
>>> + * only if cluster blocks are logically and physically contiguous.
>>> + */
>>> +int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn)
>>> +{
>>> +	bool compressed = f2fs_data_blkaddr(dn) == COMPRESS_ADDR;
>>> +	int i = compressed ? 1 : 0;
>>> +	block_t first_blkaddr = data_blkaddr(dn->inode, dn->node_page,
>>> +						dn->ofs_in_node + i);
>>> +
>>> +	for (i += 1; i < F2FS_I(dn->inode)->i_cluster_size; i++) {
>>> +		block_t blkaddr = data_blkaddr(dn->inode, dn->node_page,
>>> +						dn->ofs_in_node + i);
>>> +
>>> +		if (!__is_valid_data_blkaddr(blkaddr))
>>> +			break;
>>> +		if (first_blkaddr + i - 1 != blkaddr)
>>> +			return 0;

The merge condition looks wrong, shouldn't be:

if (first_blkaddr + i - compressed ? 1 : 0 != blkaddr)
	return 0;

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
