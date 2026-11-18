Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413B5606A32C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Nov 2026 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DfkAPAwB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=V2ZA228J;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Irys+gz1;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvuIIucM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=OE05WiG+KaqazABCi7NIELxuVey3/y8I/gNjTu3EKOg=; b=DfkAPAwBd5x664
	gppB+MjroEPE4QzMgEwvIrGXAPjdKTucWG597SouBCkBXQE+YLMBI7BsP3pHHMEQQ91ruAOCFhspw
	jTsdplN4UdW1p+YLULpktV9YCwQ27a3C4ftNJfkH01Yb99dxx9NiE0k1yBQBwBFuolpoz91wM1fdY
	Yvg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTVR2-000000000qz-092Z;
	Wed, 18 Nov 2026 02:30:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xTVR0-000000000qs-2i9j
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 02:30:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WwSqz9XCDJDsYvwx2pp3LvjG+xOgTavj+Zea0JWrFWQ=; b=V2ZA228J07zNQxqXDKQCQDDPOV
 fKesv5AtjwQW53CJjhQxhc1uEik9wpULzx+OJLunCeDJvD+FpNvLwU2MjICcWY2iWSwyL5VE4/hvz
 ZkLQCPl++0YXzlGkEsrGWN5PJsayWECnTQLhecUndo31ZKIxrHMGdrl4jsnnDlNeATjc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WwSqz9XCDJDsYvwx2pp3LvjG+xOgTavj+Zea0JWrFWQ=; b=Irys+gz1K9veqPU9SSQkB/VISq
 MOmGgGS0yC1nsNmmfkOdCzs8nW4aMdrHbzbOVxdF1FoR7PSDwXZg+SBUV3OtO80Z4bLFdYlQt5uFy
 O1C3M0ICrpl60joMRwfKSMX7nXrnoJGQeasMfm3E/VXm10lOAJbynFQk2e5qBE/L0VQI=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTVQx-000000002wz-3GPA
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 02:30:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 28DCF6132A;
 Wed, 18 Nov 2026 02:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD881F000C5;
 Wed, 18 Nov 2026 02:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794968997;
 bh=WwSqz9XCDJDsYvwx2pp3LvjG+xOgTavj+Zea0JWrFWQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=lvuIIucMMta+cj9/8B0eEqlNwskqETWuTEoa0S+H3gVSEa1mdrg4gIqH+/09sKMuf
 rahbmBKfK5hc5igo+detbF3B3Qyva6LY/yHmx9CoHHz+uIMG/2UJuSrwDe/8x8jVVm
 sde6Q0spbDaVHY9iH9h6bEQ1fZ6TVFXxvXT9cOMVfRh3qb08niP/7melOEFaOvGzUx
 zYISJf5HOFQyIxRu9sfcDlnay/YHY7zUdsIuM1Xy8o9z1fwjqS9wkD/z5l9dIdSlgE
 KZ6aJmkpTB8vvR320+oJpYp7l5i0LQlQ7QDcyFCtPuj7KqB0S6jqnR9sYG+nFn+8N1
 ttowENQe8volA==
Message-ID: <00565d3e-c508-4764-8587-327c874adcc7@kernel.org>
Date: Wed, 18 Nov 2026 10:29:54 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-19-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261116040851.2849696-19-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTVQx-000000002wz-3GPA
Subject: Re: [f2fs-dev] [PATCH v2 18/20] f2fs: support subpage blocks in
 compression
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

On 11/16/26 12:08, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> With subpage blocks, a cluster spans fewer folios than blocks, and
> several compressed blocks share a bounce folio.
> 
> - Require a cluster to cover at least one page. This raises the minimum
>   compress_log_size only when a page has more than four blocks, e.g. to
>   64KB for 4KB blocks on a 64KB page kernel, where the mount option and
>   F2FS_IOC_SET_COMPRESS_OPTION reject a smaller one. A file that already
>   has a smaller cluster is handled like one with an unsupported
>   compression algorithm: it can be looked up and removed, but opening it
>   fails with -EOPNOTSUPP.
> - Use block offsets and sizes for compressed data, keep each compressed
>   block at its block offset within the cluster, and count pending
>   compressed I/O in blocks so that a shared bounce folio is not
>   decompressed or freed early.
> - Submit only the written block of a shared bounce folio in
>   f2fs_submit_page_write(), at its offset in the folio.
> - Keep compressed files on the page based read and write paths, and
>   compress a cluster only when all of its blocks are dirty and below
>   EOF.
> - A folio with per-block state may hold uptodate blocks newer than the
>   on-disk cluster, so decompress into a bounce page and copy back only
>   the blocks that are not uptodate.
> - Cache compressed blocks one block at a time in the compress cache.
> - Lock only the unlocked pages in cancel_cluster_writeback() to avoid a
>   self-deadlock.
> - Attach a folio state to the multi-block folios of a rewritten cluster
>   before they are dirtied, as the other write paths do.
> - Attach a folio state to multi-block folios that have none when
>   compressed writeback starts, as the raw write path does. Otherwise the
>   write completion, which does not hold the folio lock, can detach the
>   page private flags while a task is moving them into a new folio state.
> - Take sbi from the dic to count the blocks of a compressed page in
>   f2fs_finish_read_bio().
> - Write the blocks of a multi-block folio in
>   f2fs_write_single_data_page() as f2fs_write_cache_folios() does,
>   taking the write_blocks_pending bias with a new helper shared by the
>   two and dropping it with f2fs_ffs_put_write_pending().
> - Count a read folio of a compressed file once in the iostat:
>   f2fs_mpage_readpages() counts the folios that go through its loop,
>   and f2fs_read_data_large_folio() counts the others.
> - Remove the -EOPNOTSUPP checks.
> - Remove inode_inc_dirty_block() and inode_dec_dirty_block(), which
>   have no caller left.
> 
> The bounce folios are now freed when the last block of a cluster
> completes, also when the block size equals PAGE_SIZE.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

One minor comment below:

> @@ -4277,6 +4354,46 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
>  
>  	folio_zero_segment(folio, offset, folio_size(folio));
>  write:
> +	if (f2fs_is_multiblock_folio(sbi, folio)) {
> +		struct f2fs_lock_context lc;
> +		unsigned int to_blk = f2fs_blocks_per_folio(sbi, folio);
> +		u64 pos = folio_pos(folio);
> +
> +		if (!compr_blocks && !f2fs_verity_in_progress(inode))
> +			to_blk = min_t(unsigned int,
> +					F2FS_BLK_ALIGN(sbi, i_size - pos),
> +					to_blk);
> +
> +		/* Deadlock due to between page->lock and f2fs_lock_op */
> +		if (!compr_blocks && !f2fs_trylock_op(sbi, &lc)) {
> +			err = -EAGAIN;
> +			goto redirty_out;
> +		}
> +
> +		folio_start_writeback(folio);
> +		f2fs_folio_get_write_bias(folio, F2FS_BLK_TO_BYTES(sbi, to_blk));
> +
> +		err = f2fs_write_folio_dirty_range(folio, &local_submitted,
> +					wbc, io_type, pos,
> +					pos + F2FS_BLK_TO_BYTES(sbi, to_blk),
> +					compr_blocks);
> +
> +		if (!compr_blocks)
> +			f2fs_unlock_op(sbi, &lc);
> +
> +		/* The callers drop the submitted count on error. */
> +		if (err && local_submitted)
> +			f2fs_submit_merged_write_cond(sbi, NULL, folio);

We'd better clean up this if this is not a bug fix.

I think we can pass local_submitted to @submitted_p in f2fs_write_raw_pages() before
its error handling, so that its caller (f2fs_write_cache_pages()) can flush the bio
cache.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
