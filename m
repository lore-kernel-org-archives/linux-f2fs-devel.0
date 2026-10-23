Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80691606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Oct 2026 03:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Mf2lf67D;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OM6R6V1k;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IH/g6AzZ;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jowNzdSy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=fPztnpGR74SJClNsSNhtKG5rTH1fFPyrjCq6Ge8Hmvc=; b=Mf2lf67D5ckXJt
	ACT0gzVSY6CsReL1gkE5gcQnQCh15M5Qt9/bmy1y55wCwEmO/dqRKYtICXxvvG5l/p1jDqf4zYH3R
	dU9ZpOnvppWJ+bbN/q+ChaGew4g5rry6bgqd56fmuaas7a0KazxUsFB/uVbVw69JQDyBijBtff8EJ
	dLY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xK5YP-000000006ta-2Oxh;
	Fri, 23 Oct 2026 03:02:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xK5YO-000000006tK-0Gtb
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 03:02:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i2LKfdGda6ZY97Aypzo1toCAh7ibNeXqCUursQfhIhw=; b=OM6R6V1k1w4yjGGgb4rCAeHTQT
 bSKkakOSLYUYERHmS0nSVbnFDgGnUSwAxcGqJwUrNtffObnORwaPc6QAS9oZQggno+P2gJiSamkzu
 ak7Y4JX6LvNPYvKQ7IUb4ipQ9H5mcUyQmpYPWI0xMy0r6H7/C47gwhZmsAuHnzlWNKkA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i2LKfdGda6ZY97Aypzo1toCAh7ibNeXqCUursQfhIhw=; b=IH/g6AzZJ0+JRZQb8KwJTpJ4jM
 CnAsvxnVDkuZO4oUiX4NYUSbf/M6irM+N44cR0mVEScwIl3Wg/X7piRe5BvIinC2KkNAUbzR/CSb+
 pdiee9QrczbQHcAtNO4wH3wwaL8Q7I8bV/6qXIlqSwX2KaXBiwGSMj3xEeciFucXaxdM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xK5YM-000000006Ss-2T6t
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 03:02:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F162B63E6B;
 Fri, 23 Oct 2026 03:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E811F01825;
 Fri, 23 Oct 2026 03:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792724560;
 bh=i2LKfdGda6ZY97Aypzo1toCAh7ibNeXqCUursQfhIhw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=jowNzdSyxndERVt3YJ7D6GzpVNlFX/p45KKMps2uugPEUzG96kLDmFjSK9bivdZvL
 jmWGU5uzCy121SKbZgoE4NZ2uaf9oO0GVgf7FoDKjNGCZZloL0JaFlH5L5eawfi+Tb
 HWgF5gYrPadDlavikJIiofBcpGDOKe7mntnuWYSk538KbFofwabrfNz8qE0t2ft9eA
 YyClTCWY79DVS8TGXOn/8c3PSxV1nDGlvT2wMRgysUuvSna9iJ7G5UyR5NYud5bz9W
 TmCDj04qOUGkAcvar7WsaM+6zjvMpvT6L9Ltq/jHCshpGBymXusbW35yfMUwkk1WuN
 nS4OSdlaYC0WA==
Message-ID: <3617b48e-513f-418f-be0a-bf9d08d4ac60@kernel.org>
Date: Fri, 23 Oct 2026 11:02:37 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261023023118.3460118-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261023023118.3460118-1-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xK5YM-000000006Ss-2T6t
Subject: Re: [f2fs-dev] [PATCH] f2fs: flush devices when a sync checkpoint
 is skipped
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 10:31, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When fsync needs a checkpoint, f2fs_do_sync_file() writes and waits for
> the file data and then relies on the checkpoint to flush the device
> write caches. syncfs works the same way through f2fs_sync_fs(). But
> f2fs_write_checkpoint() skips a CP_SYNC or CP_FASTBOOT checkpoint
> without any flush when SBI_IS_DIRTY is clear.
> 
> That can happen even though the data was just written. A checkpoint
> does not wait for F2FS_WB_DATA writes, so another checkpoint can commit
> the new block addresses of the file while its data writes are still in
> flight, flush the devices before they complete, and clear SBI_IS_DIRTY.
> The checkpoint requested by fsync is then skipped, and fsync returns
> while the data may still be in a volatile write cache. After a power
> cut, the file points to blocks that were never persisted.
> 
> Flush the write caches of all devices when a sync checkpoint is skipped.
> 
> This was found by generic/455 with compression enabled for all files,
> where every fsync goes through a checkpoint. On a 4KB page kernel, 3 of
> 100 runs lost fsynced blocks without this patch and none of 100 runs did
> with it.

Seems we only find this issue on compressed file, can we fix compression
case only? If compression is disable, it will issue unnecessary preflush
during syncfs?

Maybe we can add a reference count to track writebacked compressed page.

- increase it during writeback
- decrease it in write_end_io
- in f2fs_write_checkpoint
  - skip if it's zero
  - otherwise, wait it to be zero & issue flush

Thoughts?

> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fs/f2fs/checkpoint.c | 18 ++++++++++++++----
>   fs/f2fs/f2fs.h       |  1 +
>   fs/f2fs/segment.c    | 17 +++++++++++++++++
>   3 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 1ed38c668fc..158d97fc349 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1973,10 +1973,20 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>   
>   	stat_cp_time(cpc, CP_TIME_LOCK);
>   
> -	if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
> -		((cpc->reason & CP_FASTBOOT) || (cpc->reason & CP_SYNC) ||
> -		((cpc->reason & CP_DISCARD) && !sbi->discard_blks)))
> -		goto out;
> +	if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY)) {
> +		if (cpc->reason & (CP_FASTBOOT | CP_SYNC)) {
> +			/*
> +			 * The data that fsync or syncfs waited for may have
> +			 * completed after the last checkpoint flushed the
> +			 * devices, and that checkpoint may already point to
> +			 * it, so flush the devices.
> +			 */
> +			err = f2fs_flush_all_devices(sbi);
> +			goto out;
> +		}
> +		if ((cpc->reason & CP_DISCARD) && !sbi->discard_blks)
> +			goto out;
> +	}
>   	if (unlikely(f2fs_cp_error(sbi))) {
>   		err = -EIO;
>   		goto out;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 1f9bd8e3b52..a4a38818988 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4265,6 +4265,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg);
>   int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino);
>   int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi);
>   int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
> +int f2fs_flush_all_devices(struct f2fs_sb_info *sbi);
>   void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free);
>   void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr,
>   						unsigned int len);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 06fb92fc847..5b015cf9071 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -822,6 +822,23 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
>   	return ret;
>   }
>   
> +/*
> + * Flush the write caches of all devices, regardless of which ones received
> + * writes since the last checkpoint.
> + */
> +int f2fs_flush_all_devices(struct f2fs_sb_info *sbi)

I guess there is an existing function f2fs_flush_device_cache(), I feel we'd
better reuse it to avoid missing any functionality inside it, right?

Thanks,

> +{
> +	int ret, i;
> +
> +	if (test_opt(sbi, NOBARRIER))
> +		return 0;
> +
> +	ret = __submit_flush_wait(sbi, sbi->sb->s_bdev);
> +	for (i = 1; !ret && i < sbi->s_ndevs; i++)
> +		ret = __submit_flush_wait(sbi, FDEV(i).bdev);
> +	return ret;
> +}
> +
>   static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
>   		enum dirty_type dirty_type)
>   {



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
