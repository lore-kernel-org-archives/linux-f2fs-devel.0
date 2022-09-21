Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B6FECAAD8
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Sep 2022 10:41:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oaxAO-00045N-Gv;
	Wed, 21 Sep 2022 10:41:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oaxAM-00045H-Qs
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Sep 2022 10:41:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eJU2usmXJGdV3wO+8/gRJAKZIVA2T+sCQ/FFwIK3MR0=; b=jiJ7bjKauQ2vT/pNeShGWEy3UN
 VqdU6uBFtPaihYikin4Fd8FDphmTUGjJLGVPQLFNS9IqT0k/8fPna+ajw6nJp9SnT9yubf20UjeDT
 pqQCLZrYHIe7nlWSfKjVf5+KIuNbyenRmlNNQWYetiabeKFZJiVUq2kHzBm15pDhQrXI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eJU2usmXJGdV3wO+8/gRJAKZIVA2T+sCQ/FFwIK3MR0=; b=mODzKIST1h/VC87B0NvzqK+ky3
 e4mmtJu05eOeh0V0JpGpptABzz5aLy4CUf9QUd7a1gn86slp4bP5/QdxFpOufsDTWZhZMXImPkptQ
 I5p4Dn9E64ATDAQqFtNZy/NxI53OyEoJxGcC178pwo5w3AZmLZUIyiHCI8bKCz5GgBaY=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oaxAA-0004mJ-5a for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Sep 2022 10:41:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0D850B8125A;
 Wed, 21 Sep 2022 10:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC774C433C1;
 Wed, 21 Sep 2022 10:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663756853;
 bh=Unou6dJypA8TbSFtVWp435xfrPCys+Lv/Ab6enr0b+8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tLn9MrWGJeS7oI9rtQhXQ0C6O5+OjOpUJdFWFtlWvyQB933BnLFbfP1o+raDAbDau
 TF8F7EOb6WgFNXTATCxz3me5CgaceG1L7MmSg3WBQgerv60/Vvlrd9pPi/mX4upG8I
 kldhR4IKaTfDz5leNtjdUX4BvgAw6TlrnPSHnaayE/OYZaubtV3DwD/bxl2NwqiyOO
 Id33LzC99h7OE8b6yGklicVAKd7m2yy2O4fmLHFS7ahBe1uFUWdEXGDv0e6nFU2xMv
 jUtFdCDved4h9/x0jJRHWWY5EXkAB+LFKo3KMDmnxVf/6oTAo3wEpD01+HjSHPwiXV
 UGisCXk+Ie5JQ==
Message-ID: <3e008fac-7276-31e9-7c78-c4237b8aa4ef@kernel.org>
Date: Wed, 21 Sep 2022 18:40:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To: Zhang Qilong <zhangqilong3@huawei.com>, jaegeuk@kernel.org
References: <20220921075737.36708-1-zhangqilong3@huawei.com>
 <20220921075737.36708-3-zhangqilong3@huawei.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220921075737.36708-3-zhangqilong3@huawei.com>
X-Headers-End: 1oaxAA-0004mJ-5a
Subject: Re: [f2fs-dev] [PATCH -next 2/4] f2fs: extent cache: support extent
 for no-compressed file
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/9/21 15:57, Zhang Qilong wrote:
> No-compressed file may suffer read performance issue due to it can't
> use extent cache or the largest extent in inode can't covered other
> parts of continuous blocks in readonly format f2fs image.
> 
> Now it won't build extent cacge tree for no-compressed file in
> readonly format f2fs image.
> 
> For readonly format f2fs image, maybe the no-compressed file don't
> have the largest extent, or it have more than one part which have

Why it can not have largest extent in f2fs_inode?

Thanks,

> internally continuous blocks. So we add extent cache tree for the
> no-compressed file in readonly format f2fs image.
> 
> The cache policy is almost same with compressed file. The difference
> is that, the no-compressed file part will set min-number of continuous
> blocks F2FS_MIN_EXTENT_LEN in order to reduce cache fragmentation.
> 
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>   fs/f2fs/extent_cache.c | 52 ++++++++++++++++++++++++++++++++++--------
>   1 file changed, 42 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 387d53a61270..7e39381edca0 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -695,9 +695,12 @@ static void f2fs_update_extent_tree_range_compressed(struct inode *inode,
>   	set_extent_info(&ei, fofs, blkaddr, llen);
>   	ei.c_len = c_len;
>   
> -	if (!__try_merge_extent_node(sbi, et, &ei, prev_en, next_en))
> +	if (!__try_merge_extent_node(sbi, et, &ei, prev_en, next_en)) {
> +		if (!c_len && llen < F2FS_MIN_EXTENT_LEN)
> +			goto unlock_out;
>   		__insert_extent_tree(sbi, et, &ei,
>   				insert_p, insert_parent, leftmost);
> +	}
>   unlock_out:
>   	write_unlock(&et->lock);
>   }
> @@ -726,24 +729,53 @@ static unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn)
>   	return compressed ? i - 1 : i;
>   }
>   
> +/*
> + * check whether normal file blocks are contiguous, and add extent cache
> + * entry only if remained blocks are logically and physically contiguous.
> + */
> +static unsigned int f2fs_normal_blocks_are_contiguous(struct dnode_of_data *dn)
> +{
> +	int i = 0;
> +	struct inode *inode = dn->inode;
> +	block_t first_blkaddr = data_blkaddr(inode, dn->node_page,
> +						dn->ofs_in_node);
> +	unsigned int max_blocks = ADDRS_PER_PAGE(dn->node_page, inode)
> +					- dn->ofs_in_node;
> +
> +	for (i = 1; i < max_blocks; i++) {
> +		block_t blkaddr = data_blkaddr(inode, dn->node_page,
> +				dn->ofs_in_node + i);
> +
> +		if (!__is_valid_data_blkaddr(blkaddr) ||
> +				first_blkaddr + i != blkaddr)
> +			return i;
> +	}
> +
> +	return i;
> +}
> +
>   void f2fs_readonly_update_extent_cache(struct dnode_of_data *dn,
>   					pgoff_t index)
>   {
> -	unsigned int c_len = f2fs_cluster_blocks_are_contiguous(dn);
> +	unsigned int c_len = 0;
> +	unsigned int llen = 0;
>   	block_t blkaddr;
>   
> -	if (!c_len)
> -		return;
> -
>   	blkaddr = f2fs_data_blkaddr(dn);
> -	if (blkaddr == COMPRESS_ADDR)
> -		blkaddr = data_blkaddr(dn->inode, dn->node_page,
> +	if (f2fs_compressed_file(dn->inode)) {
> +		c_len = f2fs_cluster_blocks_are_contiguous(dn);
> +		if (!c_len)
> +			return;
> +		llen = F2FS_I(dn->inode)->i_cluster_size;
> +		if (blkaddr == COMPRESS_ADDR)
> +			blkaddr = data_blkaddr(dn->inode, dn->node_page,
>   					dn->ofs_in_node + 1);
> +	} else {
> +		llen = f2fs_normal_blocks_are_contiguous(dn);
> +	}
>   
>   	f2fs_update_extent_tree_range_compressed(dn->inode,
> -				index, blkaddr,
> -				F2FS_I(dn->inode)->i_cluster_size,
> -				c_len);
> +				index, blkaddr, llen, c_len);
>   }
>   #endif
>   


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
