Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3E7C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vLvF5hRr62VcJGNoCK2DJ++HIUAq+TCfgaZJxypRmHI=; b=eIv8PAFhucwFWMwZeVTTZiKCm+
	uZAKPcdGK/zXYg4CTxm2MeKYNKIN9lppgAEtFKY68k+Mvgz/RZszsFNDAVkAB7NK37hZrQcG8g0sM
	f7DtiQSktIRZ0ZNFxxgNJC1XH+1UA17FHXs1vl3LZUhdbJVYPWp028o25MYCEDKncSj4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wfINT-0002P2-6I;
	Thu, 02 Jul 2026 14:26:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wfINR-0002Ot-Lp
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 14:26:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DeMLPBZwQFsjXJk4oZ0hNQRYybAoVSTD2iSvI8asCj0=; b=WMqA4YnbU+z7ZwFHTnodSzlu7Q
 sY3ofIzHvk22t0cD4vLT3f11y5n3HoOP/P8DD6ysSfviwfnxa7xk3OljuMLOGj9jtjObLGI839yve
 Y89nJXkGckPv/uDlqOyowKroP4LzAvMkxDqz6t91lSNbhKUFcKovyOBnqsdFxkzuFhTw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DeMLPBZwQFsjXJk4oZ0hNQRYybAoVSTD2iSvI8asCj0=; b=YTs0RnvGHPYR1kH3VsmdgfFPUT
 1+bodsjelBxwjAjZYkrLEvzQw3Bt+p3s4kTPeZsk+HJKg+lOhyLZqX/W20bDt5iLacNa7cA22oD/q
 px8C/2cX1FC1k06Pt0z+AKeXaIreiqPpbiZ9lWljWagBNZ26uopq37IJNhNmpvKpNS3w=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfINP-0004J9-4p for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 14:26:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 00A59601C6;
 Thu,  2 Jul 2026 14:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3FA1F000E9;
 Thu,  2 Jul 2026 14:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783002400;
 bh=DeMLPBZwQFsjXJk4oZ0hNQRYybAoVSTD2iSvI8asCj0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=oS6/KPMDhH5aVrMaL4kMgowUFPEzYIB2WMI8aSyqa85md1IR8amTInodPBZBczL8J
 0DslWt3ea5ZqH9rY50w2kFHXwpM3XI44lclix57jEeBHPSK0sFRdHB5p1Twx14BHCh
 Q/HHIcP4+zcMM3j71ayEsL/KahIqut9tu7YAXUdxdPiCzkjj12N0N+z+BfRDQ/yDpg
 G2Pdcjbn3knSymhq1VgUM7/KYDGgH+d2/zrOsD09OD2kjcrn5cvcvclVvh/W6dsFhg
 EgKZEK1q1SFhmIK8rkQtXiTsWsi+vao7FX04GMS71SBZp8qAyemidiMZXiBjcjwpUk
 6w1hSQFZjYlmQ==
Date: Thu, 2 Jul 2026 14:26:39 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <akZ1H45tI_Cqm2vR@google.com>
References: <20260629114918.224537-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260629114918.224537-1-chao@kernel.org>
X-Headers-End: 1wfINP-0004J9-4p
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid potential
 section-unaligned pinfile
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 stable@kernel.org, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

On 06/29, Chao Yu via Linux-f2fs-devel wrote:
> Blocks of pinfile may not aligned to section size due to wrong use
> on pinfile, result in heavy overhead of GC, let avoid this by
> adding additional check condition in f2fs_setattr().
> 
> - truncate -s 8mb pinfile
> : random checkpoint may persist filesize w/ inode
> - fallocate -o 0 -l 8mb pinfile
>  - f2fs_fallocate
>   - f2fs_expand_inode_data
>    - f2fs_allocate_pinning_section
>    - f2fs_map_blocks
>     - f2fs_map_lock
>     - __allocate_data_block
>     - file_need_truncate
>     : w/ FADVISE_TRUNC_BIT, we can expect unaligned mapping can be
>       truncated while open() if f2fs is not umount abnormally
>     - f2fs_map_unlock
>     : following f2fs checkpoint and sudden power-cut
> 
> - mount
> - open pinfile
>  - f2fs_file_open
>   - finish_preallocate_blocks
>    - truncate_setsize
>    : filesize is 8mb
>    - f2fs_truncate
>    : can only truncate block outside filesize, rather than truncating
>      unaligned blocks inside filesize

Have we reproduced this?

> 
> Fixes: f5a53edcf01e ("f2fs: support aligned pinned file")
> Cc: stable@kernel.org
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/file.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index f4facd409d9b..11cc8d79c235 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1107,17 +1107,23 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  			!IS_ALIGNED(attr->ia_size,
>  			F2FS_BLK_TO_BYTES(fi->i_cluster_size)))
>  			return -EINVAL;
> -		/*
> -		 * To prevent scattered pin block generation, we don't allow
> -		 * smaller/equal size unaligned truncation for pinned file.
> -		 * We only support overwrite IO to pinned file, so don't
> -		 * care about larger size truncation.
> -		 */
> -		if (f2fs_is_pinned_file(inode) &&
> -			attr->ia_size <= i_size_read(inode) &&
> -			!IS_ALIGNED(attr->ia_size,
> -			F2FS_BLK_TO_BYTES(CAP_BLKS_PER_SEC(sbi))))
> -			return -EINVAL;
> +
> +		if (f2fs_is_pinned_file(inode)) {
> +			/*
> +			 * It may break section-aligned fallocate recovery
> +			 * mechanism, so do not allow larger size truncation.
> +			 */
> +			if (attr->ia_size > i_size_read(inode))
> +				return -EINVAL;
> +			/*
> +			 * To prevent scattered pin block generation, we don't
> +			 * allow smaller/equal size unaligned truncation for
> +			 * pinned file.
> +			 */
> +			else if (!IS_ALIGNED(attr->ia_size,
> +				F2FS_BLK_TO_BYTES(CAP_BLKS_PER_SEC(sbi))))
> +				return -EINVAL;
> +		}
>  	}
>  
>  	if (is_quota_modification(idmap, inode, attr)) {
> -- 
> 2.49.0
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
