Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFEBC02185
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jan 2025 05:27:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tZkJq-0002SU-AB;
	Mon, 20 Jan 2025 05:27:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tZkJp-0002SM-1B
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jan 2025 05:27:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SC/7SQWWSDG50DuYUJsbUuo+hkRZV4L8GHYuMNBlO+o=; b=LWtwJ4xmC5EXRwU0r/VvngfwfT
 pkYHgOqKzy3P+IJ5n9e9v9Oo5WgLcrbBdmRfcE9WtXTbaVTsimnareV/kaW1mAdmwd1LasOtXVBKy
 /qNM/0crz88aJZfdz53gBMGWWACtxLEQ+4yiokrEwxVcdpweL4gxyLTqsfRGWOo76ZX0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SC/7SQWWSDG50DuYUJsbUuo+hkRZV4L8GHYuMNBlO+o=; b=fFF6M0Wv5/dhJlmJj9eNvKWI5w
 D8wt9Z+e0b2MoRP9ZuWJgSI9wnZGKgaLqsuDo4fyVmXze9NJ5GTY7vycUBXUdhGqpeCrmRzMwTAc+
 JYG4lHXkx3sO/3Aap+zRNWAbP3fpWmhSW0uxLgLhs38GcUj0cT+95GfDReZy9PM2Yo6A=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tZkJo-0008DB-CO for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jan 2025 05:27:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 00AB8A40B3B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 20 Jan 2025 05:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D09C4CEDD;
 Mon, 20 Jan 2025 05:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737350833;
 bh=pzAwjPJxS6Eln+ye2RNva3/5+EU2r17j4VQfvjjRO5s=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=cuFrJRGv7Hp7+j1UEoNd1I5hRtHApQtO/QLbyiiXF6dzLnUGkVLVp6r7E34wN03N1
 Pvf3JMIEkrFZBXDPHiF9X3NnGKI3vxUCvU4YpoKPYOg6wk7n/AMutjDvY0bhXHINg8
 LmdzAPOVmYaI3nhx9jzYK4nkZaXvAUwgZFxgkiO8huJp1ClBT39YzYu3sO4hTRyAE9
 ifrgo5LTNaMyAZkZSE6Hh19flFcZaz9a0osmIFer4PyWnrVwntGF2CB5bA65OuG9hd
 POPItpvP4CoCe909tf4AkQpg/9JfxKR8YoJ2n/2kXjk8k3BcU/zIu4BTGRGhUV4gzg
 Bn9a1qPYHteLA==
Message-ID: <4e1348cc-9b91-40f0-b740-d26530fac6ce@kernel.org>
Date: Mon, 20 Jan 2025 13:27:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20250117220955.2482817-1-jaegeuk@kernel.org>
Content-Language: en-US
In-Reply-To: <20250117220955.2482817-1-jaegeuk@kernel.org>
X-Headers-End: 1tZkJo-0008DB-CO
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid trying to get invalid block
 address
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 1/18/25 06:09, Jaegeuk Kim via Linux-f2fs-devel wrote:
> In f2fs_new_inode(), if we fail to get a new inode, we go iput(), followed by
> f2fs_evict_inode(). If the inode is not marked as bad, it'll try to call
> f2fs_remove_inode_page() which tries to read the inode block given node id.
> But, there's no block address allocated yet, which gives a chance to access
> a wrong block address, if the block device has some garbage data in NAT table.
> 
> We need to make sure NAT table should have zero data for all the unallocated
> node ids, but also would be better to take this unnecessary path as well.
> Let's mark the faild inode as bad.
> 

Needs a fixes line?

Fixes: 0abd675e97e6 ("f2fs: support plain user/group quota")

Otherwise, it looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/namei.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 57d46e1439de..a278c7da8177 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -341,6 +341,7 @@ static struct inode *f2fs_new_inode(struct mnt_idmap *idmap,
>   	trace_f2fs_new_inode(inode, err);
>   	dquot_drop(inode);
>   	inode->i_flags |= S_NOQUOTA;
> +	make_bad_inode(inode);
>   	if (nid_free)
>   		set_inode_flag(inode, FI_FREE_NID);
>   	clear_nlink(inode);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
