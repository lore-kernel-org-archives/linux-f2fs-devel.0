Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F3810F9307
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 Mar 2026 23:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a62YgeuiIjr9KBZ2T3/g2d7MV5uhdxorXVkNUkqMCQk=; b=L2mT083iF9c6LJU+Y/Oes193u9
	YwyxAbC92Y5W8sXdESaNXL0HYxyox/uJV6oOy6wSQSXb3Fsj/g4ci95XwQo4y7OEhThs4gUvdMulL
	OqfkEeOQ9RS0zVDZDOW1Mm6RZDVoOIA2nBeuq7IKVLfOpDuPh8zURn/nbe/VJmpjYwR4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w7iZZ-0007E4-8I;
	Tue, 31 Mar 2026 23:32:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1w7iZY-0007Dy-IP
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Mar 2026 23:32:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bJNCPLR7JCkhQIhM+zZoGFB1NFF3SkRqAom0ncejYRA=; b=i4zhiVo2OiPS7TXd47orM7iuNq
 sJUZ2iDsdj5STqQvWKIxt1Gb95wMKcp/6ib/MzGPMip3pAFUShq5UlXgzVrNpv5YpI3NFOmM6UkRs
 K0SMxY6eLcps635/u0z4CEIGXhwCo28vkH28Ov7Rzc0aASEQ15N2SamYvZDXYHTwH+Og=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bJNCPLR7JCkhQIhM+zZoGFB1NFF3SkRqAom0ncejYRA=; b=W3wY+TjpGsUHULpuow7O9Ys9HM
 aEyCDwk5mQ4gwoenKgvXorBEjkcrPE0Odhjzy/zfOP0cBW6rqAfoUZDN7eINA39342XlYOg/F+T2e
 iGSEOeret90P2WKQKuoNUq2EIkA7KwWwffh6WcM6a1soSDYr1Re+xuOBCk7/qyyRvnGs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w7iZY-0003MF-0N for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Mar 2026 23:32:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5390660120;
 Tue, 31 Mar 2026 23:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026CAC19423;
 Tue, 31 Mar 2026 23:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774999945;
 bh=BBghGICnfNmlmMhvY9XNZ0lqj1Gas1dXV2NQpfhbWXM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dyU7VG+8pp/TRzJHW1sOemsoPPVstO/KtSSpQlCHL3Ym+1Z0S+edNsMBdfgJdjCqX
 1RVrJ+1yTvcgwr2WD8jzZjzEfx3hq6a6rONa610NkvUkjU9dqUqXHMZZLj8PcMZBNM
 WQigfKeZaVVzS6DMr9VvAoHs0G3HwAWskDhC9MeaBuGJEcFLlCw0Ah37g2D5zKoNVj
 LxALVPsPJzM7qYYX5s8JEQDfF+gEB3zEP0WpokF+ADIjKafSAVDRvk8YOSKzPEkkE9
 9ElxsQQaVh206dOXf8ayr1BtZYc0bVGSsHMAFlB3zwnsKuPpJIkcDA6uQa4f3ZqGt6
 WvU2MUjmcmEUg==
Date: Tue, 31 Mar 2026 16:32:24 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260331233224.GG6223@frogsfrogsfrogs>
References: <20260331212827.2631020-1-aalbersh@kernel.org>
 <20260331212827.2631020-9-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260331212827.2631020-9-aalbersh@kernel.org>
X-Headers-End: 1w7iZY-0003MF-0N
Subject: Re: [f2fs-dev] [PATCH v6 08/22] iomap: introduce
 iomap_fsverity_write() for writing fsverity metadata
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Mar 31, 2026 at 11:28:09PM +0200, Andrey Albershteyn wrote:
> This is just a wrapper around iomap_file_buffered_write() to create
> necessary iterator over metadata.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Looks good to me.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 25 +++++++++++++++++++++++++
>  include/linux/iomap.h  |  3 +++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 7ac319618f8e..0f89225dc3d7 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1287,6 +1287,31 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
>  
> +int iomap_fsverity_write(struct file *file, loff_t pos, size_t length,
> +		const void *buf, const struct iomap_ops *ops,
> +		const struct iomap_write_ops *write_ops)
> +{
> +	int			ret;
> +	struct iov_iter		iiter;
> +	struct kvec		kvec = {
> +		.iov_base	= (void *)buf,
> +		.iov_len	= length,
> +	};
> +	struct kiocb		iocb = {
> +		.ki_filp	= file,
> +		.ki_ioprio	= get_current_ioprio(),
> +		.ki_pos		= pos,
> +	};
> +
> +	iov_iter_kvec(&iiter, WRITE, &kvec, 1, length);
> +
> +	ret = iomap_file_buffered_write(&iocb, &iiter, ops, write_ops, NULL);
> +	if (ret < 0)
> +		return ret;
> +	return ret == length ? 0 : -EIO;
> +}
> +EXPORT_SYMBOL_GPL(iomap_fsverity_write);
> +
>  static void iomap_write_delalloc_ifs_punch(struct inode *inode,
>  		struct folio *folio, loff_t start_byte, loff_t end_byte,
>  		struct iomap *iomap, iomap_punch_t punch)
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 4d9202cae29f..83586f09f365 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -359,6 +359,9 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
>  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
>  		const struct iomap_ops *ops,
>  		const struct iomap_write_ops *write_ops, void *private);
> +int iomap_fsverity_write(struct file *file, loff_t pos, size_t length,
> +		const void *buf, const struct iomap_ops *ops,
> +		const struct iomap_write_ops *write_ops);
>  void iomap_read_folio(const struct iomap_ops *ops,
>  		struct iomap_read_folio_ctx *ctx, void *private);
>  void iomap_readahead(const struct iomap_ops *ops,
> -- 
> 2.51.2
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
