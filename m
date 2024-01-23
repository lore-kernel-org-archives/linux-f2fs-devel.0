Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFF9C47258
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Jan 2024 23:31:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rSQEm-0003T1-UD;
	Tue, 23 Jan 2024 23:31:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1rSQEl-0003Sp-Vj
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jan 2024 23:31:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SYacebUnv+qVfwFBaCCck/Am3I4UN5z5dk1Geqs0ZPM=; b=dCw9bYkSY0jgmbF4VuHpK1biHm
 SUgbuvW2eINQFpucmehTepAI+mgywS+qRgsQA3NqZ6I+MJ37DRLkmMCQzAOWpdq5hfJIAxWSJnjKv
 ht/CoQD/Ha8Og75GcN2ZvYCEwIYN/C9z2LSpec7I0WcQFpo7m90mzE11fbHHNtsMwQ5c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SYacebUnv+qVfwFBaCCck/Am3I4UN5z5dk1Geqs0ZPM=; b=elYiCrGLUmzIyNLssj055MRjLB
 MSJQiURTvSSuPvqN0B9bXLKOLRYwp/3/MLY6ZpViPnoXPLgxsW6d/Qhm+KNGix6NtZkF8zt6qWRXE
 bOutMeTjEna9nVwr+EDMmqz6CTfcIpzK1CnkhqzE/cBjGiX6fF9Dc8EmUv3RtNAZ4gCY=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rSQEk-0003XJ-Og for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jan 2024 23:31:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A6472CE307E;
 Tue, 23 Jan 2024 23:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68F9C433C7;
 Tue, 23 Jan 2024 23:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706052670;
 bh=5IKCI89izY9q7OnAbvvB4vyI9VWaIqEYhVeW69cwKBo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=msTHDUvykvzFCBJnKtqkfMnJkhCV4e1CWKyluOEIj1Qy17EJpTXSHTeb5+mROq8wc
 RQhoZ8shAfLx5k88DQXJX8bx/UFxML65CH+qDuFsfun+R0Tkz3P7qY1d2LtdEdF7cK
 +VfPtaqJG4NgOMJiwMlU+9wqG4FVcDhKNvh5WzwN6DWM+BH7uFAjWOWs+jxAaysQb6
 mtP+GPGpeeLUVX/oW0VjbXqKyXEWl0r+yZ9Fiq7ozko2SMkoqocAjhpq6zfnKDyqqY
 oFeXFGIDddZpbotoXXZxw/1sKXOG8gM5jeAjiedV5py8EDl4olJY48Vy/4O2c1b0OR
 FpL2Ka9boi3Rw==
Message-ID: <a08be89b-6825-4559-a909-632f9571d387@kernel.org>
Date: Wed, 24 Jan 2024 08:31:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>, Mikulas Patocka <mpatocka@redhat.com>
References: <20240123-zonefs_nofs-v1-0-cc0b0308ef25@wdc.com>
 <20240123-zonefs_nofs-v1-1-cc0b0308ef25@wdc.com>
 <31e0f796-1c5-b7f8-2f4b-d937770e8d5@redhat.com>
 <ZbBKC3U3/1yPvWDR@dread.disaster.area>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZbBKC3U3/1yPvWDR@dread.disaster.area>
X-Headers-End: 1rSQEk-0003XJ-Og
Subject: Re: [f2fs-dev] [PATCH 1/5] zonefs: pass GFP_KERNEL to
 blkdev_zone_mgmt() call
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
Cc: Naohiro Aota <naohiro.aota@wdc.com>, dm-devel@lists.linux.dev,
 linux-f2fs-devel@lists.sourceforge.net, Chaitanya Kulkarni <kch@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Mike Snitzer <snitzer@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Chris Mason <clm@fb.com>,
 Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-btrfs@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 1/24/24 08:21, Dave Chinner wrote:
> On Tue, Jan 23, 2024 at 09:39:02PM +0100, Mikulas Patocka wrote:
>>
>>
>> On Tue, 23 Jan 2024, Johannes Thumshirn wrote:
>>
>>> Pass GFP_KERNEL instead of GFP_NOFS to the blkdev_zone_mgmt() call in
>>> zonefs_zone_mgmt().
>>>
>>> As as zonefs_zone_mgmt() and zonefs_inode_zone_mgmt() are never called
>>> from a place that can recurse back into the filesystem on memory reclaim,
>>> it is save to call blkdev_zone_mgmt() with GFP_KERNEL.
>>>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> ---
>>>  fs/zonefs/super.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
>>> index 93971742613a..63fbac018c04 100644
>>> --- a/fs/zonefs/super.c
>>> +++ b/fs/zonefs/super.c
>>> @@ -113,7 +113,7 @@ static int zonefs_zone_mgmt(struct super_block *sb,
>>>  
>>>  	trace_zonefs_zone_mgmt(sb, z, op);
>>>  	ret = blkdev_zone_mgmt(sb->s_bdev, op, z->z_sector,
>>> -			       z->z_size >> SECTOR_SHIFT, GFP_NOFS);
>>> +			       z->z_size >> SECTOR_SHIFT, GFP_KERNEL);
>>>  	if (ret) {
>>>  		zonefs_err(sb,
>>>  			   "Zone management operation %s at %llu failed %d\n",
>>>
>>> -- 
>>> 2.43.0
>>
>> zonefs_inode_zone_mgmt calls 
>> lockdep_assert_held(&ZONEFS_I(inode)->i_truncate_mutex); - so, this 
>> function is called with the mutex held - could it happen that the 
>> GFP_KERNEL allocation recurses into the filesystem and attempts to take 
>> i_truncate_mutex as well?
>>
>> i.e. GFP_KERNEL -> iomap_do_writepage -> zonefs_write_map_blocks -> 
>> zonefs_write_iomap_begin -> mutex_lock(&zi->i_truncate_mutex)
> 
> zonefs doesn't have a ->writepage method, so writeback can't be
> called from memory reclaim like this.

And also, buffered writes are allowed only for conventional zone files, for
which we never do zone management. For sequential zone files which may have
there zone managed with blkdev_zone_mgmt(), only direct writes are allowed.

> 
> -Dave.

-- 
Damien Le Moal
Western Digital Research



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
