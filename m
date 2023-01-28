Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FECAC27C76
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 28 Jan 2023 10:47:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pLikD-0003RR-CR;
	Sat, 28 Jan 2023 10:47:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pLikB-0003RL-K8
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 28 Jan 2023 10:47:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H5lViOlkual+weBfDIfoABAI6JfDgOsLzlFwESpj6yc=; b=gZEKy2Xlp3DOut4rg464Sp48Uh
 brWxDi0fOxkGMNMgJVXduNq4j+2qC4D+iwgHEQbauxgbQhONCvYRaEIV4hr613p8hHawZMxfSju/t
 HMHSnR0JhPvhnatvmOO5j+5uZX2OxuKg+a0fAXXQJg1bKNpCB/hYbAgA9rMmuC5Z18Kk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H5lViOlkual+weBfDIfoABAI6JfDgOsLzlFwESpj6yc=; b=iy39QvFJMF3lDHZd4DM2mELJM2
 kpGqQocxvIEBFHZZ47W2Wf/seaYHdCs36r97leJZ542jitjI3UByvcOijYKnpW08TRqG55193HMA1
 uMNKuWrhVt2cORKrRd0Q8r5WWehWJW0YTQgkCwfe4ken2mx3/+uWaQMOr5eh8ea+JOp0=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pLik9-001b4F-8t for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 28 Jan 2023 10:47:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id EDCD8B8070E;
 Sat, 28 Jan 2023 10:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D908C4339C;
 Sat, 28 Jan 2023 10:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674902845;
 bh=j+QQ4frfhd7/U0TPowl8ebCAvIfb0w0dfp7JE+JYjRo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pAa7xA40quWdCu7YlXGQKkTzBURq1QW0vhAUs/6YcBnHM+AJWNCHV4lV160Xss6QJ
 pUmlNCefuRulFCCFHP4u7YuPTDtkcNLtgmMk3puAiEKkf0KFF3gKc5SNbiE+5rSYGL
 9Rp8ME61GjMNvjRY0FlkrzjdkCEI54mX2zykaI/qXH+iILeaWHUx0aoU/rEIHYNZaA
 5l8XFnS6qAWdOEv73K4WT4h6CBCw9zVwMRU/MXa2WxrMiEu1owjhVMGxDQFbYDq+o5
 43PwpJm87q+APDi13U+PW0Bnj/4ViJIDUoowf3fdXi+OWUyNym9S7E7RyOeEzMrHOR
 lpAK1koaWjClg==
Message-ID: <1bd219f7-4990-f0dc-fe07-b434726161e2@kernel.org>
Date: Sat, 28 Jan 2023 18:47:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20230112142213.22784-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230112142213.22784-1-frank.li@vivo.com>
X-Headers-End: 1pLik9-001b4F-8t
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce sanity_check_blocks()
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

On 2023/1/12 22:22, Yangtao Li wrote:
> There are very similar codes in release_compress_blocks() and
> reserve_compress_blocks() which is used for data blocks check.
> 
> This patch introduces a new helper sanity_check_blocks()
> to include those common codes, and used it instead for cleanup.

How about reusing f2fs_sanity_check_cluster()? Something like:

bool f2fs_sanity_check_cluster()

	if (compressed_cluster)
		f2fs_sanity_check_compressed_cluster()
	else
		f2fs_sanity_check_normal_cluster()

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/file.c | 36 ++++++++++++++++++++----------------
>   1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index f5c1b7814954..0d539155379c 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3369,11 +3369,9 @@ static int f2fs_get_compress_blocks(struct file *filp, unsigned long arg)
>   	return put_user(blocks, (u64 __user *)arg);
>   }
>   
> -static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
> +static int sanity_check_blocks(struct dnode_of_data *dn, pgoff_t count)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
> -	unsigned int released_blocks = 0;
> -	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
>   	block_t blkaddr;
>   	int i;
>   
> @@ -3390,6 +3388,21 @@ static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
>   		}
>   	}
>   
> +	return 0;
> +}
> +
> +static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
> +	unsigned int released_blocks = 0;
> +	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
> +	block_t blkaddr;
> +	int i, rc;
> +
> +	rc = sanity_check_blocks(dn, count);
> +	if (rc)
> +		return rc;
> +
>   	while (count) {
>   		int compr_blocks = 0;
>   
> @@ -3539,20 +3552,11 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
>   	unsigned int reserved_blocks = 0;
>   	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
>   	block_t blkaddr;
> -	int i;
> +	int i, rc;
>   
> -	for (i = 0; i < count; i++) {
> -		blkaddr = data_blkaddr(dn->inode, dn->node_page,
> -						dn->ofs_in_node + i);
> -
> -		if (!__is_valid_data_blkaddr(blkaddr))
> -			continue;
> -		if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
> -					DATA_GENERIC_ENHANCE))) {
> -			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> -			return -EFSCORRUPTED;
> -		}
> -	}
> +	rc = sanity_check_blocks(dn, count);
> +	if (rc)
> +		return rc;
>   
>   	while (count) {
>   		int compr_blocks = 0;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
