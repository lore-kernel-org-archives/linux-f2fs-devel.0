Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BDDCA5FED
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 09:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QSE7Jg+XsHNs9vOMPvt6INP49BF3HLnpijbD+aCbhLw=; b=Xn9gPoK2ZqTJcVqqcuWWLKhn1D
	MLofRnxqAWgUdeEOWmSJE6UGnurtUqdrfTEZCbh2gWlUxGdIGaWDvtVNmIAHPB5sGKvs5IjtZCIv7
	gT89NQbgY/P9dq+fYXebEDagr112YO7KiDhnkc5YiACfHV6+1Cgj2LYFSmfr+5+9xK1M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xF6W6-00037J-Cl;
	Fri, 09 Oct 2026 09:03:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xF6Vo-00035o-3E
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 09:03:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ke1OKsIbzF21VRYo2cmF8OlO/VOMA3LWhBS8fov9rNM=; b=HJD/sReO+cyzbT89BaiX61qH1h
 qR0g4lqrQ1uU2PgNDkLv83JLJB+hLmMrv9ytlLTsbWcxRaJV3OW8xp7g4d4H2+GBO1AY5K+66gJnl
 /nLFqxB4FoOKQA2vQ4fhlOzwxcpf7lmtbWt8pFfvPfCzGPl3Lp8rJGiQjb6E0ZX3z2Hs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ke1OKsIbzF21VRYo2cmF8OlO/VOMA3LWhBS8fov9rNM=; b=BlSL9x5rBmXUmN6q3AXOw8CEFN
 QKgcyMa6QHfkmhwz6EpWcdqopwxf15i//QAheI38HBB6zTPANxvvsN77dUntxcbpNwFkXN19LxsW3
 wUiY5U7tThdvaqPaFCycSPCuAzFHprjLeNFZUZo/FsbF/b0u3irrnaj0sZQih4/ZYNMA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xF6Vo-0002VL-Dd for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 09:03:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C1169601F9;
 Fri,  9 Oct 2026 09:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2CA1F000FF;
 Fri,  9 Oct 2026 09:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791536606;
 bh=Ke1OKsIbzF21VRYo2cmF8OlO/VOMA3LWhBS8fov9rNM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=SsJz4rSSxdBYy7fLgwh/Yuy/htYyNdJKnqB7xVGLNwQhSiUsbgYugIxkYJvluCWwE
 Ah5WZ2VC+DDOQXV44rmV+3jK1+5fxyvhUgXvLv5kE6ES16v+ult4XNuUqdtoye7ebE
 yU3R4MCHfC0bIJP1TOjVZo3O47+6wOV36pBIVxRrf8kSF0S59sWyoO41EqxNlT+Inq
 tGAmjaim0t6tJDqNmbS7+pu99qfTteTcCQkSVMfsfgXalbGle/A5qAhIW4zEiO7wTh
 Tj/BHYeZxbGBUADrHW2ApubIr6l0wfODbdpAcTX0sPxLgVra6p3/GaIY+9Ew0sISNP
 Onl6Af3YHlPKQ==
Message-ID: <411bd479-f3ba-48cd-9b96-ec017c685b1c@kernel.org>
Date: Fri, 9 Oct 2026 17:03:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261007223608.2158904-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261007223608.2158904-1-daeho43@gmail.com>
X-Headers-End: 1xF6Vo-0002VL-Dd
Subject: Re: [f2fs-dev] [PATCH] f2fs: write the directory inode in fsync
 before checkpoint
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/8/26 06:36, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> fsync() on a directory is done by a checkpoint, but the checkpoint
> does not write timestamp-only inode updates. Since commit 7c45729a4d6d
> ("f2fs: keep dirty inodes selectively for checkpoint"), such updates
> are marked with sync=false and left to inode writeback on purpose.
> 
> fsync() on a regular file calls f2fs_write_inode() first when the
> inode is dirty, but fsync() on a directory goes to the checkpoint
> directly and misses it. So if the last change to a directory only
> updated its timestamps, e.g. unlinking a file in it, the new mtime is
> lost after a sudden power off even though fsync() returned. generic/547
> fails sometimes because of this.

Has 9ec09d5f4b31 ("f2fs: dirty directory inodes on mtime/ctime update") fixed
this issue?

Thanks,

> 
> Call f2fs_write_inode() for a directory before the checkpoint, as the
> regular file path does. The inode block becomes dirty and is written by
> the same checkpoint, so no extra checkpoint or flush is added.
> Timestamp-only updates without fsync() are still not written by the
> checkpoint.
> 
> Fixes: 7c45729a4d6d ("f2fs: keep dirty inodes selectively for checkpoint")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/file.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 56c686b8580..b012cc22307 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -351,8 +351,15 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>  
>  	trace_f2fs_sync_file_enter(inode);
>  
> -	if (S_ISDIR(inode->i_mode))
> +	if (S_ISDIR(inode->i_mode)) {
> +		/*
> +		 * Checkpoint writes only the inodes on the dirty meta list.
> +		 * Timestamp updates of a directory, e.g. by unlinking a file
> +		 * in it, do not put it on the list, so write it here.
> +		 */
> +		f2fs_write_inode(inode, NULL);
>  		goto go_write;
> +	}
>  
>  	/* if fdatasync is triggered, let's do in-place-update */
>  	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
