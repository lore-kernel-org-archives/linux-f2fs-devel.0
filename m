Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC012606A326
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 03:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GA/XYr4L;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gJ8ymutH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=A5iunJJZ;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1cQ0jYL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=NXJGJ3Qpv4tiwE2su9IjjnhY+PrN0yjNA5jGkiSmBj4=; b=GA/XYr4LTVYOJ+
	oaANE3WL9md0tXGC1PqqkHucLeoFwRK7q6/AvaH3DKLHZfOREQUlprIj3y9zHgNb2x4UPqg9TtXpV
	lVWWh0716TJuMJciu/SmM4g2ktMkTkIRUtH/6N9ND3P2577NiUBwBuyN8FIWHCrvZNXtJrTN3ELsw
	mmo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNiN1-000000007RF-2o5A;
	Mon, 02 Nov 2026 03:06:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xNiN0-000000007R9-2cfy
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 03:06:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A/6+kBlzwlsk4cBSFQS9p/QrJg3Xfn4u3eXyo65yo88=; b=gJ8ymutHpJy6i0aF0MWSJ5RVYk
 kt6/DD/4YdUcLIVjQxPKuUdug60oh87bWBnR5o5iI6nNkKXJ+3zuKn+hqKeIpfp4R6lV6X0SzcyVU
 4HpPI5iEtTTPtMEY0SKCsk7K1gHVcQecU6teRmcE/ApUuQTzGrIT+TKXRb7KQfoFvR8g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A/6+kBlzwlsk4cBSFQS9p/QrJg3Xfn4u3eXyo65yo88=; b=A5iunJJZRq6w+PuBzq0FCmhe9Z
 t4yuMZsUSGtXaydKFjxgqMxqM6LoaHs+ISqd9POVrp7xff15nmiwD6LhYjSvo0j/1zGFGw/Gd1/5C
 m1idJs6BEFd0kpa7yP5rDvSj9Vj8Bt1fjXWSNmVQyKyfQ5SJWkXniI/1Lgy6gnzwFi98=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNiMz-000000008Pq-2Zf2
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 03:06:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3193A42DBB;
 Mon,  2 Nov 2026 03:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C8B1F000C1;
 Mon,  2 Nov 2026 03:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793588756;
 bh=A/6+kBlzwlsk4cBSFQS9p/QrJg3Xfn4u3eXyo65yo88=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=f1cQ0jYLxgvvEoDciMRRhDMuwurH6cNVfo+3zRDujWLmtMTfKd1TyH4SDkP7YZdth
 /SoTpOxmAPxtH6/p0+WK23cH/2/GLseCKUvlqDjsv4aMAwOQJ4pSAAgLOd/BVL+cLu
 30XbMM9spPAaNkVtgh/ZxhsthhZYCWlYY4O3c4dRMn8eSg5Lnn/Xb6CWEF+e62zp3H
 1Q/7PItcpwYizNCvRMLH3TB1bFtN3LObFsgSN80XAP8WrC4/pDtHDLGJBWabMiyGwP
 YuhRmudJq4I2m+4nn6f9Nm8pWsXfvyydYh4Yj5N53UG4AitZ8HDgIgH0Mdy5pzeIkt
 rl9jKhKC+m1mA==
Message-ID: <6b95dd7b-4e49-4c7d-a3d2-70341e183289@kernel.org>
Date: Mon, 2 Nov 2026 11:05:52 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261030111112.20953-1-Dmitry.Chumachenko@cyberprotect.ru>
Content-Language: en-US
In-Reply-To: <20261030111112.20953-1-Dmitry.Chumachenko@cyberprotect.ru>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNiMz-000000008Pq-2Zf2
Subject: Re: [f2fs-dev] [PATCH] f2fs: reject mount when block_count exceeds
 device capacity
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
Cc: lvc-project@linuxtesting.org,
 syzbot+8b85865808c8908a0d8c@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 19:11, Dmitriy Chumachenko wrote:
> During fuzz testing, the following issue was discovered.
> 
> INFO: task kworker/u9:2:981 blocked for more than 122 seconds.
>        Not tainted 7.1.0-rc4-00103-ge94869f14310 #59
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u9:2    state:D stack:25800 pid:981   tgid:981   ppid:2      task_flags:0x4208060 flags:0x00080000
> Workqueue: writeback wb_workfn (flush-7:0)
> Call Trace:
>   <TASK>
>   __schedule+0x122f/0x6530
>   rt_mutex_schedule+0x96/0xe0
>   __rt_mutex_slowlock_locked.constprop.0+0x13bd/0x3280
>   rwbase_write_lock+0x5df/0x720
>   f2fs_down_write_trace+0xc8/0x320
>   f2fs_balance_fs+0x6ee/0xa50
>   f2fs_write_inode+0x5e4/0x15a0
>   __writeback_single_inode+0xcda/0x1360
>   writeback_sb_inodes+0x767/0x1d90
>   __writeback_inodes_wb+0xf8/0x2d0
>   wb_writeback+0x723/0xb90
>   wb_workfn+0x8e6/0xc10
>   process_one_work+0xa0e/0x1980
>   worker_thread+0x5ef/0xe50
>   kthread+0x370/0x450
>   ret_from_fork+0x72b/0xd50
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
> 
> The superblock declares a block_count larger than the backing device, but
> sanity_check_raw_super() validates block_count only against segment_count
> and never against the device size, so the oversized filesystem mounts and
> its main area extends past the end of the device.
> 
> On the first fallocate(), f2fs_balance_fs() runs foreground GC, which
> selects a victim segment located beyond the device. The blocks are valid
> per on-disk metadata, so is_alive() accepts them and do_garbage_collect()
> keeps issuing reads past the end of the device without making progress,
> while holding sbi->gc_lock. Writeback and sync then block on gc_lock
> indefinitely, producing the hung task above.
> 
> This only affects single-device setups: on a multi-device volume
> block_count is the whole-filesystem total and legitimately exceeds the
> primary device, so the check is restricted to single-device images and
> compares block_count against the backing device capacity.
> 
> Fixes: aff063e266cb ("f2fs: add super block operations")
> Reported-by: syzbot+8b85865808c8908a0d8c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
> Signed-off-by: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
> ---
>   fs/f2fs/super.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index fabcafafabf1..ba484a32f292 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3445,6 +3445,13 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>   			  segment_count, le64_to_cpu(raw_super->block_count));
>   		return -EFSCORRUPTED;
>   	}
> +	if (!RDEV(0).path[0] &&

It needs to cover multiple device case as well? can you please do that?

> +	    le64_to_cpu(raw_super->block_count) > sb_bdev_nr_blocks(sbi->sb)) {

static inline u64 sb_bdev_nr_blocks(struct super_block *sb)
{
	return bdev_nr_sectors(sb->s_bdev) >>
		(sb->s_blocksize_bits - SECTOR_SHIFT);
}

- f2fs_fill_super
  - read_raw_super_block
   - sanity_check_raw_super
    - sb_bdev_nr_blocks
    : access s_blocksize_bits
  - sb_set_blocksize
  : update s_blocksize_bits

So, update like this?

	u64 dev_blocks = bdev_nr_bytes(sbi->sb->s_bdev) >>
			le32_to_cpu(raw_super->log_blocksize);

	if (le64_to_cpu(raw_super->block_count) > dev_blocks) {
		f2fs_info(sbi, "block_count (%llu) exceeds device size (%llu blocks)",
		le64_to_cpu(raw_super->block_count), dev_blocks);
		return -EFSCORRUPTED;
	}

Thanks,

> +		f2fs_info(sbi, "block_count(%llu) exceeds device capacity(%llu blocks)",
> +			  le64_to_cpu(raw_super->block_count),
> +			  (unsigned long long)sb_bdev_nr_blocks(sbi->sb));
> +		return -EFSCORRUPTED;
> +	}
>   
>   	if (RDEV(0).path[0]) {
>   		block_t dev_seg_count = le32_to_cpu(RDEV(0).total_segments);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
