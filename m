Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F41CCAC598
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Sep 2025 12:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J1QrHeh3MuMXSN4HxVJsLiEEw8I+aamFD9rcRXRUcbI=; b=a60+MjHlrgcMobjQdBD8iWXVdv
	2HOE3S8cbZUEEKLzBwoD8RpVG/FExRRVB/Kg3lPEWX2FKTBwtFBJw0TFDXnbrH1cagyImDGPdtrw8
	+BDxxgcOruP5fw7HJXcDn+pzIPuheEpl3FGVMXLepwJ3xVz14dEZ8hNdauw7vGkN71/U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uyUY8-0001Tf-Cg;
	Tue, 16 Sep 2025 12:12:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uyUY6-0001TX-9I
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Sep 2025 12:12:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2O5sPItuXD3R9uD3/mSN3CMQvqllEY9YDvdM5fwdW1w=; b=OkeEOvmd4Ox/KmUnAqepT9/H22
 MnxQw5Hl2z4BW17hisVzQGK+yaeTDJyF2Mf0JSORp+L2ko55x3bJAAaJHd+GyJzMoNXEpEhGp77Kj
 dc7FHzPcAIiNWFDeh2YF8yvn0NSHGHbf8uILbZI0u6jJycbAE3yNMLdWueoa3C+jwr6E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2O5sPItuXD3R9uD3/mSN3CMQvqllEY9YDvdM5fwdW1w=; b=ikxBZ7k2k7wSSErtCu0wPV823k
 Cq1972//RxGE+hIRAg1pQYkNSS7B09FLjcKRym/Gmyfb/5b5Nuy83kW4utwgMZkpVyYOUulBMY72Z
 F/4hRVBFwHl8JyGT1YvtkzQmlS7W6cIVfL6nvyUif8ygpWLfcEXUpPgbU5wNg7MYlcng=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uyUY5-0006V7-UA for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Sep 2025 12:12:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 901A444A77;
 Tue, 16 Sep 2025 12:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3F8C4CEEB;
 Tue, 16 Sep 2025 12:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758024751;
 bh=hiXSWzOiLhbz/0pwI+JJnR5U2ggEanH7kVkF3wl+d2g=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=Z6o5n9q8YjO9Rz5PItEdYUznt8kXuXdGCBIDrPVXDXBRz/MIh6taeVUZSkzvJ597y
 Mbm1F+/78/i9YwkPU3LeVgPWmP+ROhuqC65FIvQjqOOs4E5EL+erH3QGnILcD1Yq2I
 8V+r4Xmnc8ION2Z+ZR6ki3Vrr28i2iI9WkW5T7g+boRpT26909Eg5+NOQk91kgHLHj
 4aGeKai14dC3XoWljOv8xbebYqXMvqkCZqxaTtbxzcl0XHIcxrp7v/VyXwjXNSi5ZG
 8TRm63KZGzauivwYq7Spd3ymX4FQmaJtBz86juUcR5RjnwxBWOY6+Q3/G9lZE0O7dp
 J16ugFZDuOIBQ==
Message-ID: <1f80bc3f-845f-49f4-93d7-cc1be8a781f5@kernel.org>
Date: Tue, 16 Sep 2025 20:12:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: wangzijie <wangzijie1@honor.com>, jaegeuk@kernel.org
References: <20250915035246.98055-1-wangzijie1@honor.com>
 <20250915035246.98055-2-wangzijie1@honor.com>
Content-Language: en-US
In-Reply-To: <20250915035246.98055-2-wangzijie1@honor.com>
X-Headers-End: 1uyUY5-0006V7-UA
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: fix infinite loop in
 __insert_extent_tree()
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
Cc: linux-kernel@vger.kernel.org, feng.han@honor.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/15/25 11:52, wangzijie wrote:
> When we get wrong extent info data, and look up extent_node in rb tree,
> it will cause infinite loop (CONFIG_F2FS_CHECK_FS=n). Avoiding this by
> return NULL.
> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>
> ---
>  fs/f2fs/extent_cache.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 199c1e7a8..6ed6f3d1d 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -605,6 +605,7 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
>  			leftmost = false;
>  		} else {

Need to print some messages here as Jaegeuk suggested, IIUC.

Thanks,

>  			f2fs_bug_on(sbi, 1);
> +			return NULL;
>  		}
>  	}
>  



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
