Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AF3CA6017
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 10 Oct 2026 07:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IGXVZEr2iqmtpNrowYbAjgezJPnKPRD5r9gDW1k3S4A=; b=KSw9K/Wswl9TAjC5WxWjFGhrMF
	v0JujHMAhm6WQIy99/2f3NJsyuRJm+N7ZFdxrM75aTGEt/FLeTnF3dKflGFDgmQH0+oEUfAMAxJej
	+78IrGcQVDhcHQHN5JgTqx7rtR0qjnbFQAqR6OfD85StwltfFVv0XShI/b5wy6xjpoik=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFRe5-0003Li-2f;
	Sat, 10 Oct 2026 07:37:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xFRe3-0003Lc-LU
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 07:37:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5XbZZqJRmmZ/LFvu5kMHlzZA0oahdFNUV1rYwMv2suY=; b=Gl0S/m2OfPXXM22BGKGO9zVKPJ
 RRV4oVJwNP/n3RYK3AOcf3c5OSdmqmU4MUER9jlIV1quhviBKC9ZyxtS7uLJcp4E4M0il0qlnz4oD
 qS7MggEYoCwZKPsdM+i2MMdnXBFkoXgy9KXeRXhOARQPk9cd/LFE4xicUnnGrGU//Qxs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5XbZZqJRmmZ/LFvu5kMHlzZA0oahdFNUV1rYwMv2suY=; b=YLPkDI8inCcqwP/2a7gXyhlEiM
 sbTboxNrXRcDmh0uW4AVcsXj1XvJSPY0ZVBsnhuMVAghFhTdjPL7fvGn8zC5g475OeM0vNmfGWIHj
 XxcJIu1MlzlQXjv5G76ecae0yBkv41N61oG7LEUKUrVpVsRLTklIm8KcfygIc0OMlSkU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFRe2-00039q-Od for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 07:37:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D696601F0;
 Sat, 10 Oct 2026 07:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62B71F000FF;
 Sat, 10 Oct 2026 07:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791617840;
 bh=5XbZZqJRmmZ/LFvu5kMHlzZA0oahdFNUV1rYwMv2suY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=b1VjOGHi4EjnwFrW/B2RnJd/v5fcIr6As2XRK1F7oYNTUCddi6wjdJ6awrLpLNvjk
 7Q8jnI8EqbALMHQ5gAh6ARozGS8/jWEGMj4WqygcR55GvRewjXDghypOTQgBbWH7kP
 N70Mj3ADwOjyjzh/8JX10PySrPcaQSlyhdJTmc3+Kib5Vncl24jFNEDKs7U0AxqeKN
 bXeb01qId1WUP6bpU4DhP5yfDhHMDhJJ7C/pKqZET6tgpqwG6euNq/C2zbJ9g4mSnd
 TpW67NFlvo+KqazMZmZvkeuF2cqMCwWMFc+mTxP/Of8Qsb3FmrI6xW3Dtvor5B6P+r
 hvWjNRZTA5nuw==
Message-ID: <99957074-c89a-44c4-a86d-f65e7dc85024@kernel.org>
Date: Sat, 10 Oct 2026 15:37:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261010024133.2444761-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261010024133.2444761-1-daeho43@gmail.com>
X-Headers-End: 1xFRe2-00039q-Od
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: disallow mmap write and
 data-modifying fallocate on atomic files
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
Cc: Daeho Jeong <daehojeong@google.com>, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/10/26 10:41, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Stores through a shared writable mapping and fallocate with
> FALLOC_FL_PUNCH_HOLE, FALLOC_FL_ZERO_RANGE, FALLOC_FL_COLLAPSE_RANGE or
> FALLOC_FL_INSERT_RANGE do not go through ->write_begin, so they bypass
> the COW inode and modify the original inode directly. Reject them while
> the file is in atomic write mode, as fallocate already does for pinned
> and compressed files. A write fault gets SIGBUS and fallocate gets
> -EOPNOTSUPP.
> 
> fallocate without these flags only preallocates blocks and stays
> allowed.
> 
> f2fs_vm_page_mkwrite() cannot take inode_lock, so check the flag under
> invalidate_lock, and hold invalidate_lock in
> f2fs_ioc_start_atomic_write() from the flush until the flag is set.
> Otherwise a fault could check the flag, then start_atomic_write could
> flush and set the flag, and the fault would dirty the folio afterwards.
> 
> Cc: stable@kernel.org
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Daeho,

Please take a look at https://sashiko.dev/#/patchset/20261010024133.2444761-1-daeho43%40gmail.com

I think we need to apply this after ("f2fs: remove mappedtodisk flag usage in mmap write path")

More details are in my comments on this patch:
https://lore.kernel.org/linux-f2fs-devel/496b913c-eb81-4fa8-be72-c6a06a10aba2@kernel.org/

Otherwise it looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> ---
> v2: serialize atomic flag check in f2fs_vm_page_mkwrite().
> ---
>  fs/f2fs/file.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index ef4d218e694..7020b3e8940 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -187,6 +187,17 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  	file_update_time(vmf->vma->vm_file);
>  	filemap_invalidate_lock_shared(inode->i_mapping);
>  
> +	/*
> +	 * mmap stores bypass the COW inode and would break atomicity. Check
> +	 * under invalidate_lock: f2fs_ioc_start_atomic_write() holds it while
> +	 * flushing dirty folios and setting FI_ATOMIC_FILE, so either it sees
> +	 * our dirty folio and writes it back, or we see the flag.
> +	 */
> +	if (unlikely(f2fs_is_atomic_file(inode))) {
> +		err = -EOPNOTSUPP;
> +		goto out_sem;
> +	}
> +
>  	folio_lock(folio);
>  	if (unlikely(folio->mapping != inode->i_mapping ||
>  			folio_pos(folio) > i_size_read(inode) ||
> @@ -2113,9 +2124,11 @@ static long f2fs_fallocate(struct file *file, int mode,
>  
>  	/*
>  	 * Pinned file should not support partial truncation since the block
> -	 * can be used by applications.
> +	 * can be used by applications. Atomic files should not either, since
> +	 * these modify the original inode directly and break atomicity.
>  	 */
> -	if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode)) &&
> +	if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode) ||
> +	     f2fs_is_atomic_file(inode)) &&
>  		(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
>  			FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE))) {
>  		ret = -EOPNOTSUPP;
> @@ -2403,6 +2416,8 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>  
>  	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
>  	f2fs_down_write(&fi->i_gc_rwsem[READ]);
> +	/* serialize with f2fs_vm_page_mkwrite(), see the comment there */
> +	filemap_invalidate_lock(inode->i_mapping);
>  
>  	/*
>  	 * Should wait end_io to count F2FS_WB_CP_DATA correctly by
> @@ -2458,6 +2473,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>  	f2fs_i_size_write(fi->cow_inode, isize);
>  
>  out_unlock:
> +	filemap_invalidate_unlock(inode->i_mapping);
>  	f2fs_up_write(&fi->i_gc_rwsem[READ]);
>  	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
>  	if (ret)



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
