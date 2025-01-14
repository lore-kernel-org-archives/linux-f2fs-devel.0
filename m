Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48FEE77188
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Jan 2025 04:29:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tXYY5-0001bE-Hj;
	Tue, 14 Jan 2025 04:29:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tXYY4-0001b6-5E
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Jan 2025 04:29:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4A7crRsvXX6P9yYY+XYwV47g9Z/iDTCeQb4Pb3D1w8w=; b=YnIteEecYJwvT9Sb0Dvaxx1PLw
 GtLqijyKEydgYjadnXpgHAG0wApAN4Cg7pWoLt7JKOY08kYbD2nll45zQ7u0nezd6aaVYTQHnF0Tx
 o0nIYx62uepKW6j6eHq602p3d6TGH6T9tW+grk2cPbGoGeR7Ihms5nCGV48ftE+tsg/c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4A7crRsvXX6P9yYY+XYwV47g9Z/iDTCeQb4Pb3D1w8w=; b=MmhuxG2f9FmcNRJFozV/ceCqTa
 RGd1Wxtt+xpH6z7BYhgq7dW4PRPcYadUBf0GL0k1AwQQb4R8N5QZp3kujQJJjGQCmyZ9DNqdVwS1E
 Suk5dub29Ksvz/XKXeY5Mt4CreMUF+auTViYoIGhYorW+iJf7w12Jtt3m8yO0XnrJBgE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tXYY2-0000p1-NM for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Jan 2025 04:29:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 86CB45C45AA;
 Tue, 14 Jan 2025 04:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36094C4CEDF;
 Tue, 14 Jan 2025 04:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736828937;
 bh=0jGIxZv0Zyyj2rLgdz0tL1vL9XOy1sV6rojo5ZNA8xQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=pMRwcPSjOrsKSWThTOHxCWmKyL8B95IrIsfYUbHJ4MiD748aZ0PqWgbB5TKakHwxh
 G95qYDBOoKcXWhB6STQ0BGOJf66QtoRglZ9diMlU2g7bvcKjG7J8OJMYIQIdo8LDRw
 yR67ZXOjHjKs3pmXlEFQpftpUfxhsOURNoySurBVdEw/2lVEJqLAtd0oewEAliDx3U
 djwKfqZjpZZBOJsPCUQWnStrzgj128ujzgJFThQbZYVheuTBnRhe2CMwPQYeQi9ycp
 nO0RE9JxYHv0aesvdxjOFyQuWQaJg1UFGgybV1MAi+OJl2mUAlXIX8hUkYCrTELx/+
 SnttZJbXI2KvA==
Message-ID: <8a8dbb83-134b-4545-9b37-9c0b5b2be972@kernel.org>
Date: Tue, 14 Jan 2025 12:28:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yi Sun <yi.sun@unisoc.com>, jaegeuk@kernel.org
References: <20241223081044.1126291-1-yi.sun@unisoc.com>
 <20241223081044.1126291-5-yi.sun@unisoc.com>
Content-Language: en-US
In-Reply-To: <20241223081044.1126291-5-yi.sun@unisoc.com>
X-Headers-End: 1tXYY2-0000p1-NM
Subject: Re: [f2fs-dev] [PATCH v4 4/4] f2fs: Optimize
 f2fs_truncate_data_blocks_range()
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, sunyibuaa@gmail.com,
 Hao_hao.Wang@unisoc.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 12/23/24 16:10, Yi Sun wrote:
> Function f2fs_invalidate_blocks() can process continuous
> blocks at a time, so f2fs_truncate_data_blocks_range() is
> optimized to use the new functionality of
> f2fs_invalidate_blocks().
> 
> Signed-off-by: Yi Sun <yi.sun@unisoc.com>
> ---
>   fs/f2fs/file.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 68 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 81764b10840b..9980d17ef9f5 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -612,6 +612,15 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
>   	return finish_preallocate_blocks(inode);
>   }
>   
> +static bool check_curr_block_is_consecutive(struct f2fs_sb_info *sbi,
> +					block_t curr, block_t end)

static inline bool is_consecutive_blkaddrs(block_t cur, block_t end)
{
	return cur == end || cur == end + 1;
}

But maybe we don't need to add this function, see below comments.

> +{
> +	if (curr - end == 1 || curr == end)
> +		return true;
> +	else
> +		return false;
> +}
> +
>   void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
> @@ -621,8 +630,27 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
>   	int cluster_index = 0, valid_blocks = 0;
>   	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
>   	bool released = !atomic_read(&F2FS_I(dn->inode)->i_compr_blocks);
> +	/*
> +	 * Temporary record location.
> +	 * When the current  @blkaddr and @blkaddr_end can be processed
> +	 * together, update the value of @blkaddr_end.
> +	 * When it is detected that current @blkaddr is not continues with
> +	 * @blkaddr_end, it is necessary to process continues blocks

I prefer not adding these comments into function, what about describing the 
details in commit message, instead, thoughts?

> +	 * range [blkaddr_start, blkaddr_end].
> +	 */
> +	block_t blkaddr_start, blkaddr_end;
> +	/*.
> +	 * To avoid processing various invalid data blocks.
> +	 * Because @blkaddr_start and @blkaddr_end may be assigned
> +	 * NULL_ADDR or invalid data blocks, @last_valid is used to
> +	 * record this situation.
> +	 */

Ditto,

What about using blkstart & blklen to record last consecutive block addresses, 
and using blklen to identify whether we need to call f2fs_invalidate_blocks() or
not?

> +	bool last_valid = false;
> +	/* Process the last @blkaddr separately? */
> +	bool last_one = true;
>   
>   	addr = get_dnode_addr(dn->inode, dn->node_page) + ofs;
> +	blkaddr_start = blkaddr_end = le32_to_cpu(*addr);
>   
>   	/* Assumption: truncation starts with cluster */
>   	for (; count > 0; count--, addr++, dn->ofs_in_node++, cluster_index++) {
> @@ -638,24 +666,60 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
>   		}
>   
>   		if (blkaddr == NULL_ADDR)
> -			continue;
> +			goto next;
>   
>   		f2fs_set_data_blkaddr(dn, NULL_ADDR);
>   
>   		if (__is_valid_data_blkaddr(blkaddr)) {
>   			if (time_to_inject(sbi, FAULT_BLKADDR_CONSISTENCE))
> -				continue;
> +				goto next;
>   			if (!f2fs_is_valid_blkaddr_raw(sbi, blkaddr,
>   						DATA_GENERIC_ENHANCE))
> -				continue;
> +				goto next;
>   			if (compressed_cluster)
>   				valid_blocks++;
>   		}
>   
> -		f2fs_invalidate_blocks(sbi, blkaddr, 1);

How about this? Can you change based on it?

		if (blkstart + blklen == blkaddr) {
			blklen++;
		} else {
			f2fs_invalidate_blocks(sbi, blkstart, blklen);
			blkstart = blkaddr;
			blklen = 1;
		}

> +
> +		if (check_curr_block_is_consecutive(sbi, blkaddr, blkaddr_end)) {
> +			/*
> +			 * The current block @blkaddr is continuous with
> +			 * @blkaddr_end, so @blkaddr_end is updated.
> +			 * And the f2fs_invalidate_blocks() is skipped
> +			 * until @blkaddr that cannot be processed
> +			 * together is encountered.
> +			 */
> +			blkaddr_end = blkaddr;
> +			if (count == 1)
> +				last_one = false;
> +			else
> +				goto skip_invalid;
> +		}
> +
> +		f2fs_invalidate_blocks(sbi, blkaddr_start,
> +					blkaddr_end - blkaddr_start + 1);
> +		blkaddr_start = blkaddr_end = blkaddr;
> +
> +		if (count == 1 && last_one)
> +			f2fs_invalidate_blocks(sbi, blkaddr, 1);
> +
> +skip_invalid:
> +		last_valid = true;
>   
>   		if (!released || blkaddr != COMPRESS_ADDR)
>   			nr_free++;
> +
> +		continue;
> +
> +next:

next:

		if (blklen) {
			f2fs_invalidate_blocks(sbi, blkstart, blklen);
			blkstart = blkaddr;
			blklen = 1;
		}

> +		/* If consecutive blocks have been recorded, we need to process them. */
> +		if (last_valid == true)
> +			f2fs_invalidate_blocks(sbi, blkaddr_start,
> +					blkaddr_end - blkaddr_start + 1);
> +
> +		blkaddr_start = blkaddr_end = le32_to_cpu(*(addr + 1));
> +		last_valid = false;
> +
>   	}

	if (blklen)
		f2fs_invalidate_blocks(sbi, blkstart, blklen);

Thanks,

>   
>   	if (compressed_cluster)



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
