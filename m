Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20399C44500
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jan 2026 09:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JFJmneDPGfJD9Shs2LCUX0h0YGf+/4lw+guw7fVpZ78=; b=BEHUPLKQxS+QvYHNidyMeqDjY6
	3kmtcfEqNXAMV6YMx2bq281SAxBDQCJvCBinkHvv6oe9kBpA4j6RuU1WeNqPx1OPe1VvM7MHmJcOa
	e6g5M1s3DmWHI0yZpZmQLPC8t0Y2gMmm/yO677QSN+Y0j3smreDMSNpfCTOhYcMzY/2E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1viqmU-0007Rw-My;
	Thu, 22 Jan 2026 09:15:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1viqmT-0007Rk-Am
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jan 2026 09:15:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7E1xJQFD4EYREd+a/0p9tf2ng+GJL0LIGQSO3LefWKg=; b=hUXJbu5VJxs0UM8GDzpP5rgWdR
 eAjDOlM1RbmNlfiPt+X/kqig92Q6VNSt0UVKFPlyH4Ws/Clw/lIrYTsKg2BGQEtxbrCKqmxi4R3SY
 PxNt1qm02kCAYG79a1O8PEHQoSetFv/HySti3FqxfJjUyiRdsY4vrFvvHKVPZfRhRNqg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7E1xJQFD4EYREd+a/0p9tf2ng+GJL0LIGQSO3LefWKg=; b=MeQicx4qi/szlrBvajR+8z348F
 m5esa8k4D8m0rRcOBTVDE4d2A49UPn6r+V6JA28BBs52YtGOcu8+TjE5D8Tk3LnYBZeWpSbdEd27x
 /2Wj3M7ssA6gZ+lh6nR4wKXwQoelIQIS+qeiNrG7irdTzzrylLljfzAvkTCcDt2L/M9M=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1viqmS-0001gW-P7 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jan 2026 09:15:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1CEC7600C3;
 Thu, 22 Jan 2026 09:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F291C116C6;
 Thu, 22 Jan 2026 09:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769073297;
 bh=T8TOFgL9MIZVQG0T6OPEUQBPv/7tT5KWjY+sBkrwtHg=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=iq0J8pKZEIaHMJwc0I/0ugsJdup+WNFxKYPUyG8mUcYopDQW3Gjo8V6kJx0ecInpv
 VZM0cnHKbj490qC6VgncdeHnRATSzJGrU6HizEUsmaBiGyV5NivEg9KVFHRv5PJ4VE
 NMJ3sXgzAGCXU5I2mEKX9KQd6hDyoH5bklAeZ96lW/bCSShlCFlTbLaMB34uTJjrMN
 uoj5jYlUNTQk1Kua13qhCPDVJGl/p9N2FGYxT+SlZY0cFfMhJBkqxqaYyqm/8zisQo
 I4Ph+F7u4bvIZpn0FtYbKO58ffZanIKU0fns/2xA1y5me36XT1PylJYtLw2oC1NDwE
 juRv/tSEWEFhw==
Message-ID: <8a00c027-d14d-44c8-9105-b385fabb37f2@kernel.org>
Date: Thu, 22 Jan 2026 17:15:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yeongjin Gil <youngjin.gil@samsung.com>, jaegeuk@kernel.org,
 jyh429@gmail.com, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
References: <CGME20260116102347epcas1p46ed8360e1a69831f382dcf9d9ee486b0@epcas1p4.samsung.com>
 <20260116102346.992546-1-youngjin.gil@samsung.com>
Content-Language: en-US
In-Reply-To: <20260116102346.992546-1-youngjin.gil@samsung.com>
X-Headers-End: 1viqmS-0001gW-P7
Subject: Re: [f2fs-dev] [PATCH RESEND] f2fs: optimize f2fs_overwrite_io()
 for f2fs_iomap_begin
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
Cc: Sungjong Seo <sj1557.seo@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 1/16/2026 6:23 PM, Yeongjin Gil wrote:
> When overwriting already allocated blocks, f2fs_iomap_begin() calls
> f2fs_overwrite_io() to check block mappings. However,
> f2fs_overwrite_io() iterates through all mapped blocks in the range,
> which can be inefficient for fragmented files with large I/O requests.
> 
> This patch optimizes f2fs_overwrite_io() by adding a 'check_first'
> parameter and introducing __f2fs_overwrite_io() helper. When called from
> f2fs_iomap_begin(), we only check the first mapping to determine if the
> range is already allocated, which is sufficient for setting
> map.m_may_create.
> 
> This optimization significantly reduces the number of f2fs_map_blocks()
> calls in f2fs_overwrite_io() when called from f2fs_iomap_begin(),
> especially for fragmented files with large I/O requests.
> 
> Fixes: 351bc761338d ("f2fs: optimize f2fs DIO overwrites")
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
> Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
> ---
>   fs/f2fs/data.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 2e133a723b99..bfbd717e628a 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1851,7 +1851,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>   	return err;
>   }
>   
> -bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
> +static bool __f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len,
> +				bool check_first)

Yeongjin,

You may missed to add logic related to check_first parameter?

Thanks,

>   {
>   	struct f2fs_map_blocks map;
>   	block_t last_lblk;
> @@ -1877,6 +1878,11 @@ bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
>   	return true;
>   }
>   
> +bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
> +{
> +	return __f2fs_overwrite_io(inode, pos, len, false);
> +}
> +
>   static int f2fs_xattr_fiemap(struct inode *inode,
>   				struct fiemap_extent_info *fieinfo)
>   {
> @@ -4443,7 +4449,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   	 * f2fs_map_lock and f2fs_balance_fs are not necessary.
>   	 */
>   	if ((flags & IOMAP_WRITE) &&
> -		!f2fs_overwrite_io(inode, offset, length))
> +		!__f2fs_overwrite_io(inode, offset, length, true))
>   		map.m_may_create = true;
>   
>   	err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DIO);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
