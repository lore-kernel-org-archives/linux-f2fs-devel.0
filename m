Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55615606A31D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Oct 2026 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=P4qXP6VU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jolb1AGg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Y7dJjbTL;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJ6/Q1/T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nVdO0uW+u0SAdVMwmVpAJIfNmz6jChiwPXVl39LuVmQ=; b=P4qXP6VUg4eJkM
	R5oxOWrOPVDmW+TAL1eiuWjjRyFNpRIty6fu0RqJ6JeD77Ssx2EIBv/DXrTv5Dx0pe2b/nTDRcYVo
	MwbE/5OzGYbMBGujnBb74noM+NeFeMJinRcjWhIvZ0hJG9g3ddqD/ZRXEpwyHl7gO6dE+6393dZFC
	DV8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLz5H-000000001ij-1EZn;
	Wed, 28 Oct 2026 08:32:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xLz51-000000001iR-39qQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 08:32:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WOvYHaDnwhLnDAkmJn59wu8Bjgkafm+4E2jvkhnkGRI=; b=jolb1AGgyjQnSQt1qrwhFDIp7w
 rg5qg99p5NIl8W680V1BjXvwpV/+98Etx72qZjBumgTXuKC5YeM/9JARhZUXFMQq4H9b56l2M5z2P
 vmnBGQWC/+cmzMn2PvWZ/7JM42zD8RGoN63ESCIq7mPZi4oybd8LQwCf3bxq5GkANVjo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WOvYHaDnwhLnDAkmJn59wu8Bjgkafm+4E2jvkhnkGRI=; b=Y7dJjbTLoB3XlIulwPOii+sJSt
 tqWJUMv41iO/kORp1Mt7qzH6URvN4r5CTd5GRoBL8AacUE8vto1I16P6rQn1DIJ8HCw6WoDVWG8gb
 uqyNe0Tk7oPo5z1AsAgIJMfXHxcA/dDVTCtpzfAd071usIWg6ZIsI2MXhujdAqun0gZY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLz50-000000006cQ-1Iv5
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 08:32:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B22ED601F0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 08:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B9A1F01825;
 Wed, 28 Oct 2026 08:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793176332;
 bh=WOvYHaDnwhLnDAkmJn59wu8Bjgkafm+4E2jvkhnkGRI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=DJ6/Q1/TMQusKRba6JRQAmK/vGoD7Aq5ZUlXIHhKNIiOjhr5mxX/E/LeY+vGAKSiR
 lheGxAmIntZkP34nyX86Doj8soYtVeYzDC4Ka6JTNHWnsvW26gJ1fJ2zG5cplMARQ3
 szR0fAw7kYGYOkXYgaf8treeLqYV6FddoL6cC9E5GiGtuWTQ7DofbCN2n7eCjKnbY2
 T0fW0434arHFE9MM39FwBQNFNteHS4zYZjyryAf0zsFUnrSgPlc7GKt95ByHCCSIaO
 AkPjayxpb2+C4FjzuDovaUgoGlu0mKBF0gM3fAVZN+0Zj5ySptJH6F40UJc34XcaMt
 TUe+vWuOvZFsw==
Message-ID: <c87b011c-08fa-4e65-8b22-a6bf5a2efd5a@kernel.org>
Date: Wed, 28 Oct 2026 16:32:09 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20261028050615.259268-1-jaegeuk@kernel.org>
Content-Language: en-US
In-Reply-To: <20261028050615.259268-1-jaegeuk@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLz50-000000006cQ-1Iv5
Subject: Re: [f2fs-dev] [PATCH] f2fs: do f2fs_zero_post_eof_page for all the
 time
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
Cc: stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 13:06, Jaegeuk Kim via Linux-f2fs-devel wrote:
> This fixes xfstests/generic/794, since the issue is not related to the
> posix=strict mode only.

Jaegeuk,

Actually, I fixed this only in fsync_mode=strict because I don't see such
scenario (described in original patch) in Android:

    Steps of generic/794:
    1. write 4096 bytes to file w/ 0x5a
    2. use fiemap to get PBA of first block in file
    3. truncate file to 4080
    4. umount; write 4096 bytes to file w/ 0x5a directly via PBA; mount
    5. extend filesize via
       a) append 4096 from offset 4096, or
       b) truncate 8192, or
       c) fallocate 4096 from offset 4096
    6. verify the gap is zeroed in memory [4080,4096)
    7. sync range 4096 from offset 4096; shutdown -f (flush meta before shutdown)
    8. umount; mount; verify [4080,4096) is zeroed or not.

Maybe we should only enable fsync_mode=strict for 794 to let it pass?

Thanks,

> 
> Cc: stable@kernel.org
> Fixes: 5eced87b7d19 ("f2fs: fix to zero post-EOF data when extending file size")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 8b4a7a9d7dbe..823df06ae0f2 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -74,15 +74,10 @@ static int f2fs_zero_post_eof_page(struct inode *inode,
>  					loff_t new_size, bool lock, bool writeback)
>  {
>  	loff_t old_size = i_size_read(inode);
> -	bool strict =
> -		F2FS_OPTION(F2FS_I_SB(inode)).fsync_mode == FSYNC_MODE_STRICT;
>  
>  	if (old_size >= new_size)
>  		return 0;
>  
> -	if (!strict && mapping_empty(inode->i_mapping))
> -		return 0;
> -
>  	if (lock)
>  		filemap_invalidate_lock(inode->i_mapping);
>  	/* zero or drop pages only in range of [old_size, new_size] */
> @@ -90,14 +85,9 @@ static int f2fs_zero_post_eof_page(struct inode *inode,
>  	if (lock)
>  		filemap_invalidate_unlock(inode->i_mapping);
>  
> -	if (!writeback || !strict)
> +	if (!writeback)
>  		return 0;
> -	/*
> -	 * In fsync_mode=strict, when we expand an unaligned EOF size, we
> -	 * should zero post EOF data and writeback the data immediately,
> -	 * so that it can avoid exposing stale data after metadata flush
> -	 * and POR.
> -	 */
> +
>  	return do_zero_post_eof_page(inode, new_size);
>  }
>  



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
