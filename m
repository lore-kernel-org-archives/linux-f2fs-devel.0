Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316E3C44512
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 19 Jul 2026 07:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w8oNDaSqJUAsO8qHJv8194uJujlvNIq64qIV2vdvvmA=; b=d7s5HPeSpGgMPNzjXyPuOHCCjx
	2Ntdh3ZtZ6s4M1J/nxiLT8Su5CPjCVhQYTeAG8ZvYlwGh4vWBu1Y6VZsKHdynhGXZf/QjhaIDsAMC
	FwNJ+WyMh8XiIeNAolFolf9NcqaLp2nkiekSSfW9B4PKLEKoeQ+I91tpxgkPipXswZy8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlLjn-0007jc-Af;
	Sun, 19 Jul 2026 07:14:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wlLjm-0007jW-7t
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Jul 2026 07:14:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gWU93m+dehCCRAWw73kWCKHBJGHjBIGOnCPrX//nidA=; b=CziVxBMn9xCi6UtheNI4uX7vD9
 9HRa7X5UCljz0+Fv23IzhsFrqyDW7Apjy2rzwmznkP669dgY7xgg8PeDq7emQtgADDHPSvmO4tDsY
 U/r6otbITs1pM/KONM38ES0//vigDepTenTLHPEUDjgadp8ciuciFAo+91eLoa1oMOf0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gWU93m+dehCCRAWw73kWCKHBJGHjBIGOnCPrX//nidA=; b=Yp4GsamvpcOoaPGeCARmxM+vgz
 A7LbBHilEQU3C9mCdBRgZlU3VZnv/BzEnWncKFs0WkO7qEjAAGV1BAF5KQeD63OlaY86HyjzWr8fj
 OPGn5L3S3UWExvUpOFWoWBcn2V0UviWb5ixT3+WsYJtl/XnRrCEYZdj9tbJjQxrzdnRQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlLjl-0005Sj-O6 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Jul 2026 07:14:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 10FE56001A;
 Sun, 19 Jul 2026 07:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5AF1F000E9;
 Sun, 19 Jul 2026 07:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784445286;
 bh=gWU93m+dehCCRAWw73kWCKHBJGHjBIGOnCPrX//nidA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=DeExQbfJ7KG37rZyh3fWy/nEZVe6uTTBacDCFpiWgq06Ky2PXlKg1C4EusXuTtxMQ
 6HTYoBP7uCL6Dus9gwyvhMlf1nVWB2RR5+0GKsQn4v8j1l2DWdT5pJKwvyfZjsKb82
 sfI2hgeoshmUzk1KJjEhjTjkGLzPLze+J1vg/PrmELhz/R/QJiWs/JSTyFiR9F9Uzu
 y+1cOibB6oY/fZ1YHDMHIxX54Tsncs7kp6F7tStpO02QRxuZCpb+w6ePuues5ndahr
 6ELd/S08jgBLFdxhH5PeP2ZXLMJ/QIQ8p0ncUEE0Iy9+3HbMiIDrHqxijV5vysX1UC
 zrs7sDO+0aQwA==
Message-ID: <bfb4dffb-e02a-480c-bb91-29cf97b48e66@kernel.org>
Date: Sun, 19 Jul 2026 15:14:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Guanghui Yang <3497809730@qq.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260713055959.1865-1-3497809730@qq.com>
 <tencent_90E4200062E0A9E878FE14F33C2142E0DC09@qq.com>
Content-Language: en-US
In-Reply-To: <tencent_90E4200062E0A9E878FE14F33C2142E0DC09@qq.com>
X-Headers-End: 1wlLjl-0005Sj-O6
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix ifolio leak in
 f2fs_get_new_data_folio
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/13/26 14:16, Guanghui Yang wrote:
> f2fs_get_new_data_folio() documents that ifolio is only set by
> make_empty_dir(), and that ifolio should be released by this function on
> any error.
> 
> The allocation failure path already follows this rule, but the
> f2fs_reserve_block() failure path only drops the newly grabbed folio and
> returns the error.  When make_empty_dir() passes a non-NULL ifolio, an
> early f2fs_reserve_block() failure can leave the extra inode folio
> reference held by the caller.
> 
> Release ifolio on this error path if f2fs_reserve_block() has not already
> cleared dn.inode_folio.
> 
> Signed-off-by: Guanghui Yang <3497809730@qq.com>
> ---
> 
> Changes since v1:
> - Check dn.inode_folio before releasing ifolio to avoid a double put when
>    f2fs_reserve_block() has already cleared the dnode.
> 
>   fs/f2fs/data.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a765fda71536..6c573d392dac 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1477,6 +1477,8 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
>   	err = f2fs_reserve_block(&dn, index);
>   	if (err) {
>   		f2fs_folio_put(folio, true);
> +		if (dn.inode_folio)
> +			f2fs_folio_put(ifolio, true);

No, caller will handle it.

>   		return ERR_PTR(err);
>   	}
>   	if (!ifolio)
> 
> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
