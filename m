Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88C1C3DA49
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jul 2024 02:55:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sYGXW-0001uC-Bf;
	Mon, 29 Jul 2024 02:55:10 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sYGXP-0001u1-1U
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jul 2024 02:55:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YVM/XKobZX+XjxXiZwzHQSAtay3xIeP53X8GXo+h4p4=; b=bBIo2CmJFmMOTlkU1IpotXE5JY
 NtcDM0o7PjcIqGpjmWPLIReVlMyFarxGWFxkogPnv2WhlZt4HvhGJE7HGfO9qo2iXGOdttYU/khHC
 2F8pbavCuEDH2obxiDvis69DyVPfJfMdIBYDlXwN/vHVd0A7uE64cuCWs2ZK61HjA7oc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YVM/XKobZX+XjxXiZwzHQSAtay3xIeP53X8GXo+h4p4=; b=dBrsKEuOU0aCTpB0kPtjHxrNSh
 Wmn239W/tzpn5IhpB96xA1NLsPI6P69pse8OFEP9TYzuXRRns98ry5QdSi2K0XdKxMNy4q2nB9ECK
 ddrQDzpWzAOANaXHijnZSDkAD0BjGjpQ2wDMg9ejoObUZHu4T8WBUKKqTqSWI3enIspE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sYGXO-00050H-9a for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jul 2024 02:55:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E46F461323
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 29 Jul 2024 02:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA7BC116B1;
 Mon, 29 Jul 2024 02:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722221691;
 bh=CxoLcnEcwOVtU1sK4vdRlZkJkyUaqBQg4RZqDYGsewc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=t+3HO33axhe4bI77zQ7MMUu9NHRW2zqAhWCzNCGNupsn9Xqru9T7dLBfxCJXuDhLg
 xW5vS/sN/7jlZe+hWiTzDkmBgZFOqDxM4LhoImfgz/+RTdvnfk4pif3yk0Lmzu1moW
 dDZQJjkDQ1juI1cWVrO4+W6ZVPGhLo34mXn53tteyCtjx1Zqb6GbWDvhnAWF9eucBY
 Z46hGqzKls8vSZks2XGCLNo0DEUheNEr/goct9SySfk6Q4NuXLav5hQYfbDY/aAwFu
 fg8Tx/R2XukD+mQQIryc6nTGSgRB3vcSoj2yf9m+7ks2Pcl9Ttqnbe6+mAFhjp4m6K
 IYNJNt08u7rtg==
Message-ID: <74dbb5f1-1565-4971-ae5c-c176d62cfa8f@kernel.org>
Date: Mon, 29 Jul 2024 10:54:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20240712073415.227226-1-chao@kernel.org>
 <ZqKDnpzwX85RyGaa@google.com>
 <c2b7d0cd-ea10-4e25-829c-53967927bd03@kernel.org>
 <ZqRpHOJyWU3Sn8Ma@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZqRpHOJyWU3Sn8Ma@google.com>
X-Headers-End: 1sYGXO-00050H-9a
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't traverse directory blocks after
 EOF
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/7/27 11:27, Jaegeuk Kim wrote:
> On 07/26, Chao Yu wrote:
>> On 2024/7/26 0:55, Jaegeuk Kim wrote:
>>> On 07/12, Chao Yu wrote:
>>>> All directory blocks are within the scope of i_size, so let's limit
>>>> the end_block to just check valid dirent blocks.
>>>
>>> Do we really need this?
>>
>> f2fs_readdir() and f2fs_empty_dir() uses dir_blocks() for upper boundary,
>> this patch aligns find_in_level() w/ them.
>>
>> Also, it can avoid grabbing never used page cache across EOF.
>>
>> So, we can consider taking this patch?
> 
> I'm wondering whether the current code has a bug or not.

I think it's not a bug, but, in corner case it may waste memory and
cause a bit performance reduction.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Meanwhile, it uses dir_blocks() instead of variable for cleanup in
>>>> __f2fs_find_entry().
>>>>
>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>> ---
>>>>    fs/f2fs/dir.c | 6 ++++--
>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>>>> index 02c9355176d3..d4591c215f07 100644
>>>> --- a/fs/f2fs/dir.c
>>>> +++ b/fs/f2fs/dir.c
>>>> @@ -305,18 +305,21 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
>>>>    	int s = GET_DENTRY_SLOTS(fname->disk_name.len);
>>>>    	unsigned int nbucket, nblock;
>>>>    	unsigned int bidx, end_block;
>>>> +	unsigned long last_block;
>>>>    	struct page *dentry_page;
>>>>    	struct f2fs_dir_entry *de = NULL;
>>>>    	pgoff_t next_pgofs;
>>>>    	bool room = false;
>>>>    	int max_slots;
>>>> +	last_block = dir_blocks(dir);
>>>>    	nbucket = dir_buckets(level, F2FS_I(dir)->i_dir_level);
>>>>    	nblock = bucket_blocks(level);
>>>>    	bidx = dir_block_index(level, F2FS_I(dir)->i_dir_level,
>>>>    			       le32_to_cpu(fname->hash) % nbucket);
>>>>    	end_block = bidx + nblock;
>>>> +	end_block = min_t(unsigned int, end_block, last_block);
>>>>    	while (bidx < end_block) {
>>>>    		/* no need to allocate new dentry pages to all the indices */
>>>> @@ -361,7 +364,6 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
>>>>    					 const struct f2fs_filename *fname,
>>>>    					 struct page **res_page)
>>>>    {
>>>> -	unsigned long npages = dir_blocks(dir);
>>>>    	struct f2fs_dir_entry *de = NULL;
>>>>    	unsigned int max_depth;
>>>>    	unsigned int level;
>>>> @@ -373,7 +375,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
>>>>    		goto out;
>>>>    	}
>>>> -	if (npages == 0)
>>>> +	if (dir_blocks(dir) == 0)
>>>>    		goto out;
>>>>    	max_depth = F2FS_I(dir)->i_current_depth;
>>>> -- 
>>>> 2.40.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
