Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2D0CD98C7
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jweqOANqgEdBA2ys9p8ODDbmHRtzs3D7x02qsjn4bXY=; b=BABvYxkChhEgQr5/e2C3WLDBw7
	UE0+jQeFagNbZelahdUaQ+KHCLXVXYEqVXYt2qxzf9KCm3OS3RRjl3ksXQzOXIrWZM7ekDkmaEcao
	mbMd8eoAZKonocXhdexrzUoKnehVC8vh9NeWHFjPKcd2p7/MNopVWBIDzOELWkJYRiho=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZ5vG-0007Gw-Sf;
	Mon, 15 Jun 2026 11:56:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wZ5vF-0007Gg-AU
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 11:56:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lHE12hWg1VCuFKpHq9M5SnHiQq3LVPF6YJTacpmSnRM=; b=SCHANYeMSuo2TvVGg7Q5v2mGKW
 PC6G0u+SLBasuJIIDVDompaGW2DA9Rnq0VWDOAOBEiFbIzq57UmbZmnAKsH9hwISGMZUoteENQgPW
 jMxJMOHjFFhFO5LM5IMSueSpPhsekxfyQaSxy/3ndfP1H3e6E2wEMoi5XUEsyZh9Ij0A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lHE12hWg1VCuFKpHq9M5SnHiQq3LVPF6YJTacpmSnRM=; b=NuzX26ni1oJELrYZqBqI9V3dOk
 Mt9iNPzA1Reu1BFytT0ZYQTe/ifoMkWswPFtXoUArzWkCepFZ/UkTDP/G3zZgfp0xEYuGZJ/YsUJq
 EHmZbBfZau4QYgMZLb+bUwHJDuOapaBwl7L35HcpVjUUrN7Uk01lrLn/VUb6rgEu3Dsc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZ5vE-0000yG-6r for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 11:56:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2278543BAD;
 Mon, 15 Jun 2026 11:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5291F000E9;
 Mon, 15 Jun 2026 11:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781524558;
 bh=lHE12hWg1VCuFKpHq9M5SnHiQq3LVPF6YJTacpmSnRM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Z0t6pr6ZBpxlJK8ebT8HNU827b0nN+Cm5Vhv1iXlnsaEeVzK+k9hhfTadHmmRxD4H
 YldXaoPaNHlbbu8p9sBbCOwsO9kpVryTgeIj5MHyPmKBoiIQq+9zMXe0dUnQc3TwYH
 edAIVG2CtVHyux7OojOgVx71y1+36aEbOPZiEsz0tkYQ25Pfv17jHyHqvIuHOlWbPB
 2B+H99fOGQwjyO006Rto80+3QmvbyZ+0BFOTsYHhdO3mdMWMbI0JZYofjqilT6rws0
 3FU/D9/8KOn9pFKr9Ktq9ZL9XVxs5/F/13YbI7OkVdFf5kxYT7QMNlubC3fft1OUg0
 uArtM/wpYJ/XA==
Message-ID: <7ffe0789-1024-4dc7-9089-2dcf856a1bd1@kernel.org>
Date: Mon, 15 Jun 2026 19:55:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260612115839.2065903-2-yangyongpeng.storage@gmail.com>
 <20260612115839.2065903-3-yangyongpeng.storage@gmail.com>
Content-Language: en-US
In-Reply-To: <20260612115839.2065903-3-yangyongpeng.storage@gmail.com>
X-Headers-End: 1wZ5vE-0000yG-6r
Subject: Re: [f2fs-dev] [PATCH RESEND 2/5] f2fs: only initialize largest
 extent without extent_node at inode init
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/12/26 19:58, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> The largest extent takes effect during both read mapping and write
> mapping lookups, while read mapping does not need to access the
> extent_node. For write mapping, the case where the largest extent is
> not in the extent tree can already be handled by the merge logic, and
> cases that cannot be merged do not require the largest extent to
> participate either.
> 
> Therefore, the largest extent does not need to initialize a
> corresponding extent_node, reducing memory footprint.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
> ---
>  fs/f2fs/extent_cache.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index aa368a01b035..f8d94db60dc6 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -410,10 +410,8 @@ static void __drop_largest_extent(struct extent_tree *et,
>  void f2fs_init_read_extent_tree(struct inode *inode, struct folio *ifolio)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> -	struct extent_tree_info *eti = &sbi->extent_tree[EX_READ];
>  	struct f2fs_extent *i_ext = &F2FS_INODE(ifolio)->i_ext;
>  	struct extent_tree *et;
> -	struct extent_node *en;
>  	struct extent_info ei = {0};
>  
>  	if (!__may_extent_tree(inode, EX_READ)) {
> @@ -435,21 +433,7 @@ void f2fs_init_read_extent_tree(struct inode *inode, struct folio *ifolio)
>  	if (atomic_read(&et->node_cnt) || !ei.len)
>  		goto skip;
>  
> -	if (IS_DEVICE_ALIASING(inode)) {
> -		et->largest = ei;
> -		goto skip;
> -	}
> -
> -	en = __attach_extent_node(sbi, et, &ei, NULL,
> -				&et->root.rb_root.rb_node, true);
> -	if (en) {
> -		et->largest = en->ei;
> -		et->cached_en = en;
> -
> -		spin_lock(&eti->extent_lock);
> -		list_add_tail(&en->list, &eti->extent_list);
> -		spin_unlock(&eti->extent_lock);
> -	}
> +	et->largest = ei;

Previously, we can split largest extent node to two if we punched it, now
we can not? IIUC.

Thanks,

>  skip:
>  	/* Let's drop, if checkpoint got corrupted. */
>  	if (f2fs_cp_error(sbi)) {



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
