Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0F7C77B7C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Jun 2025 17:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ahaVWayZkz/9QXW5miUvLb4BvKdGj35MMJFynFAyxvc=; b=Gkai/W3HAuYUAxH+XsjQosKKgo
	07Io+YMB15oX42S0HxBbOEFsVGVvlXZ2gocMU4WTxJLor8abvFz7LtBEj/32grQHVSuXPvfc5QlTw
	nYjSyuGLFQdKSdN1LfVpqBfLPJZH5bYGaj8/OAGxAxTmX3ZSZwkn+ac0R91Tj8KQm4yI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uTlNM-0006AQ-2Y;
	Mon, 23 Jun 2025 17:54:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1uTlNE-0006AC-JL
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Jun 2025 17:54:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RmKgmnr6pteA0V6oRFO0seT36SJWL7Ih5xJsQD4ns8M=; b=KGMI95Wg+Jyao9nFhnS+ObF9Wb
 +Z2gmMJM506rcW/vDM+7ZdwMukvjzgHhpgu4yx1YlRrNsTTWUB4vXYK8FmpejvJ6t5fJ8kNhHR14p
 oFmJhkymfKZHipX6LRupiflsl5SgvuY81I8DL/vc4hJ0dGZ1O3iVXL8nul3xYAXFuxhY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RmKgmnr6pteA0V6oRFO0seT36SJWL7Ih5xJsQD4ns8M=; b=PZOjePcY/65L5ALhtv5GPraFWv
 u7n7rDe7qWub6jdulS41huKA6Y6mElKa5yMf6qkT55JUNuTKAXeZCELFc36Bn1djLmZUJ79zvhLHq
 G8ACQbLO3Yo/dTyt8STTeM4Msgy49r1lzyY2x7QngrBVRojsDZooN/0aBW1V1Ad8M8J0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uTlN9-0003Or-Sb for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Jun 2025 17:54:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 82EA344317;
 Mon, 23 Jun 2025 17:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15752C4CEEA;
 Mon, 23 Jun 2025 17:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750701253;
 bh=B4UqzSsFNEKMVyeR9dnUHb+/9U5jqoYKChK1+a2TXbE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=smPslhwrtnwyR82BRUIRCuzzFDDaMP1Y47PIXdCB/IbQDqdk4szxA7PJ/fYJ902QK
 MDIgYb8WqD72BcjNmCyzrPQhieTLr3OxncKu6bzmrlYpbx00ddGjEYoAGXC4zAL26U
 KNPg88cl+eHUYMRrQhCxKozzBVF+5CI5ZGWf9DfvvaRagqEyrzz1qWO30zAP1mLlJq
 eLOtUNN+3Efq4M6ZEg2yvG3aiJWiPpHxkr9SY6q7nLev9vgmdeT+wzj7ERKJPhU6e9
 bgBlHbLgqQmvyr60gEgFVW1KYtxu86zKB1fnchBaoLZkhHwGOuy0HaaYqEUIjSqYYh
 798EHzUeGceng==
Date: Mon, 23 Jun 2025 17:54:11 +0000
To: wangzijie <wangzijie1@honor.com>
Message-ID: <aFmUw46N1ibXcgIj@google.com>
References: <20250618064303.2477852-1-wangzijie1@honor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250618064303.2477852-1-wangzijie1@honor.com>
X-Headers-End: 1uTlN9-0003Or-Sb
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: don't allow unaligned
 truncation to smaller/equal size on pinned file
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
Cc: feng.han@honor.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi,

Please do sbi conversion first, and apply this change.

On 06/18, wangzijie wrote:
> To prevent scattered pin block generation, don't allow non-section aligned truncation
> to smaller or equal size on pinned file. But for truncation to larger size, after
> commit 3fdd89b452c2("f2fs: prevent writing without fallocate() for pinned files"),
> we only support overwrite IO to pinned file, so we don't need to consider
> attr->ia_size > i_size case.
> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>
> ---
> v3:
> - cover attr->ia_size == i_size case
> v2:
> - add comments and change a proper subject
> ---
>  fs/f2fs/file.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 6bd3de64f..9e0f1c98f 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1026,6 +1026,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  {
>  	struct inode *inode = d_inode(dentry);
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	int err;
>  
>  	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
> @@ -1047,6 +1048,17 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  			!IS_ALIGNED(attr->ia_size,
>  			F2FS_BLK_TO_BYTES(fi->i_cluster_size)))
>  			return -EINVAL;
> +		/*
> +		 * To prevent scattered pin block generation, we don't allow
> +		 * smaller/equal size unaligned truncation for pinned file.
> +		 * We only support overwrite IO to pinned file, so don't
> +		 * care about larger size truncation.
> +		 */
> +		if (f2fs_is_pinned_file(inode) &&
> +			attr->ia_size <= i_size_read(inode) &&
> +			!IS_ALIGNED(attr->ia_size,
> +			F2FS_BLK_TO_BYTES(CAP_BLKS_PER_SEC(sbi))))
> +			return -EINVAL;
>  	}
>  
>  	err = setattr_prepare(idmap, dentry, attr);
> -- 
> 2.25.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
