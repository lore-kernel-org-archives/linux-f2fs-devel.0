Return-Path: <SRS0=QJsr=6Z=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DB8C38A2A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 May 2020 01:29:14 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07562137B;
	Mon, 11 May 2020 01:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="nH4HAOxl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="GZ6nHN6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07562137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jXxFo-0005Qz-4r; Mon, 11 May 2020 01:29:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jXxFj-0005Qm-W4
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 May 2020 01:29:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sCfBx9UVWa0IW3LCaGSoYVLTYw4V0a2K4gvKuNJTQYQ=; b=nH4HAOxlpc6/23qyEPpBP2T5H0
 KWLfeBH0l4FfFC+1hCcNc5DSt7FP412B48MtB7SCcPGKtr5gC3h5Z0NnKbXRM3Z4/3C4neXwgrMOt
 a8VRMU3hbJvI+9qdBoSEc9R5BLR14rokCVLRVQIRm/QfKI7kEll/fFRz7L/6H560wk38=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sCfBx9UVWa0IW3LCaGSoYVLTYw4V0a2K4gvKuNJTQYQ=; b=GZ6nHN6DsrOLHOi8Wd/iatRTiG
 4n+rOk0TQsfEFgCNL1bIQbYTg2pEyYYQdfcJVhu1ZnfjCRFOeGSTStwJ4qtaQhcnRCnQGpaNwfdx6
 BapiXAW8TOYqIyJoa3/26cLfL8N+MzavEaOqJjoHYYOgP9bnBxCl9LrfCGivm1PId4H4=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jXxFh-003HLJ-55
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 May 2020 01:29:07 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 47DF1854CE10196CE5D;
 Mon, 11 May 2020 09:28:49 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 11 May
 2020 09:28:48 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <1588244309-1468-1-git-send-email-sayalil@codeaurora.org>
 <20200508161052.GA49579@google.com>
 <0902037e-998d-812e-53e7-90ea7b9957eb@huawei.com>
 <20200509190342.GA11239@google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <fbb5ef1e-214d-f34a-e1a0-32534c765e56@huawei.com>
Date: Mon, 11 May 2020 09:28:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200509190342.GA11239@google.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jXxFh-003HLJ-55
Subject: Re: [f2fs-dev] [PATCH V4] f2fs: Avoid double lock for cp_rwsem
 during checkpoint
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/5/10 3:03, Jaegeuk Kim wrote:
> On 05/09, Chao Yu wrote:
>> On 2020/5/9 0:10, Jaegeuk Kim wrote:
>>> Hi Sayali,
>>>
>>> In order to address the perf regression, how about this?
>>>
>>> >From 48418af635884803ffb35972df7958a2e6649322 Mon Sep 17 00:00:00 2001
>>> From: Jaegeuk Kim <jaegeuk@kernel.org>
>>> Date: Fri, 8 May 2020 09:08:37 -0700
>>> Subject: [PATCH] f2fs: avoid double lock for cp_rwsem during checkpoint
>>>
>>> There could be a scenario where f2fs_sync_node_pages gets
>>> called during checkpoint, which in turn tries to flush
>>> inline data and calls iput(). This results in deadlock as
>>> iput() tries to hold cp_rwsem, which is already held at the
>>> beginning by checkpoint->block_operations().
>>>
>>> Call stack :
>>>
>>> Thread A		Thread B
>>> f2fs_write_checkpoint()
>>> - block_operations(sbi)
>>>  - f2fs_lock_all(sbi);
>>>   - down_write(&sbi->cp_rwsem);
>>>
>>>                         - open()
>>>                          - igrab()
>>>                         - write() write inline data
>>>                         - unlink()
>>> - f2fs_sync_node_pages()
>>>  - if (is_inline_node(page))
>>>   - flush_inline_data()
>>>    - ilookup()
>>>      page = f2fs_pagecache_get_page()
>>>      if (!page)
>>>       goto iput_out;
>>>      iput_out:
>>> 			-close()
>>> 			-iput()
>>>        iput(inode);
>>>        - f2fs_evict_inode()
>>>         - f2fs_truncate_blocks()
>>>          - f2fs_lock_op()
>>>            - down_read(&sbi->cp_rwsem);
>>>
>>> Fixes: 2049d4fcb057 ("f2fs: avoid multiple node page writes due to inline_data")
>>> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/node.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>> index 1db8cabf727ef..626d7daca09de 100644
>>> --- a/fs/f2fs/node.c
>>> +++ b/fs/f2fs/node.c
>>> @@ -1870,8 +1870,8 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
>>>  				goto continue_unlock;
>>>  			}
>>>  
>>> -			/* flush inline_data */
>>> -			if (is_inline_node(page)) {
>>> +			/* flush inline_data, if it's not sync path. */
>>> +			if (do_balance && is_inline_node(page)) {
>>
>> IIRC, this flow was designed to avoid running out of free space issue
>> during checkpoint:
>>
>> 2049d4fcb057 ("f2fs: avoid multiple node page writes due to inline_data")
>>
>> The sceanrio is:
>> 1. create fully node blocks
>> 2. flush node blocks
>> 3. write inline_data for all the node blocks again
>> 4. flush node blocks redundantly
>>
>> I guess this may cause failing one case of fstest.
> 
> Yeah, actually I was hitting 204 failure, and thus, revised like this.
> Now, I don't see any regression in fstest.
> 
>>From 8f1882acfb0a5fc43e5a2bbd576a8f3c681a7d2c Mon Sep 17 00:00:00 2001
> From: Sayali Lokhande <sayalil@codeaurora.org>
> Date: Thu, 30 Apr 2020 16:28:29 +0530
> Subject: [PATCH] f2fs: Avoid double lock for cp_rwsem during checkpoint
> 
> There could be a scenario where f2fs_sync_node_pages gets
> called during checkpoint, which in turn tries to flush
> inline data and calls iput(). This results in deadlock as
> iput() tries to hold cp_rwsem, which is already held at the
> beginning by checkpoint->block_operations().
> 
> Call stack :
> 
> Thread A		Thread B
> f2fs_write_checkpoint()
> - block_operations(sbi)
>  - f2fs_lock_all(sbi);
>   - down_write(&sbi->cp_rwsem);
> 
>                         - open()
>                          - igrab()
>                         - write() write inline data
>                         - unlink()
> - f2fs_sync_node_pages()
>  - if (is_inline_node(page))
>   - flush_inline_data()
>    - ilookup()
>      page = f2fs_pagecache_get_page()
>      if (!page)
>       goto iput_out;
>      iput_out:
> 			-close()
> 			-iput()
>        iput(inode);
>        - f2fs_evict_inode()
>         - f2fs_truncate_blocks()
>          - f2fs_lock_op()
>            - down_read(&sbi->cp_rwsem);
> 
> Fixes: 2049d4fcb057 ("f2fs: avoid multiple node page writes due to inline_data")
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c |  9 ++++++++-
>  fs/f2fs/f2fs.h       |  4 ++--
>  fs/f2fs/node.c       | 10 +++++-----
>  3 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index d49f7a01d8a26..928aea4ff663d 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1168,6 +1168,12 @@ static int block_operations(struct f2fs_sb_info *sbi)
>  	};
>  	int err = 0, cnt = 0;
>  
> +	/*
> +	 * Let's flush node pages first to flush inline_data.
> +	 * We'll actually guarantee everything below under f2fs_lock_all.
> +	 */
> +	f2fs_sync_node_pages(sbi, &wbc, false, false, FS_CP_NODE_IO);

It is possible that user write a large number of inline data in between
f2fs_sync_node_pages() and f2fs_lock_all(), it will cause the no-space issue in
race condition.

Also, if there is huge number of F2FS_DIRTY_IMETA, after this change, we will
flush inode page twice which is unneeded.

f2fs_sync_node_pages() --- flush dirty inode page
f2fs_lock_all()
...
f2fs_sync_inode_meta() --- update dirty inode page
f2fs_sync_node_pages() --- flush dirty inode page again.

Thanks,

> +
>  retry_flush_quotas:
>  	f2fs_lock_all(sbi);
>  	if (__need_flush_quota(sbi)) {
> @@ -1222,7 +1228,8 @@ static int block_operations(struct f2fs_sb_info *sbi)
>  	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
>  		up_write(&sbi->node_write);
>  		atomic_inc(&sbi->wb_sync_req[NODE]);
> -		err = f2fs_sync_node_pages(sbi, &wbc, false, FS_CP_NODE_IO);
> +		err = f2fs_sync_node_pages(sbi, &wbc, false,
> +					true, FS_CP_NODE_IO);
>  		atomic_dec(&sbi->wb_sync_req[NODE]);
>  		if (err) {
>  			up_write(&sbi->node_change);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index d916540f12813..ac6ae42b9dd4e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3286,8 +3286,8 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>  			struct writeback_control *wbc, bool atomic,
>  			unsigned int *seq_id);
>  int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
> -			struct writeback_control *wbc,
> -			bool do_balance, enum iostat_type io_type);
> +		struct writeback_control *wbc,
> +		bool do_balance, bool sync, enum iostat_type io_type);
>  int f2fs_build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount);
>  bool f2fs_alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid);
>  void f2fs_alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid);
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 1db8cabf727ef..fd00a8c119088 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1808,8 +1808,8 @@ static bool flush_dirty_inode(struct page *page)
>  }
>  
>  int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
> -				struct writeback_control *wbc,
> -				bool do_balance, enum iostat_type io_type)
> +			struct writeback_control *wbc,
> +			bool do_balance, bool sync, enum iostat_type io_type)
>  {
>  	pgoff_t index;
>  	struct pagevec pvec;
> @@ -1870,8 +1870,8 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
>  				goto continue_unlock;
>  			}
>  
> -			/* flush inline_data */
> -			if (is_inline_node(page)) {
> +			/* flush inline_data, if it's async context. */
> +			if (!sync && is_inline_node(page)) {
>  				clear_inline_node(page);
>  				unlock_page(page);
>  				flush_inline_data(sbi, ino_of_node(page));
> @@ -1999,7 +1999,7 @@ static int f2fs_write_node_pages(struct address_space *mapping,
>  
>  	diff = nr_pages_to_write(sbi, NODE, wbc);
>  	blk_start_plug(&plug);
> -	f2fs_sync_node_pages(sbi, wbc, true, FS_NODE_IO);
> +	f2fs_sync_node_pages(sbi, wbc, true, false, FS_NODE_IO);
>  	blk_finish_plug(&plug);
>  	wbc->nr_to_write = max((long)0, wbc->nr_to_write - diff);
>  
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
