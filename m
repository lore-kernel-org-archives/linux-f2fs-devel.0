Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BFDC982F1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 03:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NMhI3l370xjYxINyx+o/Q/mOIu7Wet4LGGyH0GyfiHw=; b=Tm+GRtSSuJ3I7Yl4I84u5AI645
	kyOsQKq2tWg/deEqOmw4DuPmSZNb5znkoexrFjOwS/5oOEhVzDC740iDDYnBP7q5UqypjNUdcNIbF
	SZJdDwYT68HsxdXDCsyVfA8mGARDbQHaVc9JjGvXuz+2Pv2BcL3N+yOl6YvuKUVQ9oho=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8qtN-0000dy-6R;
	Tue, 22 Sep 2026 03:09:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x8qtB-0000dj-9q
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 03:09:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CBrq0W4hwuHtFakDlzYoO5CFxEwhKTqvSW2yit9CFf4=; b=KQxt9fajPBxod7w6d/D5RXS8m4
 z8md0qsJI+mbylNGNMAGbEgsTpnMssojnIuXXp0SQKUlRB+0eaMhin/emUfIkgpgPi9Rpcu5M4opl
 dY2H6e/neH9oAXB1n6tadNgXyoPz/svGQl/Yz2uiOlU4N7wi9LKhTnGPp6uLUBqNjyPA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CBrq0W4hwuHtFakDlzYoO5CFxEwhKTqvSW2yit9CFf4=; b=VeB+cd2kEEO77Fx7R2zQ/DSEdk
 QXbTozMQ8qARu3bM096ZZGWmr7BZ0AdnaR0SEt9TKQA4WEYMun1Sdy1cHiDvNa+dHVxr30kRAbNp8
 lRnIcONJPTmTkpXDYh7T1WAi/VpgAS/9IrjiA2ytuN/qcKwFw26ymKmrEbXfaTEfcmZ0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8qt7-0003pI-C1 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 03:09:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F275A418F8;
 Tue, 22 Sep 2026 03:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEB11F000FF;
 Tue, 22 Sep 2026 03:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790046579;
 bh=CBrq0W4hwuHtFakDlzYoO5CFxEwhKTqvSW2yit9CFf4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=iGH8lUKFZTsbN++vJ/QwgzV0AfW4e21HkwgcxJtIBtce0InGcNNKyQVmFb/Y488e2
 sE2k/I6sXlnJ4pSqL6/AWnwzHg/pdkIxKMyaX/5Ccw919j8KpfKtXz7yUnjw10GC/l
 gZcuBAPGEW7S4SyL2n2HbnnrxP03XnMOS02PFImiTMo8sUDXLNFV+e65pOlaUMSS/u
 OlNxLb2Fa+rjqYCXbTD6Q6cK5VpxXwICBax0bzK9rR/DV5OHGTHvJy3dl8LhmFmDCb
 iR+aO663/okc1AjvfWfBa2ujn55i/d3brjCERAr0Kcw7EgdZvFEGSRiS6/pfjPMiI2
 5OhybF6cmvJPw==
Message-ID: <747d2cbe-01ce-4261-a699-e51ede593434@kernel.org>
Date: Tue, 22 Sep 2026 11:09:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260915041909.2903887-1-zhaonanzhe@xiaomi.com>
 <20260915042503.2912616-4-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260915042503.2912616-4-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x8qt7-0003pI-C1
Subject: Re: [f2fs-dev] [PATCH v2 14/14] f2fs: make compressed files
 compatible with large folio
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/15/26 12:25, Nanzhe Zhao wrote:
> The compression flag is the hint indicates that the inode can be
> compressed, when the inode is using large folio, we expected it keeps
> using the large folio read/write paths and its data stays uncompressed
> on disk until the inode is evicted and re-read
> 
> Let f2fs_write_begin() skip the compression overwrite preparation for
> such inodes and remove the compressed-file gate in
> f2fs_read_data_large_folio() so the data is simply read/written as
> regular blocks.
> 
> For the same reason, reject F2FS_IOC_COMPRESS_FILE with -EOPNOTSUPP
> once the inode mapping is switched to large folios.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>  Documentation/filesystems/f2fs.rst | 10 ++++++++++
>  fs/f2fs/compress.c                 |  2 ++
>  fs/f2fs/data.c                     |  9 ++-------
>  fs/f2fs/file.c                     |  7 +++++++
>  4 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 771216f45207..b4f436ffd9ac 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -941,6 +941,16 @@ Compression implementation
>    reserved via ioctl(F2FS_IOC_RESERVE_COMPRESS_BLOCKS) or the file size is
>    truncated to zero.
>  
> +- Compression and large folios are not effective at the same time on a file:
> +  a compressed inode does not use large folios, while an inode which is
> +  using large folios keeps its data uncompressed on disk.  If the compression
> +  flag is set on an inode that is already using large folios, the flag works
> +  as a hint until the inode is evicted: the inode keeps using the large folio
> +  read/write paths, f2fs_write_begin() skips the compression overwrite
> +  preparation, and ioctl(F2FS_IOC_COMPRESS_FILE) fails with -EOPNOTSUPP.
> +  Once the inode is evicted and read back, it uses order-0 folios again and
> +  compression is applied as usual.
> +
>  Compress metadata layout::
>  
>  				[Dnode Structure]
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index b130e43b4566..fa0f8449a12c 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -78,6 +78,8 @@ bool f2fs_is_compressed_page(struct folio *folio)
>  		return false;
>  	if (folio_test_f2fs_nonpointer(folio))
>  		return false;
> +	if (f2fs_folio_has_ffs(folio))
> +		return false;
>  
>  	f2fs_bug_on(F2FS_F_SB(folio),
>  		*((u32 *)folio->private) != F2FS_COMPRESSED_PAGE_MAGIC);
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index c9dba8d0ad3d..f5421334ecf3 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2941,12 +2941,6 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>  	int ret = 0;
>  	bool folio_in_bio = false;
>  
> -	if (f2fs_compressed_file(inode)) {
> -		if (folio)
> -			folio_unlock(folio);
> -		return -EOPNOTSUPP;
> -	}
> -
>  	map.m_seg_type = NO_CHECK_TYPE;
>  
>  	if (rac)
> @@ -4828,7 +4822,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>  	}
>  
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
> -	if (f2fs_compressed_file(inode)) {
> +	if (f2fs_compressed_file(inode) &&
> +	    !mapping_large_folio_support(inode->i_mapping)) {
>  		int ret;
>  		struct page *page;
>  
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index db71cadefabd..c5cb0b0384b6 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -5002,6 +5002,13 @@ static int f2fs_ioc_compress_file(struct file *filp)
>  	if (!(filp->f_mode & FMODE_WRITE))
>  		return -EBADF;
>  
> +	/*
> +	 * The mapping is already using large folios, where the data is kept
> +	 * uncompressed, so refuse to start compressing the file.
> +	 */
> +	if (mapping_large_folio_support(inode->i_mapping))

It needs to print log here to give notice.

e.g "not support if large folio bit is set, drop inode cache to unset the flag and retry" ?

Thanks,

> +		return -EOPNOTSUPP;
> +
>  	f2fs_balance_fs(sbi, true);
>  
>  	ret = mnt_want_write_file(filp);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
