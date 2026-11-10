Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A44606A331
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Nov 2026 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mFy4/FE8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=m387KOJ7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MzRYzj7/;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QuFEgcje
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Lb8kNZCfIf83hCIosjtE3d34b+Eh8BThN5CEDq1iEl0=; b=mFy4/FE8c8K7qJ
	yi3sMso+i/VYSW81My1D/wosuYLId1WSVAbcGc3TJh7PBCwq+avear5Gid+yU1h3/vSPdOP8nVLSN
	gy5z68ytoN9u8oPRzkyjxC70tNroeK1szObsXc2Ee98IS4X/EvJ2rnkuze/8UnRE2EMVZOUATIBYT
	XnM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xQkMx-000000008K0-0rBC;
	Tue, 10 Nov 2026 11:50:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xQkMZ-000000008IN-347M
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:50:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1ItAXHSlUPIZQNmR9opFqhtbfungH9CIICRVQjVJ10k=; b=m387KOJ7zZjbNVJsWiPxjsXWfK
 6Js8VaNBZbbS16eEtdUaBhgvhdOk3ASbztDDGQQNdGolPA+bhmObAchzzzulP+WhQDdcELvDYKWlk
 05G/A3KzzEWxbbZZnRm7w1qN7xOhuWCdd7zMDO7Mvtpxg203cfOqhLr7K1rBcYzCZGew=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1ItAXHSlUPIZQNmR9opFqhtbfungH9CIICRVQjVJ10k=; b=MzRYzj7/apLSw+Ui5KrAw9mavQ
 VNwWXeIDlvgXPy1DSBQ4YqMPtD07a1E6Y3V1YmpJ5T8EinOd230JcbGQrAMhcXFY2ZedvKuQFN7Ba
 HytQd3fPW7fF1kisSPt7W4PssceyW03LKmfG1ec3eT+6/NA5VJvPhsJYmSYaidE4YwBU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQkMZ-000000004oI-0N3h
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:50:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B641940955;
 Tue, 10 Nov 2026 11:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CB51F008A4;
 Tue, 10 Nov 2026 11:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794311401;
 bh=1ItAXHSlUPIZQNmR9opFqhtbfungH9CIICRVQjVJ10k=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=QuFEgcjeAsY6iC2CNlC9tG2aM+pZiQ1mY9Dk6iIc0NvlfR8v+GY4ARM8GLGkZl4wQ
 SHC7SpIXMI+ihrpHabBm5E9lomF1m2zbrkaxTAgoxrh8KLL4J3Io2LbMPrWmbojM7N
 YFF0euuJpAlO0H91Si55ygK0h1s3CTTxkqSDztsFpavyU5ws36hXOjlwEalpNKftBf
 GLWWnOW/MKCkIfLkKnCXmLViGEcQD0eILElFzKGdBMQQUeguT2k3aIe6481WPYxk64
 CWDLVwg78rConcCSbNnQ1GcNHp1un3F0MH+w5v95Jrp9hnq2qJZbeyMSOAqV3pCWWu
 X31Ma7DiTQ+IQ==
Message-ID: <32f2a9f7-2c87-4200-b562-61ae8d0ac91a@kernel.org>
Date: Tue, 10 Nov 2026 19:49:58 +0800
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
X-Headers-End: 1xQkMZ-000000004oI-0N3h
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

With this patch atomic files are allowed in subpage mode, so
f2fs_abort_atomic_write(inode, true) can extend i_size back to
original_i_size (e.g. after F2FS_IOC_START_ATOMIC_REPLACE set it to 0).
FI_ATOMIC_FILE is cleared before i_size is restored and abort doesn't hold
invalidate_lock, so a racing mmap fault can run ->page_mkwrite() with the
small i_size and map the folio writable; stores to its blocks between the
old EOF and original_i_size then don't fault and aren't marked dirty.
Should we call pagecache_isize_extended() after restoring i_size there, as
patch 08 does for the other i_size extension paths?

Thanks,

> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/data.c | 24 ++++++++++++++++--------
>  fs/f2fs/file.c |  5 +----
>  2 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a23fd4b01a4c..4e4d1b0d6004 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -4624,7 +4624,7 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
>  		}
>  
>  		if (f2fs_has_subpage_blocks(sbi) &&
> -		    (f2fs_compressed_file(inode) || f2fs_is_atomic_file(inode))) {
> +		    f2fs_compressed_file(inode)) {
>  			WARN_ON_ONCE(1);
>  			mapping_set_error(mapping, -EOPNOTSUPP);
>  			folio_clear_dirty_for_io(folio);
> @@ -5247,7 +5247,7 @@ static int prepare_large_folio_write_begin(struct inode *inode,
>  	int err = 0;
>  
>  	if (f2fs_has_subpage_blocks(sbi) &&
> -	    (f2fs_compressed_file(inode) || f2fs_is_atomic_file(inode)))
> +	    f2fs_compressed_file(inode))
>  		return -EOPNOTSUPP;
>  
>  	/*
> @@ -5359,13 +5359,16 @@ static int prepare_large_folio_atomic_write_begin(struct inode *inode,
>  	/* Inline data must have been converted before reaching here. */
>  	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
>  
> -	start = folio->index + (ori_off >> PAGE_SHIFT);
> -	end = folio->index + ((ori_off + len - 1) >> PAGE_SHIFT);
> +	start = f2fs_folio_lblk(sbi, folio) + (ori_off >> sbi->log_blocksize);
> +	end = f2fs_folio_lblk(sbi, folio) +
> +		((ori_off + len - 1) >> sbi->log_blocksize);
>  
>  	for (index = start; index <= end; index++) {
> +		loff_t block_start = F2FS_BLK_TO_BYTES(sbi, index);
> +		loff_t block_end = block_start + F2FS_BLKSIZE(sbi);
>  		block_t blkaddr = NULL_ADDR;
>  		bool node_changed = false;
> -		size_t off = (index - folio->index) << PAGE_SHIFT;
> +		size_t off = f2fs_folio_byte_offset(sbi, folio, index);
>  
>  		err = prepare_atomic_write_begin(sbi, inode, index,
>  						&blkaddr, &node_changed,
> @@ -5373,12 +5376,17 @@ static int prepare_large_folio_atomic_write_begin(struct inode *inode,
>  		if (err)
>  			return err;
>  
> +		/* Skip read if the write covers the entire block. */
> +		if (pos <= block_start && pos + len >= block_end)
> +			goto balance;
> +
>  		if (f2fs_ffs_test_blk_uptodate(folio, index))
>  			goto balance;
>  
>  		if (blkaddr == NEW_ADDR) {
> -			folio_zero_segment(folio, off, off + PAGE_SIZE);
> -			f2fs_ffs_mark_subrange_uptodate(folio, off, PAGE_SIZE);
> +			folio_zero_segment(folio, off, off + F2FS_BLKSIZE(sbi));
> +			f2fs_ffs_mark_subrange_uptodate(folio, off,
> +							F2FS_BLKSIZE(sbi));
>  			goto balance;
>  		}
>  
> @@ -5436,7 +5444,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>  	}
>  
>  	if (f2fs_has_subpage_blocks(sbi) &&
> -	    (f2fs_compressed_file(inode) || f2fs_is_atomic_file(inode))) {
> +	    f2fs_compressed_file(inode)) {
>  		err = -EOPNOTSUPP;
>  		goto fail;
>  	}
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 1c440b5fa9bd..91f792cf879f 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2299,7 +2299,7 @@ static long f2fs_fallocate(struct file *file, int mode,
>  	}
>  
>  	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode))) {
> -		if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
> +		if (f2fs_compressed_file(inode)) {
>  			ret = -EOPNOTSUPP;
>  			goto out;
>  		}
> @@ -2553,9 +2553,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>  	loff_t isize;
>  	int ret;
>  
> -	if (f2fs_has_subpage_blocks(sbi))
> -		return -EOPNOTSUPP;
> -
>  	if (!(filp->f_mode & FMODE_WRITE))
>  		return -EBADF;
>  



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
