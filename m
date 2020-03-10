Return-Path: <SRS0=yDIE=43=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326A2C18E5A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:27:34 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3D4520578;
	Tue, 10 Mar 2020 15:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="JYa5riIc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="GSbRd3bm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1yEkke95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D4520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jBgn5-0003Pq-FR; Tue, 10 Mar 2020 15:27:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1jBgn2-0003P4-7f
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Mar 2020 15:27:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jtfiDPMSkTVnZTj3/9nM9bWqjJOH2eOGPT15shrtb6s=; b=JYa5riIcZJNA/ob2LIItLKrsTM
 a3yfTxWdSjTy35OkmUhjmUdBblJKZdxu9L6MrtHLVlpgtXCrW2nukaav3oj+s/kN94KMWasOhZrFj
 OBhXMOpcOVtvEbdYnayGH4qqBtXuvONf1dLHeeTBpG+o3VPRwdIK2s5cNcsLb0Va0p1Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jtfiDPMSkTVnZTj3/9nM9bWqjJOH2eOGPT15shrtb6s=; b=GSbRd3bmB/Tyin/raaqjMCOE/G
 3aBvQfjB87HeLEh8sGm2LALkas7JC744EpI89Q46iGe311uYIA2R3zshfwhy2qw9nYx6z5TyMDRoZ
 ZHIfjhYNc0h7tg35CoO6wozW/+up0/WHxXSgMYNox0mWCLHR741sW1yhXK9hDAZY+jv0=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jBgmy-00Ek1E-N1
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Mar 2020 15:27:28 +0000
Received: from [192.168.0.107] (unknown [117.89.210.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 559CA20578;
 Tue, 10 Mar 2020 15:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583854039;
 bh=zkJ/Qq9oLoVH+s4+41brSYvvL5jdsRF7cJDAHbNUSRE=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=1yEkke95RfXMVwnDFxPRDOWM7JJXcFL82SV7/dpNGtu1Fg9IWsWE8OWU3gknzl4m6
 /ZfukMh03tIZhU8+1uk8DLWkVwjaU0axChTUs7cRCLYilFL/qx6okU1snmiPKX69dR
 20AKqlQFigPpdJxyI9a4At04pTxlI6eQk5q5ZH+A=
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
References: <20200225102646.43367-1-yuchao0@huawei.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <3525f924-7d65-c005-a7e6-d315cf14aab2@kernel.org>
Date: Tue, 10 Mar 2020 23:26:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200225102646.43367-1-yuchao0@huawei.com>
X-Headers-End: 1jBgmy-00Ek1E-N1
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to check i_compr_blocks correctly
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Jaegeuk,

On 2020-2-25 18:26, Chao Yu wrote:
> inode.i_blocks counts based on 512byte sector, we need to convert
> to 4kb sized block count before comparing to i_compr_blocks.
>
> In addition, add to print message when sanity check on inode
> compression configs failed.
>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/inode.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 156cc5ef3044..299611562f7e 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -291,13 +291,30 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>  			fi->i_flags & F2FS_COMPR_FL &&
>  			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
>  						i_log_cluster_size)) {
> -		if (ri->i_compress_algorithm >= COMPRESS_MAX)
> +		if (ri->i_compress_algorithm >= COMPRESS_MAX) {
> +			f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
> +				"compress algorithm: %u, run fsck to fix",
> +				  __func__, inode->i_ino,
> +				  ri->i_compress_algorithm);
>  			return false;
> -		if (le64_to_cpu(ri->i_compr_blocks) > inode->i_blocks)
> +		}
> +		if (le64_to_cpu(ri->i_compr_blocks) >
> +				SECTOR_TO_BLOCK(inode->i_blocks)) {
> +			f2fs_warn(sbi, "%s: inode (ino=%lx) hash inconsistent "

This is a typo: hash -> has

Could you please manually fix this in your tree?

Thanks

> +				"i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
> +				  __func__, inode->i_ino,
> +				  le64_to_cpu(ri->i_compr_blocks),
> +				  SECTOR_TO_BLOCK(inode->i_blocks));
>  			return false;
> +		}
>  		if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
> -			ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE)
> +			ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE) {
> +			f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
> +				"log cluster size: %u, run fsck to fix",
> +				  __func__, inode->i_ino,
> +				  ri->i_log_cluster_size);
>  			return false;
> +		}
>  	}
>
>  	return true;
>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
