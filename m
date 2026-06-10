Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3ACCD8CAD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 10 Jun 2026 00:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JRlBMzMVBv5S2bQSOLD9684vy6FsAb52/l2erFcOFk8=; b=KT6OO1cI0dBBljLauRWhYF5871
	XMfe0qa4cFvhXwoujVrA0BqCcbgUrLPAz9UYLr0k/QqjvqoGrQMp0DhByFaRK/kihlC+VwwVOLPVA
	Qkss3JasGELxVdwXpQU0Ma0goNOHSPOoHDSo2RR0eiGL5EKl4u00A6S9IymTNLr3Mk6Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wX703-00057q-EG;
	Wed, 10 Jun 2026 00:40:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wX701-00057W-B1
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 00:40:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5XEnPYT/t4pzh4JXROa8wrBWYGt4Z0Jma3WAo1+RNXY=; b=YDG7n+HiIO4d6msmSapHT2Oywf
 wUGysCcsUZrLqqm930xn0YplqhoYbMygw+QkYBT6tfPW6pTSEnL5wpgQD7vo1kJQC0tqrHYM788jV
 4lF7L9lIQ2Thc9l9uvBPKcjX+DjPHGYsno6xER/XovhFAMDCS5C6zoBZZjn0TlRQVfL0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5XEnPYT/t4pzh4JXROa8wrBWYGt4Z0Jma3WAo1+RNXY=; b=PDAeTp5vFTmhg3x5gVFfMvldbi
 Yntz//9D/MYXujk0ZJ1MKFk2DAHeWYD6Bdt7lEGELeoiXcIpiZQQNx+bFAGpNMvIPDGyt21qWAqBq
 OEszgjOmZXAojElZWsNfwNhWdCHfySFUCoe/4LeekVOIsju2QvrM3+Hsecug6Ot6+kYU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wX700-0001bK-1K for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 00:40:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2217E43222;
 Wed, 10 Jun 2026 00:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2CE1F00893;
 Wed, 10 Jun 2026 00:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781052042;
 bh=5XEnPYT/t4pzh4JXROa8wrBWYGt4Z0Jma3WAo1+RNXY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FA5yMXpIpWWB/jErTJXheiiVw5zwDQETSyWQcN9qPEMXxGZFcKtLG8fN5UnGdIEN+
 lMjyDqgc3b+9REz8XHlSVwJU1qIImo6SqdaxeJL9lcrnbdVmYOptoLWAXOLuWYj1zr
 nQdNHJywNSwmHCosTjcwUZwWhKyk/h5Yd8pEXTvI8eJn5EXdbKh25RNtBLEO27vMIB
 jDNEBoBdxkjPUz3dJh90CBzDVWYeGJXm+cKgJS8ODb7+fzoRSejWNQKPe1zrfCcURh
 WST8nv0XRT6twR4ttQgqolosHsvKgSxQ5SEzQKTyBfQLcUFsO2jx48K6+BH52e0ZvU
 nbneh6FSt7Lbg==
Date: Wed, 10 Jun 2026 00:40:40 +0000
To: Wenjie Qi <qwjhust@gmail.com>
Message-ID: <aiiyiBkRYm2XgCtZ@google.com>
References: <20260522061206.2405336-1-qiwenjie@xiaomi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260522061206.2405336-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wX700-0001bK-1K
Subject: Re: [f2fs-dev] [PATCH] f2fs: honor per-I/O write streams for direct
 writes
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 05/22, Wenjie Qi wrote:
> io_uring can pass a per-I/O write stream through kiocb->ki_write_stream,
> and block direct I/O propagates that value to bio->bi_write_stream.
> 
> F2FS added FDP stream mapping for DATA writes, but its direct write
> submit hook always rewrites bio->bi_write_stream from the inode write
> hint and F2FS temperature. As a result, a direct write with an explicit
> io_uring write_stream is submitted to the F2FS-selected stream instead
> of the user-requested stream.
> 
> Validate an explicit write stream before starting F2FS direct I/O, pass
> the kiocb through the iomap private pointer, and preserve the per-I/O
> stream in the direct write bio. When no per-I/O stream is supplied, keep
> using the existing F2FS temperature-to-stream mapping.
> 
> Fixes: 42f7a7a50a33 ("f2fs: map data writes to FDP streams")
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
>  fs/f2fs/file.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 71385ca4163d..20d6e7ab7416 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -5074,17 +5074,36 @@ static int f2fs_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
>  	return 0;
>  }
>  
> +static bool f2fs_valid_write_stream(struct f2fs_sb_info *sbi, u8 write_stream)
> +{
> +	int i;
> +
> +	if (!write_stream)
> +		return true;
> +	if (!f2fs_is_multi_device(sbi))
> +		return write_stream <= bdev_max_write_streams(sbi->sb->s_bdev);
> +
> +	for (i = 0; i < sbi->s_ndevs; i++)
> +		if (write_stream > bdev_max_write_streams(FDEV(i).bdev))
> +			return false;
> +	return true;
> +}
> +
>  static void f2fs_dio_write_submit_io(const struct iomap_iter *iter,
>  					struct bio *bio, loff_t file_offset)
>  {
>  	struct inode *inode = iter->inode;
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct kiocb *iocb = iter->private;
>  	enum log_type type = f2fs_rw_hint_to_seg_type(sbi, inode->i_write_hint);
>  	enum temp_type temp = f2fs_get_segment_temp(sbi, type);
>  
>  	bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi, DATA, temp);
> -	bio->bi_write_stream =
> -		f2fs_io_type_to_write_stream(bio->bi_bdev, DATA, temp);
> +	if (iocb->ki_write_stream)
> +		bio->bi_write_stream = iocb->ki_write_stream;
> +	else
> +		bio->bi_write_stream =
> +			f2fs_io_type_to_write_stream(bio->bi_bdev, DATA, temp);

Let me apply as below.

        bio->bi_write_stream =
+               iocb->ki_write_stream ? iocb->ki_write_stream :
                f2fs_io_type_to_write_stream(bio->bi_bdev, DATA, temp);


>  	blk_crypto_submit_bio(bio);
>  }
>  
> @@ -5122,6 +5141,11 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
>  
>  	trace_f2fs_direct_IO_enter(inode, iocb, count, WRITE);
>  
> +	if (!f2fs_valid_write_stream(sbi, iocb->ki_write_stream)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
>  	if (iocb->ki_flags & IOCB_NOWAIT) {
>  		/* f2fs_convert_inline_inode() and block allocation can block */
>  		if (f2fs_has_inline_data(inode) ||
> @@ -5159,7 +5183,7 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
>  	if (pos + count > inode->i_size)
>  		dio_flags |= IOMAP_DIO_FORCE_WAIT;
>  	dio = __iomap_dio_rw(iocb, from, &f2fs_iomap_ops,
> -			     &f2fs_iomap_dio_write_ops, dio_flags, NULL, 0);
> +			     &f2fs_iomap_dio_write_ops, dio_flags, iocb, 0);
>  	if (IS_ERR_OR_NULL(dio)) {
>  		ret = PTR_ERR_OR_ZERO(dio);
>  		if (ret == -ENOTBLK)
> 
> base-commit: 520760b9f9156bf9698de38dc44c614fad68a1f9
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
