Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C94DFED2C7
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Mar 2026 04:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WkQ+zXIgPIN3GFt3kyeq5VNuL9bXfd3FwciYOEOruCM=; b=hJHVDeNdamraSnBLzvEIoPVG57
	Eg+nCjmfK4MkuhpYIcSE8Q8bZMcpFskgLVbB5cFqGZ5uUkuUWASPT6XCJ1P2wT/Q5rXixJ0vGLTtb
	nMsrzn1H90uJIGhcW6GFigqx62gkR27hhur9QZthMOcPnFTybcWb/+pFuVDar7eY1k5I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w0XEd-0002XX-JN;
	Thu, 12 Mar 2026 04:01:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1w0XEb-0002XO-MH
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Mar 2026 04:01:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IN832UNHaqomZ/amiGnFFTvu+0SD2c4efPrqbG6lSRw=; b=fz6Vn04L7vCq8bE/qGLvUEfTkx
 RJqX+sLlZEoccpoLMZ82UqEQ0iTQPuwTCRvMXKkIFvjfePDr4giUo9yBO5xzX8+OI2hLu14vedujD
 /bkfyVtcdOgGgJcyRgFO12heVRTmePTJS9dEB4sGRc5h3G1lof1icn1OKvYX3bVw/OBw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IN832UNHaqomZ/amiGnFFTvu+0SD2c4efPrqbG6lSRw=; b=KUoGV+PxzmQtMQ5l2Z5iczzjdN
 KSLfXBcOGQlIvwVwYoY+70LBnad6Y7xo7SiSFa2ZUGj1spx9a3tEvZGvkE4qyUPjQaSeq4ajOf5GU
 h3ub7sI6yiBYPp5vogeXIKCyLVEcsEA39hhkimeGWWpMTN/qqFxNvKxxZ234Zu7B0NLw=;
Received: from r3-21.sinamail.sina.com.cn ([202.108.3.21])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w0XEa-0001rM-HY for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Mar 2026 04:01:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1773288076; bh=IN832UNHaqomZ/amiGnFFTvu+0SD2c4efPrqbG6lSRw=;
 h=Message-ID:Date:Subject:From;
 b=ZAvXPmOHwcbOY8exmPbfxXsrlm/NS9L6OgwEBIKcvsdOin8R9ibgmNaPKlwtMF5TL
 DHGfZ6C8aailGG/YPc0BtwejxLqs+04Im/sw1TaApGM0LA92L9sW64q9YfL3jk+qnW
 D0/dNbXLsWIkhz8ZLtkJlObRBezdDnF/Jjkk1+y0=
X-SMAIL-HELO: [10.189.138.37]
Received: from unknown (HELO [10.189.138.37])([114.247.175.249])
 by sina.com (10.54.253.33) with ESMTP
 id 69B23A7C0000790D; Thu, 12 Mar 2026 12:01:02 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 5697676684964
X-SMAIL-UIID: 0EDAB2443764461388F26A43E976E3C6-20260312-120102-1
Message-ID: <2164119b-e960-4362-bb6c-9f83e382f12d@sina.com>
Date: Thu, 12 Mar 2026 12:01:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260310093611.2865092-2-monty_pavel@sina.com>
 <20260310093611.2865092-4-monty_pavel@sina.com> <abGxmcBNlSgEwh5z@google.com>
Content-Language: en-US
From: Yongpeng Yang <monty_pavel@sina.com>
In-Reply-To: <abGxmcBNlSgEwh5z@google.com>
X-Headers-End: 1w0XEa-0001rM-HY
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix fsck inconsistency caused by
 incorrect nat_entry flag usage
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 3/12/26 02:16, Jaegeuk Kim via Linux-f2fs-devel wrote:
> On 03/10, Yongpeng Yang wrote:
>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>
>> f2fs_need_dentry_mark() reads nat_entry flags without mutual exclusion
>> with the checkpoint path, which can result in an incorrect inode block
>> marking state. The scenario is as follows:
>>
>> create & write & fsync 'file A'                 write checkpoint
>> - f2fs_do_sync_file // inline inode
>>  - f2fs_write_inode // inode folio is dirty
>>                                                 - f2fs_write_checkpoint
>>                                                  - f2fs_flush_merged_writes
>>                                                  - f2fs_sync_node_pages
>>  - f2fs_fsync_node_pages // no dirty node
>>  - f2fs_need_inode_block_update // return true
>>  - f2fs_fsync_node_pages // inode dirtied
>>   - f2fs_need_dentry_mark //return true
>>                                                  - f2fs_flush_nat_entries
>>                                                 - f2fs_write_checkpoint end
>>   - __write_node_folio // inode with DENT_BIT_SHIFT set
>>   SPO, "fsck --dry-run" find inode has already checkpointed but still
>>   with DENT_BIT_SHIFT set
>>
>> The state observed by f2fs_need_dentry_mark() can differ from the state
>> observed in __write_node_folio() after acquiring sbi->node_write. The
>> root cause is that the semantics of IS_CHECKPOINTED and
>> HAS_FSYNCED_INODE are only guaranteed after the checkpoint write has
>> fully completed.
>>
>> This patch moves set_dentry_mark() into __write_node_folio() and
>> protects it with the sbi->node_write lock.
>>
>> Fixes: 88bd02c9472a ("f2fs: fix conditions to remain recovery information in f2fs_sync_file")
>> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
>> ---
>>  fs/f2fs/node.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index 2fbfecaf3f7b..7d3b377cbc17 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -1807,7 +1807,9 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool *submitted
>>  		if (IS_INODE(folio))
>>  			set_dentry_mark(folio,
>>  				f2fs_need_dentry_mark(sbi, ino_of_node(folio)));
>> -	}
>> +	} else if (IS_INODE(folio) && is_fsync_dnode(folio))
>> +		set_dentry_mark(folio,
>> +				f2fs_need_dentry_mark(sbi, ino_of_node(folio)));
> 
> Thanks, I applied with some clean-up as below. Could you please review this?
> 
> -       if (atomic) {
> -               if (!test_opt(sbi, NOBARRIER))
> -                       fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
> -               if (IS_INODE(folio))
> -                       set_dentry_mark(folio,
> +       if (atomic && !test_opt(sbi, NOBARRIER))
> +               fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
> +
> +       if (IS_INODE(folio) && (atomic || is_fsync_dnode(folio)))
> +               set_dentry_mark(folio,
>                                 f2fs_need_dentry_mark(sbi, ino_of_node(folio)));
> -       }
> 
> 

This looks good to me.

Thanks
Yongpeng,

>>  
>>  	/* should add to global list before clearing PAGECACHE status */
>>  	if (f2fs_in_warm_node_list(folio)) {
>> @@ -1948,9 +1950,6 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>>  					if (is_inode_flag_set(inode,
>>  								FI_DIRTY_INODE))
>>  						f2fs_update_inode(inode, folio);
>> -					if (!atomic)
>> -						set_dentry_mark(folio,
>> -							f2fs_need_dentry_mark(sbi, ino));
>>  				}
>>  				/* may be written by other thread */
>>  				if (!folio_test_dirty(folio))
>> -- 
>> 2.43.0
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
