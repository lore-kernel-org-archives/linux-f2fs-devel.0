Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F26CA9EC9
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Oct 2026 08:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rINo9JHhj8kkHu8KPBFPkA7I1U4cHL0/pjdU0ebQH9g=; b=WRx5o91oRhuDnj3KgEcT4nnWkC
	VOQTc1nhQbH2mMztx9xXPy6+NJ3WCmdXVhJGtv5JjH4oGHTO04P/bsLlnkwRhC9MbeWDwtD6jW1w/
	hF+FNpJstr4FV43iQ3VAGODwjQZaTo49JDjyzfLQBMQDn9U833C6n0701avUuOk/4uuY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFoTg-0007w6-JJ;
	Sun, 11 Oct 2026 08:00:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xFoTf-0007w0-A5
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 08:00:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BldPchgRPYf8807oLd4yoj0+uSTzoKV/uAiOC/vtc6w=; b=HQ56r/nC50WELdPcfRYso4jZVU
 PvJmdgFAAWUdZnSlLdy+PQfvXWx8z4F4coxghBCHKFYZd05An4DmgkHfLVucXLxMnqWcMETHgl0Iy
 XpngM/XTZzj5ddO2I8FrMW0W9OORojDrzbrga3V8HcDmG3Z8cWx77d4gaprBGh4kw0WI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BldPchgRPYf8807oLd4yoj0+uSTzoKV/uAiOC/vtc6w=; b=VkooZIRwzY2oK7EDWW7RDmvyXj
 jcTrpBw6Jn462WmgfU8S1ux5nz27ipDew/fRSXTiAy7NsO+6m1bqGtO6sPRGK6l/lCXN2qHYfvpQM
 DxqdGQjNFoT+gq0mcrhkZxwFoy8o0m+ddDOLKbNocYyjAPX5wBClfE8qsb0QwnMt2Wkg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFoTe-000488-Ji for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 08:00:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 509A840954;
 Sun, 11 Oct 2026 08:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E831F0089B;
 Sun, 11 Oct 2026 08:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791705609;
 bh=BldPchgRPYf8807oLd4yoj0+uSTzoKV/uAiOC/vtc6w=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Ar6eCvN8aC/KY4dbcb8yUHCoXAjmrDhgTDtAl235n6kBA69nZzOoYqd5W5wlsEAKB
 nz3z9u+oXnA0+HfgMos2WsghNQsblZeFPl3x2OHNKNPOBK4zUUspxriYJtBiY2XbU5
 0Xv1FG+vfw9NM6+KIk1hCIhGjLz7A6pkg5KVLVq64Bphh+7r0RlQ1axiFqzibQvLfd
 4dfNRn2JSB8Cowkct5lvHdpwy6IEgg+tWbaPZsIzTv7BHK/3Z9dpxphIvA1hhBS13U
 upe3/EO3S4j18NmqimZ67C+nZj1x2PWuv19xFevjSKvyx0+QXmSha5QUqxE3E/ML5X
 O7cPeShtfxvyg==
Message-ID: <b76e45ca-b455-4c2f-82c8-abbb596acb86@kernel.org>
Date: Sun, 11 Oct 2026 16:00:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261005154954.2097054-1-zhanxusheng@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20261005154954.2097054-1-zhanxusheng@xiaomi.com>
X-Headers-End: 1xFoTe-000488-Ji
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix defragment writeback range
 truncation on 32-bit
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
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/5/26 23:49, Zhan Xusheng wrote:
> f2fs_defragment_range() flushes the range it is about to defragment:
> 
> 	filemap_write_and_wait_range(inode->i_mapping,
> 				pg_start << PAGE_SHIFT,
> 				(pg_end << PAGE_SHIFT) - 1);
> 
> pg_start and pg_end are pgoff_t, 32 bits on 32-bit kernels, so both
> shifts are evaluated in 32 bits and truncated before they are widened to
> the loff_t parameters.  pg_end is only capped by the file's page count,
> so for a file larger than 4 GiB the shift wraps.
> 
> For a 5 GiB file pg_end is 1310720 and the range collapses from
> [0, 5 GiB) to [0, 1 GiB), leaving the rest of the dirty pages unwritten
> before the blocks are moved.  For 8 GiB the shift yields 0, the minus one
> makes it (loff_t)-1, and the range becomes [0, LLONG_MAX].
> 
> The matching call in f2fs_collapse_range() already casts:
> 
> 	filemap_write_and_wait_range(inode->i_mapping,
> 				(loff_t)index << PAGE_SHIFT,
> 				((loff_t)pg_end << PAGE_SHIFT) - 1);
> 
> Do the same here.  On i386 the shift changes from "shl $0xc,%ecx" to
> "shld", i.e. from a 32-bit shift to a double-precision one.
> 

Cc: stable@kernel.org

> Fixes: d323d005ac4a ("f2fs: support file defragment")
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
