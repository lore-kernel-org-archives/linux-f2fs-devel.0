Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA6CC5DF9C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 02:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XCd0Jeh2ka2vr5zKmVkMkdCVmYmLbqfWEtiOinVfGes=; b=gikhPMwS5EGgFHsWown/ZK5tBR
	qWZC77lvic0ybIV+WpfFH56isDVedn8ivhmBvGtyfP8Wg6iW5hmrpoMlKivdvLGEHHwZuvDXzfv8R
	cP1yA5Ol5pISyhctYC0Xii1XtIvJSwbmmxbip6sI4LZa9qTMKdgZnshpgebZFpodgPzI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyhBR-00050L-LQ;
	Tue, 25 Aug 2026 02:46:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@gmail.com>) id 1wyhBN-0004zw-Nc
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 02:46:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9fofudxzugfZF4XIa8cT1ha0JW+fAUqhQM/y/JUq3sM=; b=gXlJxpj6ynruWkZRfNAsFoiZZM
 7fp7RLL8grgZUio3JSig1MvCY1tim8YHXa3FK5L1rm/EvUYHP9aBqcT/jzXWzVTAtpb/dHOulAhV9
 FppGe2FM432JZvUhGn7kjiGQZZDute3pP2yadwrP1REE13nuXxHCYaKHIHaS9+w+vrhk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9fofudxzugfZF4XIa8cT1ha0JW+fAUqhQM/y/JUq3sM=; b=ius5tULrpPWfQE3Qqf74pkx06x
 h82jvDnJWpU2wixZkx/APqs8Y3WnQt0wx9roMRDWbBWk3h+8bovm3xtyK9UKh/sxpg8lTWyTbGu53
 k+aJfekPEXJLjbLR462nDeqhHeNET79SBVlo7f2UQH/hu9LcIR+ifZmhi5wEN3DgAmX4=;
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyhBN-0007Nx-Sn for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 02:46:38 +0000
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3900e39d935so4572781a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 19:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787625992; x=1788230792; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9fofudxzugfZF4XIa8cT1ha0JW+fAUqhQM/y/JUq3sM=;
 b=B1iIC5AHO/ZvRzVPPTE2IzWO3+ev/rRsmzcW+vwCG/Y0Le1y87LWAWo+/D2zTZhAv/
 YzKUjk+4XfB+lLFWsaFh4pqqt8R2w8Be6BTh2b1+R4oRCxovf6gc/nUgapGMX8kaSFz0
 6WXFl9JmjLq504FWTNaVrbULvNZJOrMzAbh/s4VIQFN4RXwOuzuNJu4aZjV5PfUDnr3b
 5vEgRZJrZrSg6nBOQiIthXeQGap9Axe60cVmfvI42VhzvmfkJFCahe1T7FLQNx5Hbb6X
 lyALXVXBzq8wFdHyJpX5XbLtOc8ukHTWCZJT6pDlY7n3tcA33ZBwx+gMN4X+pAsorIiM
 39rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787625992; x=1788230792;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9fofudxzugfZF4XIa8cT1ha0JW+fAUqhQM/y/JUq3sM=;
 b=N4daTHGJveqT0EzNva9WBZzlMiGzHaaLptcDeThL4GJdqqt/LLbi8XSOl7JlpGTgdT
 Im9RTT5RZTJptG9mmQhTa8NdPkT/aYXj3io7lAHFEI7hQeDcLXvxr2LTi7LhKO7F8CJs
 7if/w2HJMdY0WgdPMs/LRWVHCwj7zA2Ay+TsQdcgnviWCktoQ5spk9M8jDhTyJZPHrQR
 T5F1PNcKQ/t2/lMnzyLKOR03Z1yxFdunrhTFqIGDmdTFfygef/GDAQCio7DNpb8vq2bH
 ys0nZAdooYAZjBnHitmkazif6qoq0Km+JFpnaHF683iktpKzXwb5yDbdaIckR4UJWr0T
 VN6A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVMg3zoJPJcwsblZqdL1e6aCPuEnJFaWJCyWbmN8ivEaO8wyGxNydcsfwfX0U3f9FnzVnbusDrly9Wp23Pxggx@lists.sourceforge.net
X-Gm-Message-State: AFuF++k5YBSfeaZ8Dc0JS4A2cv5K2ozM/MKBfrmdwFnT335JD/7DqYKO
 I4kWQC3aZ8c+tSNNvctF+Jyg6f7VpDD4VKJwNoCdBWRnEeyO71pydkdMiEPxDQ==
X-Gm-Gg: AR+sD11PDAwEaCjIv7mMZTI27unSBqpJsmaSZqmh9SfNY/VwT31K5V6IJCPUgnDLine
 gdwmLCogPcJLbmwzzoZbsGU8skfqxbfoTPcMyx5dprG2sZtCkFOuJUZ+Dg7DTVZHZxAi/b1L7h+
 QZTL7rPpZ8/w83+KEx112ccdkAsoviCI+8mgGtZzAZlUadajb/SpQVJvaDmzDqTDn6FV4y2HQEW
 +oXOV8OyeAqywqNDonBAXrZmm/n5JocgCle5tShmzQkYAlDn8HY+UX7JjRPXJ9iXOrCwFhSv+em
 ZSUUahbaMYx5lGHLlJtivg0rBE0thDEwbseKBgwjt8pixNTxDr0zBStlizDG0c5QZKy/abApk0F
 8EIL40hqzi/oy4tQ/9mcNLiLFn82ddzyqag3rRlqArAvkGLceu0E2aVFZ8riTfKojl6CJlqJdB0
 iZP290qR5xcXuQ4K/+yANEHoDwVnhRZWKWQ4c+N8X6QLeJJf4dDkQb7FW4yoIXNbiJfa8YETv0o
 +x2onI=
X-Received: by 2002:a17:90a:e0f:b0:396:4d8c:6c4 with SMTP id
 98e67ed59e1d1-3964d8c0802mr2270534a91.14.1787625991997; 
 Mon, 24 Aug 2026 19:46:31 -0700 (PDT)
Received: from [10.189.138.37] ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645b7ff6dsm1804658a91.10.2026.08.24.19.46.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 19:46:31 -0700 (PDT)
Message-ID: <70a44f25-f38b-473e-b941-e001229a97c4@gmail.com>
Date: Tue, 25 Aug 2026 10:46:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>, Chao Yu
 <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260814164929.693412-1-yangyongpeng.storage@gmail.com>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <20260814164929.693412-1-yangyongpeng.storage@gmail.com>
X-Headers-End: 1wyhBN-0007Nx-Sn
Subject: Re: [f2fs-dev] [PATCH v2 0/3] f2fs: fix read extent cache merge and
 add debug interface
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/15/26 00:49, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> This series fixes a read extent cache merge bug and adds a sysfs-based
> debug interface for inspecting the in-memory extent tree, which is
> otherwise invisible to userspace (fsck can only see the on-disk i_ext,
> never the in-memory rbtree).
> 
> Changes since v1 (RESEND [1]):
> 
> - Patch 1 (was 1/5) reuse the result of __is_back_mergeable().
> 
> - Dropped [PATCH RESEND 2/5] "only initialize largest extent without
>   extent_node at inode init": no benefit was observed in practice.
> 
> - Patch 2 (was 3/5) unchanged.
> 
> - Dropped [PATCH RESEND 4/5] "add extent_access_mode to track extent
>   cache access patterns": on phones the read extent node memory budget
>   is small, and no hit-ratio improvement was observed in performance
>   tests.
> 
> - Patch 3 (was 5/5) -- replace the ioctl with a write-only per-sb sysfs
>   entry `extent_cache_debug`. Writing a file descriptor to it resolves
>   the inode in the writer's context, dumps the largest extent and every
>   rbtree node (fofs/blk/len) to the kernel log via f2fs_info(); inspect
>   with "dmesg | grep ino=<ino>". A matching f2fs_io `extent_cache`
>   subcommand is added in f2fs-tools.
> 
> [1] https://lore.kernel.org/all/20260612115839.2065903-1-yangyongpeng.storage@gmail.com/
> 
> Patch 1: fix extent merge failure when largest extent is not in rb-tree.
>   When the largest extent exists only as a hint with no rbtree node
>   (e.g. after shrink eviction), a newly inserted extent that is
>   mergeable with it is not merged, leaving a gap that fiemap reports as
>   separate extents.  Merge the new extent with the largest before the
>   normal lookup.
> 
> Patch 2: punch largest extent instead of dropping it entirely on
>   overlap.  Keep the larger remaining left/right portion after a
>   partial overlap instead of discarding the whole largest extent,
>   preserving cache coverage for truncate/overwrite.
> 
> Patch 3: dump read extent cache via sysfs for debugging.
> 
> Yongpeng Yang (3):
>   f2fs: fix extent merge failure when largest extent is not in rb-tree
>   f2fs: punch largest extent instead of dropping it entirely on overlap
>   f2fs: dump read extent cache via sysfs for debugging
> 
>  fs/f2fs/extent_cache.c | 100 ++++++++++++++++++++++++++++++++++++++---
>  fs/f2fs/f2fs.h         |   1 +
>  fs/f2fs/sysfs.c        |  18 +++++++
>  3 files changed, 112 insertions(+), 7 deletions(-)
> 
> --
> 2.43.0
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

ping

Thanks,
Yongpeng



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
