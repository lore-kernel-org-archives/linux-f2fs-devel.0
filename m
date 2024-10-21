Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A87D17143
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Oct 2024 23:18:58 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t31fr-00085v-NZ;
	Mon, 21 Oct 2024 23:18:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1t31fq-00085n-Md
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Oct 2024 23:18:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TJEuUutF3CkksJmv2r0M4/v8VtYQrAkLumT8KoOIcLE=; b=gcFEeYpi6XCcaDHwocfUq2tzqp
 +1hi6YbUFfocWX7NflzYX+lQ4FCfJiQQbzylDug9r6SR/IA6l/gyd1bXc+pzEzVSwjwsR/5I9ou0w
 VYpe8V8sDcnyj07P6ZDzKpLmHixwOrDuQIqSDbXii8kHSJAYYBWKAAEO4fbNWgWZhxTI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TJEuUutF3CkksJmv2r0M4/v8VtYQrAkLumT8KoOIcLE=; b=Bgxvhm/P7GW5vLGkw2ue3CXyJq
 nNWRBkhkijOPSHCkpGcOc/Qw0gXvHeY21VzqJjCVATJnfIG2+byh7wc8MSV66ugsh2vgqRGPSt5fA
 RZGrNW8ltPTMqp+CoWskraK7JB7Io9cTFVLueiq1gLmNoCpvl0kDp5BSfFuCTxwSXZVY=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t31fq-0005sS-NE for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Oct 2024 23:18:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D73CFA43D9B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 21 Oct 2024 23:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DC2C4CEC3;
 Mon, 21 Oct 2024 23:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729552723;
 bh=qAofwyLaCqfFXe2wS/I3RsZjJtggKj/Ah91XXFai2Mg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ABw98VDrR21T+xC8TzqmUzsOceiZqP+wfcVeLUD3eV8Qq2mYguTJl/H4zFuIR1lMn
 DwQBTOX3Xze02dJch2fNt8hlqTX7UBYMsL7X9jva2uYVaQn/BuUXETjEkGKGtY6DxU
 a5Hy2Da/ZxIMkkw4y5cha72MMJdSTAK8Z32Lhj5zqT73w+nS0keJR1qpohiGtKHupu
 22bbEf6xCSRf55XABpSXCZFgs+Vv0BWcoUNv7ygibnEwpB/VXzRPNs8ifp6aeK8JuF
 gQQgS0ChLOBZBbAf6Zn3kgZjSaoIqruT2QmU4+WlKAayChLpbWVOP216kF2Jn2Modf
 biaTMSgpf03ug==
Date: Mon, 21 Oct 2024 23:18:41 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <ZxbhUUuKx_zaWAx4@google.com>
References: <20241018062638.2619214-1-chao@kernel.org>
 <20241018062638.2619214-2-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241018062638.2619214-2-chao@kernel.org>
X-Headers-End: 1t31fq-0005sS-NE
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: zone: allow IPU for regular file
 in regular block device
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/18, Chao Yu wrote:
> blkzoned feature enables lfs mode by default, for data updates from
> regular file, it only allow to use OPU, this patch changes to allow
> to use IPU if regular file's data block locates in regular block
> device, if data block locates in zoned block device, it still uses
> OPU.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c | 12 ++++++++++--
>  fs/f2fs/f2fs.h |  5 +++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 949b6bb957c7..c6d0e4aa12e3 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2648,8 +2648,16 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
>  		return false;
>  	if (fio && is_sbi_flag_set(sbi, SBI_NEED_FSCK))
>  		return true;
> -	if (f2fs_lfs_mode(sbi))
> -		return true;
> +	if (f2fs_lfs_mode(sbi)) {
> +		/* no regular block device in mainarea */
> +		if (!f2fs_blkzoned_has_regular_section(sbi))
> +			return true;
> +		/* blkaddr locates in sequential zone */
> +		if (fio && __is_valid_data_blkaddr(fio->old_blkaddr) &&
> +			GET_SEGNO(sbi, fio->old_blkaddr) >=
> +					sbi->first_zoned_segno)

What if there's another regular device beyond zoned partition?
I prefer to keep the entire area as lfs mode to simplify the performance.
Do we really need IPU on conventional partition? Why not asking to use
file pinning, if someone needs IPU?

> +			return true;
> +	}
>  	if (S_ISDIR(inode->i_mode))
>  		return true;
>  	if (IS_NOQUOTA(inode))
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 55bcd411257a..6781b4fab43f 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4790,6 +4790,11 @@ static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
>  	f2fs_invalidate_compress_page(sbi, blkaddr);
>  }
>  
> +static inline bool f2fs_blkzoned_has_regular_section(struct f2fs_sb_info *sbi)
> +{
> +	return f2fs_sb_has_blkzoned(sbi) && sbi->first_zoned_segno;
> +}
> +
>  #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
>  #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
>  
> -- 
> 2.40.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
