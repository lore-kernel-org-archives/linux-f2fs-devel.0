Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DD1CAC58E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Sep 2025 08:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0wNwLu9eGGDYca36t/0bXelIohNzz5GgzDqQPd6OwIk=; b=YpPMF7wdMY/4/AmKGqmOsRr2w7
	xfuzpruHSzG/yWekjZDA9JkzkkHKEvTip/cNlvpwKwGke8FgCyH6vlCvbFQnw/TfIOna5TWDGxTJs
	l+/+RQFBQzVGzPwLZ6qv75RMzA0+rmJTzclbEGjmSOqxpfiunwmwIJvUT1d1Y8ZqY+gc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uy4Dx-000752-Ga;
	Mon, 15 Sep 2025 08:06:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uy4Db-00074G-JG
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Sep 2025 08:05:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VGJ+ilx00n8lE3/5bGU9rEeEfQHoq0g/GsqoZFzF21M=; b=i9uHxexFgjbbEhfQm06q75/bOh
 XY2rivHH1CeH8z9vjlTZiuPZ2k/VIW6qdsUGQs99+o1k4//jTOxovq3n+HE7fZ95ibQc/bzJ/8uei
 ZoKD1DK5U/0FEj5prGp+BdnLtIWi/qMxhZ0lYJYpYfPAcYwzEu9492oLOnJF6C9wKi8E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VGJ+ilx00n8lE3/5bGU9rEeEfQHoq0g/GsqoZFzF21M=; b=FaUmsh8vKI+hbC/RHb6PihAr0/
 Vl2Wjnv4tTDWnpP/U6NLj5cWq101tqLyu27R62HJQiiqVw3RgvwZuFFQszQPixH3Ovbu5SJmedStY
 GofPpcmoHWdn7As/k/W6v1c480vNoqQuJFxWVG004S1/3jZqmRJUaEIjyi274GBR5ORg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uy4Db-00074U-3o for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Sep 2025 08:05:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E7BB60195;
 Mon, 15 Sep 2025 08:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F67C4CEF1;
 Mon, 15 Sep 2025 08:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757923540;
 bh=lzzHpXrl4T+O1eFsZmhBzn3Qp59jklkv+WRQqIpRaxo=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=RMJEH/fppeez5XHLej251shsdGH3YLaGuO/xeYNuD0mxteNCLH4kw6YERzIxbgOhE
 cqTjx1hHQYbBT/ah8bGX5rHmjv7zdfi5x++4YXC9U8Nkn+B92dI94DlXT/MTTrRAsx
 vqMESklN65bpJy8NkY6LA4HDjAihzl6lWZTcAsb/qPM8vho3rCCkInTR9YUIpFnSu8
 EApV+OKHD3z/pKUa6SbkXMEtfN12LxJ3u+Gqx+2gKNOVY3HEOopsn97pILJpnM+aNp
 MjqLh3iO2LbmF5IQskxI6A+StEI0grnoE3lAbXdwSiwP9iTBbV1rQ5ecC+ycJZMTRF
 k1BVMWt5toZ4A==
Message-ID: <2f1c3f5f-7ab2-4b11-8368-b9c925cbea7c@kernel.org>
Date: Mon, 15 Sep 2025 16:05:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: wangzijie <wangzijie1@honor.com>, jaegeuk@kernel.org
References: <20250915035246.98055-1-wangzijie1@honor.com>
Content-Language: en-US
In-Reply-To: <20250915035246.98055-1-wangzijie1@honor.com>
X-Headers-End: 1uy4Db-00074U-3o
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: fix zero-sized extent for
 precache extents
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
> Script to reproduce:
> f2fs_io write 1 0 1881 rand dsync testfile
> f2fs_io fallocate 0 7708672 4096 testfile
> f2fs_io write 1 1881 1 rand buffered testfile
> fsync testfile
> umount
> mount
> f2fs_io precache_extents testfile
> 
> When the data layout is something like this:
> dnode1:                     dnode2:
> [0]      A                  [0]    NEW_ADDR
> [1]      A+1                [1]    0x0
> ...
> [1016]   A+1016
> [1017]   B (B!=A+1017)      [1017] 0x0
> 
> During precache_extents, we map the last block(valid blkaddr) in dnode1:
> map->m_flags |= F2FS_MAP_MAPPED;
> map->m_pblk = blkaddr(valid blkaddr);
> map->m_len = 1;
> then we goto next_dnode, meet the first block in dnode2(hole), goto sync_out:
> map->m_flags & F2FS_MAP_MAPPED == true, and we make zero-sized extent.
> 
> Rebased on patch[1], this patch can cover these cases to avoid zero-sized extent:
> A,B,C is valid blkaddr
> case1:
> dnode1:                     dnode2:
> [0]      A                  [0]    NEW_ADDR
> [1]      A+1                [1]    0x0
> ...                         ....
> [1016]   A+1016
> [1017]   B (B!=A+1017)      [1017] 0x0
> 
> case2:
> dnode1:                     dnode2:
> [0]      A                  [0]    C (C!=B+1)
> [1]      A+1                [1]    C+1
> ...                         ....
> [1016]   A+1016
> [1017]   B (B!=A+1017)      [1017] 0x0
> 
> case3:
> dnode1:                     dnode2:
> [0]      A                  [0]    C (C!=B+2)
> [1]      A+1                [1]    C+1
> ...                         ....
> [1015]   A+1015
> [1016]   B (B!=A+1016)
> [1017]   B+1                [1017] 0x0
> 
> [1] https://lore.kernel.org/linux-f2fs-devel/20250912081250.44383-1-chao@kernel.org/
> 
> Fixes: c4020b2da4c9 ("f2fs: support F2FS_IOC_PRECACHE_EXTENTS")
> Signed-off-by: wangzijie <wangzijie1@honor.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
