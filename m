Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0BE606A321
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Nov 2026 02:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BQZQWXmk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Tal9doV6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JNgTSJea;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYIhfkD9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CPrBrqXsJTZMAj19VHLmY6xL1Hz/C53B0xJ7Lop9pws=; b=BQZQWXmkQS4rMi
	NkKoq0x2x7UlJKn5Ekk8qt4cIi9OwiBlHj+sYw7o7u+2derpqTA3/ahVf5tDOvXgw1dRXWlEV9QA0
	C2cvQ0j3KiR8A48Byv7anqpU95jkFzyEZb7vc5/VK3bwu5s3AbXz21hsSUBLGi6p47yGXC/AX/UVb
	iq0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xQFYt-000000000PW-2HwJ;
	Mon, 09 Nov 2026 02:56:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xQFYs-000000000PQ-1uAZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 02:56:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l0N+1tV51NomvRw2YSGSJFWSnM5g2H6wDnWRUKkQHIM=; b=Tal9doV6ZCxVsq0HyNvhKHrhPB
 oopU6ako1xBrEUBy3Ovr0gmdNUtsdCLXcRu6zUggH/5XUhMN6UJh34+lhPkcWShp7Xnc0SBOD4bY9
 eX31BEgrOr5ldb3+9EyBSqpxa6a41UbHogOLq8jFZNs0JtZwyfVTV1W2wr2/cOMc6lb0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l0N+1tV51NomvRw2YSGSJFWSnM5g2H6wDnWRUKkQHIM=; b=JNgTSJeayOrjP1Xlcd/8iTiC+d
 aMaO/bTTmOvqdPeTidnpTy1W54opqxXGOnOHu6HNn6WLmAMx8sG7TkWDOk7aX5bU7q4eEMwJSalYt
 Q+1+e0KHDdpC1Q8sgfa3KXiiPOy45Kuvr6USv2bcTuq2+ciRAkfV5JZWTYMT52VrFRYU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQFYr-000000005mx-3KkF
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 02:56:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6B9CB450DC;
 Mon,  9 Nov 2026 02:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319AD1F00906;
 Mon,  9 Nov 2026 02:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794193000;
 bh=l0N+1tV51NomvRw2YSGSJFWSnM5g2H6wDnWRUKkQHIM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=UYIhfkD9walzJNcw1CtF72FNggb/O18A9/J88GjCyydkiJwBXnkZHjFlrHati2lmc
 3fLmd5hxkoBb9bDEr3tNX6/FYE2eQMWUOBpyqZ8VyuTk7cpoCaug1ZE2TofhBGInif
 nFV6mxujD37LusJxKjNAdUAOl3lq47kV6r4QpH6m4MtKGIbU8TD08TwpwlOPWFMqDf
 NSl+ia83MMEqMXdVgrxK0uoQHfyQtuEGrQxeH9ebIugn+v2bkXd7ujTp5/vXPJuAde
 NRq0BsFBEEg+iIM6NX99O+XcB0JRWqBZL6f4nAZhekNFtMXATjUGkRg1CHkp0td4HZ
 IAdZK6buYi46g==
Message-ID: <f53843e5-7dc5-49f2-b551-9ce5273b278d@kernel.org>
Date: Mon, 9 Nov 2026 10:56:37 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261102193952.3002018-1-daeho43@gmail.com>
 <20261102193952.3002018-16-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261102193952.3002018-16-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQFYr-000000005mx-3KkF
Subject: Re: [f2fs-dev] [PATCH 15/20] f2fs: support subpage blocks in atomic
 writes
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 03:39, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Writeback already writes dirty blocks to the COW inode per block. Make
> write_begin of atomic files reserve and read COW blocks per block as
> well, and remove the -EOPNOTSUPP checks. Skipping the read of the
> blocks that a write fully covers also applies to large folios when the
> block size equals PAGE_SIZE.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fs/f2fs/data.c | 24 ++++++++++++++++--------
>   fs/f2fs/file.c |  5 +----
>   2 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a23fd4b01a4c..4e4d1b0d6004 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -4624,7 +4624,7 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
>   		}
>   
>   		if (f2fs_has_subpage_blocks(sbi) &&
> -		    (f2fs_compressed_file(inode) || f2fs_is_atomic_file(inode))) {
> +		    f2fs_compressed_file(inode)) {
>   			WARN_ON_ONCE(1);
>   			mapping_set_error(mapping, -EOPNOTSUPP);
>   			folio_clear_dirty_for_io(folio);
> @@ -5247,7 +5247,7 @@ static int prepare_large_folio_write_begin(struct inode *inode,
>   	int err = 0;
>   
>   	if (f2fs_has_subpage_blocks(sbi) &&
> -	    (f2fs_compressed_file(inode) || f2fs_is_atomic_file(inode)))
> +	    f2fs_compressed_file(inode))
>   		return -EOPNOTSUPP;
>   
>   	/*
> @@ -5359,13 +5359,16 @@ static int prepare_large_folio_atomic_write_begin(struct inode *inode,
>   	/* Inline data must have been converted before reaching here. */
>   	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
>   
> -	start = folio->index + (ori_off >> PAGE_SHIFT);
> -	end = folio->index + ((ori_off + len - 1) >> PAGE_SHIFT);
> +	start = f2fs_folio_lblk(sbi, folio) + (ori_off >> sbi->log_blocksize);

F2FS_BYTES_TO_BLK(sbi, ori_off)

> +	end = f2fs_folio_lblk(sbi, folio) +
> +		((ori_off + len - 1) >> sbi->log_blocksize);

F2FS_BYTES_TO_BLK(sbi, ori_off + len - 1)

Thanks,

>   
>   	for (index = start; index <= end; index++) {
> +		loff_t block_start = F2FS_BLK_TO_BYTES(sbi, index);
> +		loff_t block_end = block_start + F2FS_BLKSIZE(sbi);
>   		block_t blkaddr = NULL_ADDR;
>   		bool node_changed = false;
> -		size_t off = (index - folio->index) << PAGE_SHIFT;
> +		size_t off = f2fs_folio_byte_offset(sbi, folio, index);
>   
>   		err = prepare_atomic_write_begin(sbi, inode, index,
>   						&blkaddr, &node_changed,
> @@ -5373,12 +5376,17 @@ static int prepare_large_folio_atomic_write_begin(struct inode *inode,
>   		if (err)
>   			return err;
>   
> +		/* Skip read if the write covers the entire block. */
> +		if (pos <= block_start && pos + len >= block_end)
> +			goto balance;
> +
>   		if (f2fs_ffs_test_blk_uptodate(folio, index))
>   			goto balance;
>   
>   		if (blkaddr == NEW_ADDR) {
> -			folio_zero_segment(folio, off, off + PAGE_SIZE);
> -			f2fs_ffs_mark_subrange_uptodate(folio, off, PAGE_SIZE);
> +			folio_zero_segment(folio, off, off + F2FS_BLKSIZE(sbi));
> +			f2fs_ffs_mark_subrange_uptodate(folio, off,
> +							F2FS_BLKSIZE(sbi));
>   			goto balance;
>   		}
>   
> @@ -5436,7 +5444,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>   	}
>   
>   	if (f2fs_has_subpage_blocks(sbi) &&
> -	    (f2fs_compressed_file(inode) || f2fs_is_atomic_file(inode))) {
> +	    f2fs_compressed_file(inode)) {
>   		err = -EOPNOTSUPP;
>   		goto fail;
>   	}
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 1c440b5fa9bd..91f792cf879f 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2299,7 +2299,7 @@ static long f2fs_fallocate(struct file *file, int mode,
>   	}
>   
>   	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode))) {
> -		if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
> +		if (f2fs_compressed_file(inode)) {
>   			ret = -EOPNOTSUPP;
>   			goto out;
>   		}
> @@ -2553,9 +2553,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>   	loff_t isize;
>   	int ret;
>   
> -	if (f2fs_has_subpage_blocks(sbi))
> -		return -EOPNOTSUPP;
> -
>   	if (!(filp->f_mode & FMODE_WRITE))
>   		return -EBADF;
>   



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
