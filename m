Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EEDC3DA49
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Jul 2024 16:56:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sX1l9-0002Oe-OU;
	Thu, 25 Jul 2024 16:56:07 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1sX1l8-0002OQ-KV
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Jul 2024 16:56:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A3KSPH92gJnrZINngSx+tFvTFkYKZMPPrnYLmePWIn4=; b=GaEbcSgv06p/ZasxV2PdmwjBLq
 P822gc7O1LAqMEXuqZu5vU/GHFuSJNNrnpTAOHeb9WLOV/+TUooeDlmI9dhHLKEZV1DBGc01BYcsI
 0NDxTwtxF6ZCCOq6HX8rAGHnMJMhlKozM/MFjUaVwHvyBFxb9CS1zyNdoLSlSbDzpnu8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=A3KSPH92gJnrZINngSx+tFvTFkYKZMPPrnYLmePWIn4=; b=LxSw3znOPmX5NT7BUExAlavA9h
 JdIcgMLtuGLq6kVLolcxZKIl4D8iAgoicbgDs65QgRjHBYC9yQSYmhCKr+x7u1uvnQbIb7rZ+Gtp/
 ixIJdoCKNiaaMKo/JZkv/kqAkKmI8PauFvQWXaE9VBU+vrzeIFaqL+YnxazNlbLigeUU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sX1l7-0005hA-T5 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Jul 2024 16:56:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 88C1E612F4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 25 Jul 2024 16:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19451C116B1;
 Thu, 25 Jul 2024 16:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721926560;
 bh=drnhCfnqjtD+uKAYvYSo4Q1c4Rbt5tbKQljMuGKzJ6U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pNovAvLKrIJ5tPWI659ETbgg8B0whNU1i57au3u9kQZUJlhEWJBTPYzCajMWxYAyj
 mlRttOQuTGF9bDYXZsW3y0wUAz+Kz/42X3Al19j0ewzERKICj+hHVnF1OWamLfwi/x
 smKEQMqac+d5A+DRIL+9IPuHnb9KvtMMjHkgaSzoHGO94mK5s9zQaW5vXDRnne9wky
 BxzgtRN8dSI5Rfu4FKbFyMILra+r8UBhM1VrSPQdkW4JiJtGCntqBqkw8Rqr5TCXaK
 ZS08m1vPfWa1vBAWsDVHmAxzjhv/iqx6UUX1CP0YcencfCRRXhBY36OwbPT9pD3pq6
 CMnS7GiqljFxw==
Date: Thu, 25 Jul 2024 16:55:58 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <ZqKDnpzwX85RyGaa@google.com>
References: <20240712073415.227226-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240712073415.227226-1-chao@kernel.org>
X-Headers-End: 1sX1l7-0005hA-T5
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't traverse directory blocks after
 EOF
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/12, Chao Yu wrote:
> All directory blocks are within the scope of i_size, so let's limit
> the end_block to just check valid dirent blocks.

Do we really need this?

> 
> Meanwhile, it uses dir_blocks() instead of variable for cleanup in
> __f2fs_find_entry().
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/dir.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 02c9355176d3..d4591c215f07 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -305,18 +305,21 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
>  	int s = GET_DENTRY_SLOTS(fname->disk_name.len);
>  	unsigned int nbucket, nblock;
>  	unsigned int bidx, end_block;
> +	unsigned long last_block;
>  	struct page *dentry_page;
>  	struct f2fs_dir_entry *de = NULL;
>  	pgoff_t next_pgofs;
>  	bool room = false;
>  	int max_slots;
>  
> +	last_block = dir_blocks(dir);
>  	nbucket = dir_buckets(level, F2FS_I(dir)->i_dir_level);
>  	nblock = bucket_blocks(level);
>  
>  	bidx = dir_block_index(level, F2FS_I(dir)->i_dir_level,
>  			       le32_to_cpu(fname->hash) % nbucket);
>  	end_block = bidx + nblock;
> +	end_block = min_t(unsigned int, end_block, last_block);
>  
>  	while (bidx < end_block) {
>  		/* no need to allocate new dentry pages to all the indices */
> @@ -361,7 +364,6 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
>  					 const struct f2fs_filename *fname,
>  					 struct page **res_page)
>  {
> -	unsigned long npages = dir_blocks(dir);
>  	struct f2fs_dir_entry *de = NULL;
>  	unsigned int max_depth;
>  	unsigned int level;
> @@ -373,7 +375,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
>  		goto out;
>  	}
>  
> -	if (npages == 0)
> +	if (dir_blocks(dir) == 0)
>  		goto out;
>  
>  	max_depth = F2FS_I(dir)->i_current_depth;
> -- 
> 2.40.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
