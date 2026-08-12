Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96056C5CFDB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jbtwBrnCUfZd4RtdqALbRKDOJY1ioIlHzTU9w2e3bHI=; b=lwBB3h6KDwOxD2YseZdBQA+jMQ
	OW0gZ1vBULc3lGZU1cLTk4yNiUT8Rg4h+s0m9Q42i/ocEPtbvEH/+yX1j6OL5421y90IHdVq9CSUS
	/5W35FFGcWNtPli4W2CxkHcm+wFvaQYvSyhZnBXAG59v4zpZ2VZ6wEhmovw+c6dcRNy0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wu4ny-0003fs-GF;
	Wed, 12 Aug 2026 08:59:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wu4nx-0003fl-RW
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 08:59:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+sXSWsDHiGJ/oqKpPmE3usoB20L3uj2n6Y1Q/dywr44=; b=O4im2EkKs1qb4KznmcVl7MYVFx
 FLnlNhm+PsvVoOpUah9fH7UMizkSolxiN+OUDafMyMuuvO3BKB7UCXeIXDo/8uVtQkhPiBA0tpb4V
 lAHt2LLxmN03c6Gc63bBXTpZq+fxJnZa0Z48Nbi/D6IdAtoHYqA1fzs6RBXVFkawcfrg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+sXSWsDHiGJ/oqKpPmE3usoB20L3uj2n6Y1Q/dywr44=; b=NoyOfp62r/2S9LHyi3h85SbeER
 90kRqllBVWPvnEEA/v0yqYHo8itHMA0ZQUxoQvvclO/88uzI8ZBHd3LqV2ihtIx8MoGR6LX25srVa
 lEjPSTywBO52jHrybs28UMCjqLPR09ddWFsJOFGqMgf2J1UUg+pjKZ3In4FOmjM52RuA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wu4nx-0008FR-5U for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 08:59:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C77AC41416;
 Wed, 12 Aug 2026 08:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407111F000E9;
 Wed, 12 Aug 2026 08:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786525155;
 bh=+sXSWsDHiGJ/oqKpPmE3usoB20L3uj2n6Y1Q/dywr44=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=R9HmW+eFR5PvIAJfrs1UPVEPr83axuziR2Sndt6ibGVRubkp94sCD1CyyUmL0Jr0k
 ZvDZ2bPSuwqwGG1XH0JUjN3tPUhL+NeBgjBhkJ5wvzGqY2fLhEV81kvx/sGbFa9j+K
 TNT6ptG7m2k/2j4kBiI5ITRkhHGH97Y8FluPFncfvXmCJwOdCkzcCRbsqeg9EGBeX2
 NUqLV4MT3mTu3zSqNpavZxBZm1/eJ+tlQui5bsMDTqjIXOf+2qorTpKrLWXsr0Q3Mw
 elGq395mufPOy3dwjvP9J38wp0UKG1DcQWaRdYWH0vFh0dfl9b1ECnnP9twXPzaNf/
 z3mOuXoFufYlQ==
Message-ID: <5e5aa114-3425-4d26-a9c4-c21922eb67be@kernel.org>
Date: Wed, 12 Aug 2026 16:59:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260806061807.3267392-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260806061807.3267392-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wu4nx-0008FR-5U
Subject: Re: [f2fs-dev] [PATCH] f2fs: check cp_error before committing
 atomic writes
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: stable@kernel.org, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/6/26 14:18, Wenjie Qi wrote:
> F2FS checks cp_error before entering the ioctl path, but cp_error can be
> set after that and before atomic commit starts replacing blocks.
> 
> In that case, F2FS_IOC_COMMIT_ATOMIC_WRITE returns -EIO, but the current
> mount can still expose the new data before remount.
> 
> Check cp_error again in f2fs_commit_atomic_write() after
> filemap_write_and_wait_range() and before block replacement starts.
> 
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Cc: stable@kernel.org
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
>  fs/f2fs/segment.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> QEMU validation:
> - before fix, FAULT_CHECKPOINT made COMMIT_ATOMIC_WRITE fail with -EIO,
>   while the current mount still exposed the new data; after remount, the
>   file reverted to the old data.
> - after fix, the same fault still failed with -EIO, and both the current
>   mount and the remounted filesystem kept the old data.
> - no-fault smoke still committed the new data successfully and preserved it
>   across remount.
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 0b706568b034..e6384dd2e916 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -408,6 +408,9 @@ int f2fs_commit_atomic_write(struct inode *inode)
>  	if (err)
>  		return err;
>  
> +	if (unlikely(f2fs_cp_error(sbi)))
> +		return -EIO;

I suspect even we add cp_error in more places, we may suffer both conditions:
1) expose new data to userspace if cp_error occurs before f2fs_do_sync_file()
after f2fs_commit_atomic_write().
2) not expose new data to userspace if we cp_error occurs before or during
__f2fs_commit_atomic_write().

Thanks,

> +
>  	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
>  	f2fs_lock_op(sbi, &lc);
>  



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
