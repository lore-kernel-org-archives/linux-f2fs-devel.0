Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A557C55175
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 07:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=abyfWHrsLSEG+44FtzCejVuYx+ntDALmYemRD99X8ow=; b=jLA38Ztokj3kO3vAvHgoa0XGBu
	WqNc356WPDGB/5ZMBxWosloLaWQ9lflk0e3+J1SGvFIj5gwuLOXTni+X04OsyU1QwNLRlzk0Vn1IW
	tc+Rsh9f/G0jodtXiGvJ15WgwzSYqYwe1k6gVn5WpnOWuUX2R948pAfrdejfqohfgV2g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqn2U-0007yI-38;
	Mon, 03 Aug 2026 07:24:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqn2S-0007yA-Jd
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:24:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HIWeIPBHtqygcH9dc8Dyn7uwP/WCc0x8+3zAwDyNAdU=; b=H0dgZwVlZldyE+O9E+TaBPtFMr
 TOtPWbst0VeJuCAA56cgHntdUDkDNISgr0BG6BZuA1coZVVXyYgihSS6cjU1c276/qsM7yR+5Xb15
 yrje9DYcWY69Z2oiNVZPBBXVLaugMItzvuTaL3vhmzIBJK8dOtesIXWAVY7XKObuw2R4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HIWeIPBHtqygcH9dc8Dyn7uwP/WCc0x8+3zAwDyNAdU=; b=f1JN7/KfkPhah1q1zIyhyuLMps
 YCJL0dr9qMVzvmArfPI9Bx/M6E2PMwWtSEMOCBct0Pp7sRi7LeIxV6UFHZLzo1MNEf8+C/2kt1w9e
 ZYSo23J1KSaHQWzGZndJr8SV5T6LRLMN23SU+C7F4soz3khBiXwOgeFkIwRDt6IWM0yM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqn2R-0006LQ-LV for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:24:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4251C417EB;
 Mon,  3 Aug 2026 07:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C48D1F000E9;
 Mon,  3 Aug 2026 07:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785741878;
 bh=HIWeIPBHtqygcH9dc8Dyn7uwP/WCc0x8+3zAwDyNAdU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=goaP1/PQKF5SvFooAI/SymyLO3nAqRGQBR8U+ZuCVFFb0jXewtZegif84QKcCYc5G
 CrOcLw6ZCcG/Z8tg2KUvYgjXvpOIjiPaYmLwwXxUhDeZ+fGfsKvGI88mkksniepsw5
 WNphIWQ+QLYQ/AeN7cfOuEMXJzus5nrizuFG6kgGM4mzvW/2rLmrmWwcnSVgOB4fty
 u9Jo4E5q00zPaTrQ1/5BPP/h6UFYOlEVWGXT5vb+skbSBy8q0l32CXuyLWNS57FgBJ
 hNOhesn4BfM6DHUILVFuzs6JGHosuOpRz6k3rM785onuOSV2Kfbd+sExTTzqgP0g0S
 1sUQfCOHPNT9w==
Message-ID: <f0eb26ed-c624-47d0-9450-6e6e014bbcd7@kernel.org>
Date: Mon, 3 Aug 2026 15:24:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260723133617.3841286-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260723133617.3841286-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wqn2R-0006LQ-LV
Subject: Re: [f2fs-dev] [PATCH] f2fs: keep pinned fallocate failures
 section-aligned
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
Cc: stable@kernel.org, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/23/26 21:36, Wenjie Qi wrote:
> Pinned fallocate allocates one section at a time. If f2fs_map_blocks()
> fails after allocating part of the current section, the error path still
> adds the partial length to expanded and clears FADVISE_TRUNC_BIT. A failed
> fallocate can then leave a pinned file with a non-section-aligned size.

Do you have a reproducer? maybe inject memory allocation failure?

Thanks,

> 
> Count only complete sections on failure and keep FADVISE_TRUNC_BIT set
> until the failed section preallocation has been removed.
> 
> Fixes: f5a53edcf01e ("f2fs: support aligned pinned file")
> Cc: stable@kernel.org
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
>   fs/f2fs/file.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index c54897a25981..83af73f3831e 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1966,11 +1966,12 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
>   
>   		map.m_seg_type = CURSEG_COLD_DATA_PINNED;
>   		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_PRE_DIO);
> -		file_dont_truncate(inode);
> +		if (!err)
> +			file_dont_truncate(inode);
>   
>   		f2fs_up_write(&sbi->pin_sem);
>   
> -		expanded += map.m_len;
> +		expanded += err ? rounddown(map.m_len, sec_blks) : map.m_len;
>   		sec_len -= map.m_len;
>   		map.m_lblk += map.m_len;
>   		if (!err && sec_len)
> @@ -1986,7 +1987,7 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
>   		pgoff_t last_off;
>   
>   		if (!expanded)
> -			return err;
> +			goto out;
>   
>   		last_off = pg_start + expanded - 1;
>   
> @@ -2004,6 +2005,16 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
>   			f2fs_i_size_write(inode, new_size);
>   	}
>   
> +out:
> +	if (err && f2fs_is_pinned_file(inode) && file_should_truncate(inode)) {
> +		f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> +		filemap_invalidate_lock(inode->i_mapping);
> +		if (!f2fs_truncate(inode))
> +			file_dont_truncate(inode);
> +		filemap_invalidate_unlock(inode->i_mapping);
> +		f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> +	}
> +
>   	return err;
>   }
>   



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
