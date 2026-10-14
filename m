Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB76CC6B1D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L1qwv0FDvvEjPm97CSlzOpnrxCdsUwHRV6Sze/lUBOE=; b=cGpVFpqQIiUiCwfpCIlQ611GwG
	WRnxni10yvmQaXqdM4bqVSHhupvEuiG3jDRF55Nwbwpg1l+8vs+IwJxI6sc8HjQH8yzRc8lfmeHhq
	2i8ZubV8nVa/dUKwTvZh36e6RhVP/aLjfeBZrRbaLP1re+QixXz1yy3DNz30iA4ZiwkQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGpKi-0004nk-KO;
	Wed, 14 Oct 2026 03:07:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xGpKW-0004nQ-Qg
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 03:07:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cvcIIENUcGj0kcDKv2wmnPJXR3e/hKvV0fryXSGNyHE=; b=mdePbC6gT4G25TSwu5HRJq2Ohu
 R18Pl7PCucV6h3jyS67LxHAt7VlYE5gFZkSQy1numJ8U98hdHEsVlpcmAxY6Ju91tA5aF+Tu6/9s2
 RlaLDy9gW6z1r+1qQ/aNJS3eg91Dy2512oKQEmqefiukJaQnKukrPKeI7jiAa9FAHPcM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cvcIIENUcGj0kcDKv2wmnPJXR3e/hKvV0fryXSGNyHE=; b=S1rBVj4OCQ8RM7eeyUevGHRQ5p
 FP5rutNPxZhmTcnOrIK0K+CC5vSZ0qZ7HJ+Xs0/2rHa3lAGnHDUofu4Ctwa8FeWhnpiTDnV2U8mcA
 BUOAHAw27h++P7EF/KxdYwO+a5KYZPLKDJ3AgBgKdApvNH0912jjibNpvg9mBYeFKbPQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGpKV-0002Gt-EA for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 03:07:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB19C41912;
 Wed, 14 Oct 2026 03:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D251F000FF;
 Wed, 14 Oct 2026 03:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791947213;
 bh=cvcIIENUcGj0kcDKv2wmnPJXR3e/hKvV0fryXSGNyHE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=dCz/PBOOdDSwPo8ILpNDTPs4g5UXsv/xPqXBP5Ov/2OZeatVU1g6XxkH2SnQQWjxf
 m8iz5wLKScuM0LkBZU+bxz7ffjkbhKcUQE356SRlbFGf5u9rvSD0rLDqMAg2rHeJTT
 +1DhxxiHGbW+HiQtJx0wZTi7MnVIH3v6dSzdi7ird07+LYpV0FANDjtUi7sy8mzW08
 CoTfK/BpQbxgYHZozmXIBkKDFTpzjfAWIbhYAqpE5mYg3PkyPBX/zOEcFn0QSzaBzj
 EMak0b0Pgliwt8hKAMkvyr3AQrG78wC+QZOz+grBd5aVimdSKuhHFy4kBpR+3ICTIa
 aCZnmUruKcKXw==
Message-ID: <520e921e-1bfd-4c45-b134-f0677a3c656a@kernel.org>
Date: Wed, 14 Oct 2026 11:06:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261013020941.4025355-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261013020941.4025355-1-daeho43@gmail.com>
X-Headers-End: 1xGpKV-0002Gt-EA
Subject: Re: [f2fs-dev] [PATCH] f2fs: release a removed xattr node in
 roll-forward recovery
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
Cc: Daeho Jeong <daehojeong@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/13/26 10:09, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When xattrs shrink enough to fit in the inline xattr area,
> write_all_xattrs() truncates the xattr node and clears i_xattr_nid. If
> the file is then fsynced without a checkpoint, only the inode block is
> written, with i_xattr_nid of 0.
> 
> Roll-forward recovery starts from the checkpointed inode, whose
> i_xattr_nid still points to the old xattr node.
> f2fs_recover_inline_xattr() copies only the inline xattr area, and
> f2fs_update_inode() writes the old i_xattr_nid back. So the inode keeps
> the stale xattr node:
> 
>  - The node block is never released, and fsck reports "nonzero bytes in
>    xattr space after end of list".
>  - If the inline xattr list ends exactly at the end of the inline area,
>    its terminator is read from the stale node, and the removed xattrs
>    come back after recovery.
> 
> When the fsynced inode has no xattr node but the checkpointed one has,
> release the old xattr node in the same way as f2fs_recover_xattr_data().
> 
> Fixes: 28cdce0459cc ("f2fs: recover inline xattr data in roll-forward process")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/node.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 55008f18afd..590fdedf9c2 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2831,6 +2831,29 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct f2fs_cached_block *ent
>  	f2fs_cache_wait_writeback(ientry);
>  	memcpy(dst_addr, src_addr, inline_size);
>  update_inode:
> +	/*
> +	 * The xattr node of the checkpoint was removed before fsync, e.g. the
> +	 * xattrs became small enough to fit inline. Release it as well, or
> +	 * the inode keeps pointing to the stale xattrs.
> +	 */
> +	if (!ri->i_xattr_nid && F2FS_I(inode)->i_xattr_nid) {
> +		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +		struct node_info ni;
> +		int err;
> +
> +		err = f2fs_get_node_info(sbi, F2FS_I(inode)->i_xattr_nid,
> +								&ni, false);
> +		if (err) {
> +			f2fs_put_cache(ientry, true);
> +			return err;
> +		}
> +
> +		f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
> +		dec_valid_node_count(sbi, inode, false);
> +		set_node_addr(sbi, &ni, NULL_ADDR, false);
> +		f2fs_i_xnid_write(inode, 0);

I think we need to clear dirty on xnode as well, refer to truncate_node(), otherwise
f2fs_writeback will write a dirty xnode w/ blkaddr = NULL_ADDR.

Thanks,

> +	}
> +
>  	f2fs_update_inode(inode, ientry);
>  	f2fs_put_cache(ientry, true);
>  	return 0;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
