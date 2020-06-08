Return-Path: <SRS0=UwVw=7V=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04328C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  8 Jun 2020 02:59:05 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7BAF2067B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  8 Jun 2020 02:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="XX4YBX+x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="HHgBYoRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BAF2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ji808-0007pp-F7; Mon, 08 Jun 2020 02:59:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1ji807-0007pb-A6
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Jun 2020 02:59:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wSrNSjI1nVPcPhQx6yOMcy56IvJQhPtET4c3+Fpt4Ok=; b=XX4YBX+xBHRKEoycnBeCHTSmh2
 JxiGnznr67VXXAI4QI8XCCbv73b8azvtLZlzPptvSvuaaZJKvfqvvFzF91gZlI5fwRsm9pHsXPBFj
 gc2LjT4T3YcLUb9WVJL16Na3AEkaEXOPxt6TuElj/cydZtgKZlxnFrVtrp3CY7aHat+c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wSrNSjI1nVPcPhQx6yOMcy56IvJQhPtET4c3+Fpt4Ok=; b=HHgBYoRTg6GDCqbFnXJ36zZ4Er
 SRLjHsUEWNNPz1arnGIiE+szH92r67i24Hi+uWW1yYczqYBjnTSkZb0kU7r0GJQEkJjoL6IW2NNsJ
 RC14j2ee4PwYxPUHfiU5BESa49+2eoeN0gf7u30tCHjvYXsK3Z7yfoPgVWtfS/V8nsSY=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1ji804-00APzh-LA
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Jun 2020 02:59:03 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id D4266A8D4C9B446D8409;
 Mon,  8 Jun 2020 10:58:51 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 8 Jun 2020
 10:58:49 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20200605085453.45717-1-yuchao0@huawei.com>
 <20200607211748.GA26785@google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <025cde14-3b4e-b9db-d359-513a44e9c1a1@huawei.com>
Date: Mon, 8 Jun 2020 10:58:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200607211748.GA26785@google.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1ji804-00APzh-LA
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow writeback on error status
 filesystem
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

On 2020/6/8 5:17, Jaegeuk Kim wrote:
> On 06/05, Chao Yu wrote:
>>     71.07%     0.01%  kworker/u256:1+  [kernel.kallsyms]  [k] wb_writeback
>>             |
>>              --71.06%--wb_writeback
>>                        |
>>                        |--68.96%--__writeback_inodes_wb
>>                        |          |
>>                        |           --68.95%--writeback_sb_inodes
>>                        |                     |
>>                        |                     |--65.08%--__writeback_single_inode
>>                        |                     |          |
>>                        |                     |           --64.35%--do_writepages
>>                        |                     |                     |
>>                        |                     |                     |--59.83%--f2fs_write_node_pages
>>                        |                     |                     |          |
>>                        |                     |                     |           --59.74%--f2fs_sync_node_pages
>>                        |                     |                     |                     |
>>                        |                     |                     |                     |--27.91%--pagevec_lookup_range_tag
>>                        |                     |                     |                     |          |
>>                        |                     |                     |                     |           --27.90%--find_get_pages_range_tag
>>
>> If filesystem was injected w/ checkpoint errror, before umount, kworker
>> will always hold one core in order to writeback a large number of node
>> pages, that looks not reasonable, to avoid that, we can allow data/node
>> write in such case, since we can force all data/node writes with OPU mode,
>> and clear recovery flag on node, and checkpoint is not allowed as well,
>> so we don't need to worry about writeback's effect on data/node in
>> previous checkpoint, then with this way, it can decrease memory footprint
>> cost by node/data pages and avoid looping into data/node writeback
>> process.
> 
> This patch breaks fault injection test with filesystem corruption. Please check.

My bad, will check soon.

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/data.c | 19 ++++++++++++-------
>>  fs/f2fs/node.c |  7 +++++--
>>  2 files changed, 17 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 9d40db50cd65..2b3c846181bb 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -2519,6 +2519,8 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
>>  {
>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>  
>> +	if (unlikely(f2fs_cp_error(sbi)))
>> +		return true;
>>  	if (f2fs_lfs_mode(sbi))
>>  		return true;
>>  	if (S_ISDIR(inode->i_mode))
>> @@ -2702,13 +2704,16 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
>>  	/* we should bypass data pages to proceed the kworkder jobs */
>>  	if (unlikely(f2fs_cp_error(sbi))) {
>>  		mapping_set_error(page->mapping, -EIO);
>> -		/*
>> -		 * don't drop any dirty dentry pages for keeping lastest
>> -		 * directory structure.
>> -		 */
>> -		if (S_ISDIR(inode->i_mode))
>> -			goto redirty_out;
>> -		goto out;
>> +
>> +		if (has_not_enough_free_secs(sbi, 0, 0)) {
>> +			/*
>> +			 * don't drop any dirty dentry pages for keeping lastest
>> +			 * directory structure.
>> +			 */
>> +			if (S_ISDIR(inode->i_mode))
>> +				goto redirty_out;
>> +			goto out;
>> +		}
>>  	}
>>  
>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index 03e24df1c84f..372c04efad38 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -1527,7 +1527,10 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>>  			unlock_page(page);
>>  			return 0;
>>  		}
>> -		goto redirty_out;
>> +		if (has_not_enough_free_secs(sbi, 0, 0))
>> +			goto redirty_out;
>> +		set_fsync_mark(page, 0);
>> +		set_dentry_mark(page, 0);
>>  	}
>>  
>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>> @@ -1568,7 +1571,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>>  		goto redirty_out;
>>  	}
>>  
>> -	if (atomic && !test_opt(sbi, NOBARRIER))
>> +	if (atomic && !test_opt(sbi, NOBARRIER) && !f2fs_cp_error(sbi))
>>  		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
>>  
>>  	/* should add to global list before clearing PAGECACHE status */
>> -- 
>> 2.18.0.rc1
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
