Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151A2C27C79
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Jun 2024 01:32:47 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sJNiH-0003nA-J0;
	Tue, 18 Jun 2024 01:32:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sJNiG-0003mz-UC
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Jun 2024 01:32:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jx1kYu9EnSa8FMLby7qZ2OhMz24AjhOQNIy6YETZ4BU=; b=NEVIXCTbN3hXqTynLNNqOPq33x
 7AGCGdBLogJ4q5jV15NqC64J63eImNPeJ0hp68QBe7LvTgCKo8Z50GkegByKtnvQ7dK+g10PnlnwC
 jJUPfiHdLHNQhc2NXXkAi61SXIrCxeIlPWlcjRBnZbFbCOvGLVDxRcyDnTkJJs5voCvo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Jx1kYu9EnSa8FMLby7qZ2OhMz24AjhOQNIy6YETZ4BU=; b=bzXguofYDjlzNv2m3w5K9QbsAN
 e51ydrmrWGeSXYH0Fuw0slLY9SHBcPe0DMGgDI7QFZk/xiNNDlqwS5lqBRglQxO7gqda2s0Mq0Miq
 7grO3H6QLHwLbHcsLfEWuKI/mRVFoXgbteR2hTH3y2Fq/gOyIrJCe+N4udh2GPkADCdE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sJNiH-00081f-9c for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Jun 2024 01:32:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1E08C6114A;
 Tue, 18 Jun 2024 01:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF03C2BD10;
 Tue, 18 Jun 2024 01:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718674353;
 bh=jCcC8O9GikAMAzOXCaevpDrR8jemL1iMRiW0Iv8WIDQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ruycVCjQBEbzTgFc01siOfW6TSu6KA4uPY61nNBr1ml1rfbpf+FqUJdJMk1pg3111
 zqnTLyHszo5NUbXg1S9n5/NuyZZS3wWgczbO1HAFSmXZcO25Zv9g4ACEVYCZxiVx5k
 W2O2V9JgdA8Gd0kHd3XTY/eAVa5gPKgoIrnx6kzma3GBcTZzRImc7DUFV+rJnoQWJa
 vZ/mHjB3RdlaJco/3HMBdIX9NWl3p6MVCmsl5a4Z08B5a39b9g7G3ddZQ8iUTFrTlq
 HWHDH0aLHYMrQ51eibE9N6xj9Ys7s3MTzPO+5mXvh5GDUCtbarw9iCEZuKnCyI9fPH
 F+7Jy+gcLoy7w==
Message-ID: <4a79eea2-e360-493d-8c98-d93aacbd4d00@kernel.org>
Date: Tue, 18 Jun 2024 09:32:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jtp.park@samsung.com, Jaegeuk Kim <jaegeuk@kernel.org>
References: <CGME20240611234050epcas2p40bd72d91c6a7b67e411a5ebfcddbcb97@epcas2p4.samsung.com>
 <20240611233906.2873639-1-jtp.park@samsung.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240611233906.2873639-1-jtp.park@samsung.com>
X-Headers-End: 1sJNiH-00081f-9c
Subject: Re: [f2fs-dev] [PATCH] f2fs: add scope based f2fs_putname() cleanup
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
Cc: Jeongtae Park <jeongtae.park@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/6/12 7:39, jtp.park@samsung.com wrote:
> From: Jeongtae Park <jtp.park@samsung.com>
> 
> This patch adds a new scope based f2fs_putname() cleanup to reduce
> the chances of forgetting a f2fs_putname(). And doing so removes

Actually, f2fs_trace_rw_file_path() won't change frequently, so the risk
of forgetting f2fs_putname() here is very low.

> a goto statement for error handling.

The code logic is fine to me, but not sure whether we should apply this.

Jaegeuk, any comments?

Thanks,

> 
> Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
> ---
>   fs/f2fs/f2fs.h | 2 ++
>   fs/f2fs/file.c | 8 +++-----
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 1974b6aff397..284024c12ee5 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3402,6 +3402,8 @@ static inline void f2fs_putname(char *buf)
>   	__putname(buf);
>   }
>   
> +DEFINE_FREE(f2fs_putname, void *, if (_T) f2fs_putname(_T))
> +
>   static inline void *f2fs_kzalloc(struct f2fs_sb_info *sbi,
>   					size_t size, gfp_t flags)
>   {
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 5c0b281a70f3..c783d017ed28 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4511,22 +4511,20 @@ static void f2fs_trace_rw_file_path(struct file *file, loff_t pos, size_t count,
>   				    int rw)
>   {
>   	struct inode *inode = file_inode(file);
> -	char *buf, *path;
> +	char *buf __free(f2fs_putname) = f2fs_getname(F2FS_I_SB(inode));
> +	char *path;
>   
> -	buf = f2fs_getname(F2FS_I_SB(inode));
>   	if (!buf)
>   		return;
>   	path = dentry_path_raw(file_dentry(file), buf, PATH_MAX);
>   	if (IS_ERR(path))
> -		goto free_buf;
> +		return;
>   	if (rw == WRITE)
>   		trace_f2fs_datawrite_start(inode, pos, count,
>   				current->pid, path, current->comm);
>   	else
>   		trace_f2fs_dataread_start(inode, pos, count,
>   				current->pid, path, current->comm);
> -free_buf:
> -	f2fs_putname(buf);
>   }
>   
>   static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
