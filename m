Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868B0C83F25
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Jul 2025 17:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mSVZrU15wi/I59funNRrxWyxEPJUpWnbu8oHgHwjhhc=; b=cuUXhgAiLnbNealJ5Kmk42nogk
	BWqgYsY8rCJXgVf4pOnWdLmCkbaPN8p4z+VnCTHVpwbOJ7VuxuIPBOZZdv6xN9MSo1aGyAh0222S2
	E5n34zmLpjiUka8eGVsh317GWxTmUiAYKNKKwICwH4lSp6744UOpCEEa3hsUWo3dgXMI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uduCu-0006Dp-Dg;
	Mon, 21 Jul 2025 17:21:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1uduCs-0006Db-Ih
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Jul 2025 17:21:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XR5eNRtJQNShStNEOJ/AF7hb+YLHzTw2PvwfPF1yeAA=; b=bW6lZXJJi4OCBzL9LLgy26GxsI
 7+GHH6RPhMBB78txJwOGHJr8otgjONWtzIhG03jMN9zTRHHT96OwKqcVTSa4Xpymfo2kjPXFnd0Kl
 J9hWczkM/sfs+wSOZevhveEXeZvbbEouTVBRBp7rE+r16BN4iNBLyF4fXrW3BUqAdY/A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XR5eNRtJQNShStNEOJ/AF7hb+YLHzTw2PvwfPF1yeAA=; b=MqVhkbmTRhOCssXfm5dtWzRL/j
 /ksPl9sS/cD57Uott/DY75EdZaVlCP+Qfv8pQWSm+RiIKtjyvp8ofZBBD+16gnx739PPU9f1JLZs7
 65cz8bSQsjWKbrO8tLzXuMZsgF5VZZBv8th74q98ZSpmdhhUjevqoBDdzaMzV9J4Qs0s=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uduCs-0005TC-L5 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Jul 2025 17:21:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 43D955C4813;
 Mon, 21 Jul 2025 17:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41C1C4CEF4;
 Mon, 21 Jul 2025 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753118496;
 bh=9s7rQgyjBAgX1bh2xvIo6FiM/DYGBd5vVi5RZuquT1c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OD1Tj6ZnqcMm2LXliKEFnlj4Y8bEJ+0cIUZQeqWyuVCOKnhVZrQvJARUi9hz8jByM
 C1Lkklsmt3aXczcVrwPYyu6z/nN2p/9FKOg3mUEaitxIOJp4udbaGXaa0NlKU+DkpJ
 DCrVUks5C9Py7It6EMnIo0aAmdL7FN5R3GrzMtzw1FaQyEHB3fCi9TQEBgOHOpB6uo
 Gup5SW4qiFPCN8VUDF+IIhUv3tNAFRovFpGuQ7nJcA6cOnOWhbQd/Qw4DBqX6mHCTh
 jvWj93/GAEcRDS1j6F/EX15mvbl67fUOCxruirVRlyvLC71hDk082z6kiI9Q1gYq9B
 96NN06IrGRO0A==
Date: Mon, 21 Jul 2025 17:21:35 +0000
To: wangzijie <wangzijie1@honor.com>
Message-ID: <aH53HwGQd2CWOCFM@google.com>
References: <20250718100706.3948806-1-wangzijie1@honor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250718100706.3948806-1-wangzijie1@honor.com>
X-Headers-End: 1uduCs-0005TC-L5
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: avoid redundant clean nat entry
 move in lru list
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
Cc: linux-kernel@vger.kernel.org, feng.han@honor.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

I think it'd be better to add a parameter like __lookup_nat_cache(for_dirty).

On 07/18, wangzijie wrote:
> __lookup_nat_cache follows LRU manner to move clean nat entry, when nat
> entries are going to be dirty, no need to move them to tail of lru list.
> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>
> ---
>  fs/f2fs/node.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 4b3d9070e..b9fbc6bf7 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -460,7 +460,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
>  	struct nat_entry *new = __alloc_nat_entry(sbi, ni->nid, true);
>  
>  	f2fs_down_write(&nm_i->nat_tree_lock);
> -	e = __lookup_nat_cache(nm_i, ni->nid);
> +	e = radix_tree_lookup(&nm_i->nat_root, ni->nid);
>  	if (!e) {
>  		e = __init_nat_entry(nm_i, new, NULL, true);
>  		copy_node_info(&e->ni, ni);
> @@ -2926,7 +2926,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
>  
>  		raw_ne = nat_in_journal(journal, i);
>  
> -		ne = __lookup_nat_cache(nm_i, nid);
> +		ne = radix_tree_lookup(&nm_i->nat_root, nid);
>  		if (!ne) {
>  			ne = __alloc_nat_entry(sbi, nid, true);
>  			__init_nat_entry(nm_i, ne, &raw_ne, true);
> -- 
> 2.25.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
