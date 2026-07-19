Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1D1C44512
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 19 Jul 2026 07:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w5T41pVjq4TdZ7dXMctr5ONxIWZvqQhF8x59NLWHPzk=; b=fMsfD3Yg0fuzl7EYUmi7cK7N8p
	O4Jq17F3drnAQc9Ej502uOxTAheT3+leuBK76q22nqNBqHq7wwPD4ezRzwLRpfDBnjUmuygIcldqU
	n3lHVXZjzkT+jL9Q448ZupFTZMFNtq/bsdLbTEz21XdkIKoAleIts8A9s7uFIlyc3CMk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlLu0-0000MZ-5o;
	Sun, 19 Jul 2026 07:25:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wlLty-0000MG-FP
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Jul 2026 07:25:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5zam7qKa+GIJwAFhCvX75nMaMfpcCbBWqRrQoiYwcTI=; b=aHmn69uKWXixBqaqAHx/OneCik
 dcFhEGETiit5BzvMd9mY6HkMmhyrRpDyIu/e0aS6GN5UFXwc8pOJB06a8AXkEErJoGyRt4Jg1foty
 lxx4uW2bKbMSfrFSAa4rRDq2MD5Otgk9HrSM9WT0ZkJBVJauinwSLk8p4TtODb8GNzxw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5zam7qKa+GIJwAFhCvX75nMaMfpcCbBWqRrQoiYwcTI=; b=A+digW6gAqpHqtK+bJ8qFGQgWS
 I5fAx19MpVHVLvv2+Dg1c5IEfOI8wjS5V2Q3gReYaZlks1olkI77+0flOOJPbkPp1dcoX6aEeYfX2
 38Tn0GuTVyiv4Aiq+CWBeGCmMz31vAmYoKyACOkPbURqjh6lX0/7JJcYwA2pDyj7Ejew=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlLty-0005wh-Ho for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Jul 2026 07:25:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D5F246001A;
 Sun, 19 Jul 2026 07:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BC61F000E9;
 Sun, 19 Jul 2026 07:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784445924;
 bh=5zam7qKa+GIJwAFhCvX75nMaMfpcCbBWqRrQoiYwcTI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=BrDL9qCfnC9nLRXaO8xar89TTbNNI23UIszHUS5A2328dOGS8Ry6gttjVJ9DmSFS2
 l4/KclO3av85auomYNbJWgJkx073IXtHD9fsy2wOeQr6ZBawggHi6ADIr/liMP2TOC
 +737ORse48xTVIHkFwoDUlsFV9OYGLm054dW1zyxlVNB8gL8HipaBC9r75up71lCwx
 /NMv1XvnNEswmGZ6Zb5wPv9d7Dbp+ytxA+xIqPUIGrw5ncT8TuUTBq3yE9ehrLzga+
 Fy0WVtS0fs6wsoNVum6fGIblAcxr6SuT4t7vxpwLe9wXNZMUR6niJbfDQczsBKFgSM
 3hWVA7fuomjIQ==
Message-ID: <8eb1eb27-c87a-410e-abf1-0e014689de0a@kernel.org>
Date: Sun, 19 Jul 2026 15:25:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
References: <20260713111944.924883-1-zhaoyang.huang@unisoc.com>
Content-Language: en-US
In-Reply-To: <20260713111944.924883-1-zhaoyang.huang@unisoc.com>
X-Headers-End: 1wlLty-0005wh-Ho
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix folio_nr_pages() race after put in
 large folio invalidate
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

On 7/13/26 19:19, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Our v6.18 based Android system is continuely suffering livelock and bad
> page stat as shown in[1] which related to broken xarray slot status. By
> investigating big folio operations within f2fs, we find below races and
> fix it by get the nr_pages before drop the refcount and folio_lock.
> 
> f2fs_get_read_data_folio() calls f2fs_folio_put() before
> folio_nr_pages() when invalidating a large folio from the page cache.
> That unlocks the folio and drops the caller reference, leaving a window
> where a concurrent truncate or folio split can shrink the compound folio
> or free it before the invalidate range is computed. An undersized range
> then leaves split sub-folios in mapping->i_pages, which can later
> interact badly with truncate and reclaim (stale xarray entries and bad
> page state when folio->mapping no longer matches the mapping being
> truncated).
> 
> [1]
> PID: 2594     TASK: ffffff8169b81580  CPU: 7    COMMAND: "Thread-3"
>   #0 [ffffffc08ef2b8a0] xas_load at ffffffe52d1f42a4
>   #1 [ffffffc08ef2b900] find_get_entries at ffffffe52c185798
>   #2 [ffffffc08ef2bb60] truncate_inode_pages_range at ffffffe52c19e83c
>   #3 [ffffffc08ef2bbc0] truncate_inode_pages_final at ffffffe52c19ec2c
>   #4 [ffffffc08ef2bc20] f2fs_evict_inode at ffffffe52c4c8400
>   #5 [ffffffc08ef2bcc0] evict at ffffffe52c2de9f4
>   #6 [ffffffc08ef2bd00] iput at ffffffe52c2db1b4
>   #7 [ffffffc08ef2bd30] dentry_unlink_inode at ffffffe52c2d7204
>   #8 [ffffffc08ef2bd50] __dentry_kill at ffffffe52c2d3dcc
>   #9 [ffffffc08ef2bd80] dput at ffffffe52c2d3c3c
>   #10 [ffffffc08ef2bda0] __fput at ffffffe52c2b0a7c
>   #11 [ffffffc08ef2bde0] ____fput at ffffffe52c2b1034
>   #12 [ffffffc08ef2bdf0] task_work_run at ffffffe52beea200
>   #13 [ffffffc08ef2be20] exit_to_user_mode_loop at ffffffe52bfbc17c
>   #14 [ffffffc08ef2be80] el0_svc at ffffffe52d1f8e54
>   #15 [ffffffc08ef2beb0] el0t_64_sync_handler at ffffffe52d1f8d10
> 

Need fixes and Cc stable line.

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Anyway, the code part looks good.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
