Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14817C79F9E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Sep 2026 00:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DQ44Wpj7l8b0yh94NFOnde2fzAGN/jIP8MmZN4g4KDY=; b=hq8tYzlE8PVT31KwhFt39/MCL/
	H4Owtk+DeWCAm2bzZoBVyjBXo+jeGMhu+g/ndR1UDTBXneQZ1zL91nSKAllmunYgHgnTxLpE3rX8O
	yezXZ3SZgZnonzJLof3DJtMKKFiXlD39Pn85Sk9seIOwRVpEXj+9xR4JIXyFxg7g8iD0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3jVM-000524-Ij;
	Tue, 08 Sep 2026 00:16:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x3jVL-00051f-4m
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 00:16:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u6vi8Rb6/gBzlGLkta4lZeRt2WHuRcBjCNqaFrwusn8=; b=Y9yLwokRyo1/VHsWFfN6dxLeq0
 +z0Eq4GrAg/z5UjEQGUL4yy5bMIcKpKeXFz3GXer9PYRYz9WKpPdHs9PbM5wwImJ0tVBuGVrVwZwY
 lBrw6VHOAFdYbCh8C+gOfKXxVRN49K33OrEygVWq6OiFZsIGWn0ry97dDV6tVuW16QOY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=u6vi8Rb6/gBzlGLkta4lZeRt2WHuRcBjCNqaFrwusn8=; b=caAplBPKi5qZFMqm8Oi5jKFHvp
 iw3VF9bJuFp9gtwoWE4k4Oiq0OtPsmfGh33k+6S5uP6XPmKukS1XEJMpLgOJmhk/WbrdzFwOrl3mJ
 n58UbckZk7HD0BPOdo27+VroXopOrBgr2Joq26eYPctyn7ixNU1QgxKeXwgvpNM9P0TE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3jVH-00008O-7r for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 00:16:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 98B9C601DB;
 Tue,  8 Sep 2026 00:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DA21F00A3A;
 Tue,  8 Sep 2026 00:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788826553;
 bh=u6vi8Rb6/gBzlGLkta4lZeRt2WHuRcBjCNqaFrwusn8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=i1rXJ6DkJj2sMXRT3npeM6KrYNLTadUhqDz7uMKitdmKGXc4IY+0oKdBjPNXXJw1H
 BJVHQWtvsh6G0gdgf3hKefVzpaqe1QyHA/7z8JEQK8Ne95SdeleOzKKKUQJQbct+Na
 ELlLi6Y6av2MxaUTuWjbHFFkxMPs4eIwAp1M6/74VidlDoQHogNYiqfAXWoTjsDBq4
 zO+52jfZ66AxotnRLF7wKV5ZSWu2C5zWiRkf5Letyvpdhpbx9ui8nSEDuTpm0vZZSH
 4LonR/3pSyR16zE6JC3bwyDVTQTXEFfzpBb2BRFZGOtiMXLbGVv2OE3qb9nl46X4tv
 0UmPmRq+MrMxQ==
Message-ID: <3c4629c6-536b-44de-add4-39df3381e7d1@kernel.org>
Date: Tue, 8 Sep 2026 08:15:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jiucheng.xu@amlogic.com, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260907-origin-dev-v1-1-85ae7ebc8c98@amlogic.com>
Content-Language: en-US
In-Reply-To: <20260907-origin-dev-v1-1-85ae7ebc8c98@amlogic.com>
X-Headers-End: 1x3jVH-00008O-7r
Subject: Re: [f2fs-dev] [PATCH] f2fs: force out-place update for all writes
 on compressed file
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
Cc: jianxin.pan@amlogic.com, tuan.zhang@amlogic.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, tao.zeng@amlogic.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/7/26 19:35, Jiucheng Xu via B4 Relay wrote:
> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
> 
> For compressed file, compressed write may fail and fall back to raw
> write.
> 
> -Thread A                                         - Thread B
>    - f2fs_write_multi_pages                          - f2fs_down_write(&sbi->cp_rwsem);
>     - f2fs_write_compressed_pages                    - ...
>      - f2fs_trylock_op                               - ...
>       - f2fs_down_read_trylock(&sbi->cp_rwsem);      - ...
>     - f2fs_write_raw_pages                           - ...
> 
> Thread B acquires the lock first, which causes Thread A to fail lock
> acquisition and fall back to raw-data write.
> IPU_FORCE is enabled on small-capacity storage devices (< 16GB),
> so f2fs_write_raw_pages() overwrites the original compressed data
> in-place.
> 
> The in-memory node has been updated with raw-data addresses, while the
> node metadata stored on eMMC still remains in compressed state.
> If a power-cut occurs before the node is flushed to disk, on-disk
> inconsistency arises: disk data is raw, yet metadata treats it as a
> compressed cluster, leading to decompression failure.
> 
> To eliminate this risk completely, force out-place update for all
> write operations on compressed file.
> 

Cc: stable@kernel.org
Fixes: 4c8ff7095bef ("f2fs: support data compression")

> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
