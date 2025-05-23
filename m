Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D59CC54ED1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 May 2025 02:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AvopC2cfJkk3ZArUnQZnJ1wCw8fJQECeswK3ywpJJnY=; b=eLdaZe88O+kKNPv6U1Z0Jb1g5R
	8yePwNHU8LlwiWFmmADRigwu9qR5dzQC8fwJ6d69M2iE0qfI42HM/lXxEcOSZ3NZh3tvKbajWMJl5
	EguYa8SOFSKskVl09osqlKtsj3M6JKCXFuCfbdQIpZyKF331ePVptj9KKv4f0hFT8NXg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uIHoM-0004Uy-6Z;
	Fri, 23 May 2025 02:07:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uIHo9-0004Ua-JM
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 May 2025 02:06:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0dBmLNYCxx9Y+wTF1COJJA0Ipzw8o2jS21G0IN5ZidU=; b=lh4bbB0GNQFyQwb64vuu+zwOZW
 QKTtYqIpVuSSNOfsc6ZiR+8CTPnZDrgfGOZsaRBqdoYx+MflPDA1m4Ng2OfbmW5sf7UnGo+2JoBlA
 D9TdxqZgleP9eF4zuh73q4XvppzyEM667wc8afA09Zqwfa0mRaVOl/mXWgpZgJ1uApyA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0dBmLNYCxx9Y+wTF1COJJA0Ipzw8o2jS21G0IN5ZidU=; b=fOgeqnEq6+kwieVTNlnyUHE45J
 JZkePBvDv+AZAoKnKIFV4H08TOHnovFWJNdS9YoOYmMpvTlEPGDa/CN7CXo5dF/P8ms1x9ILH18qY
 j8qkW9+LA69AV/e4+ImzStRlJbwGrzIpCfO9km7VNGFuzCd1Nq88sEF0IZ72Db+Q2spA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uIHo8-00020Q-V0 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 May 2025 02:06:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 99DE14A6A4;
 Fri, 23 May 2025 02:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20BAC4CEE4;
 Fri, 23 May 2025 02:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747965998;
 bh=bsverSMWOBBf3YTQTuwFn4B8Z1u7ywDlbc3NJ9mtuHE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=HrkTlmDM9HrHEZrrwQj1ikqE1gQgWqYdJkQ2qLOfGVOxez6YN3JSqQVi6RB0LTZnO
 xRZqNhrmtmiyODMsXCG3j/oTUDDs5o9cSXw7RBebcTdMy7j41vdUxmIENF/w19uvC1
 IscMWZZhPCoAAQl2zM/fUfLkjt4jtJPbXkX8xCFsNKCTmIaxu+HdTSC1yIKh7z/Nw1
 6IQsiQx7n8/Z4ObGqmLpfUIG41e9C1ZF6nNxqPu0NOQ5wHcS5YQChdDoGHx6xD3fsD
 XPfxwwBDxGz313GDR8IBhOWHH/IbzDpOeP3cLLiSkYtR6htb6UyS8jQwqtRVqSxuwW
 9eNge7XM22R/A==
Message-ID: <52eee781-f53c-46a9-8ce4-96c5a0589240@kernel.org>
Date: Fri, 23 May 2025 10:06:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250522182644.2176645-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20250522182644.2176645-1-daeho43@gmail.com>
X-Headers-End: 1uIHo8-00020Q-V0
Subject: Re: [f2fs-dev] [PATCH v2] mkfs.f2fs: ensure zone size is equal or
 bigger than segment size
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/23/25 02:26, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Otherwise, it doesn't work with a crash.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v2: relocate the code
> ---
>  lib/libf2fs.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> index d2579d7..148dc12 100644
> --- a/lib/libf2fs.c
> +++ b/lib/libf2fs.c
> @@ -1347,6 +1347,11 @@ int f2fs_get_f2fs_info(void)
>  			}
>  			c.zone_blocks = c.devices[i].zone_blocks;
>  		}
> +		if (c.zone_blocks < DEFAULT_BLOCKS_PER_SEGMENT) {

If c.zone_blocks can not be aligned to DEFAULT_BLOCKS_PER_SEGMENT, do we need to
handle below code?

		/*
		 * Align sections to the device zone size and align F2FS zones
		 * to the device zones. For F2FS_ZONED_HA model without the
		 * BLKZONED feature set at format time, this is only an
		 * optimization as sequential writes will not be enforced.
		 */
		c.segs_per_sec = c.zone_blocks / DEFAULT_BLOCKS_PER_SEGMENT;

Thanks,

> +			MSG(0, "\tError: zone size should not be less "
> +				"than segment size\n");
> +			return -1;
> +		}
>  
>  		/*
>  		 * Align sections to the device zone size and align F2FS zones



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
