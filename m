Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557DCCAC598
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Sep 2025 08:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yhl7siDtUirps8F9zJejtNB6wF4GbqKVjbIdC03P0Iw=; b=Cv6jOM9Hisytmod97XSt9qtbme
	HBwlA6os0rTVTz5T3mRyw6d/IBD/F32CgGlfuvlJR/JYDlmsc84WO/I2/MUiJogLrFHeDIdYdCWZB
	DFyr+kVeqx/WosSQiDaYkg4YUR0ogaAP1ETD2sKvM4Gbk8oG20jQOV6PR0lUrEyoAUqc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uy4hy-0007pK-7T;
	Mon, 15 Sep 2025 08:37:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uy4hx-0007pC-Ou
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Sep 2025 08:37:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FXLmoxr/xs2B/6BE+w/5VXT+IlMTu5UX9HyPPEsiyA8=; b=ZSvXHy1SGIXVK6OKN4ph2wSkwu
 mx0La+kjfqIdC9nVsl1pzf+m2/+hX5IOStVbenmshvqkc+RR4jj0rJ69Cy+FWRAUaPg7fcj/MP6KV
 WhEt3SgqZZBW65esGVga1/8imqbzP/EBU/xPfEIlFiFh5uQ9tpXpDTUSQpsnwAb3MxfY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FXLmoxr/xs2B/6BE+w/5VXT+IlMTu5UX9HyPPEsiyA8=; b=Nne2x//lC1dqe8ZI4oUPpCw0Lm
 B0ywRpYmLTIKNOoPRvnU3wwRFERsyyX+BOccmYPxR7oSrV405Yl9YQ++jSWIARt2CdjOlr4lV+bar
 NCauNYszoxb1C7MImsVDDASPK0Iql6dqalf0+cCb6JokfbUxWFMvwtJeVPxKmYA+ZuEQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uy4hx-0000zz-Bf for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Sep 2025 08:37:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EB8DF40481;
 Mon, 15 Sep 2025 08:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5CDC4CEF1;
 Mon, 15 Sep 2025 08:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757925418;
 bh=eOv6Qte1h1FSP1weoRfTb6/mca0YwiPhewjYEEdYcls=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=uyNQjpDaZAjBRTfWzbtea+LlLRj0q+62H+UtSCTQ4zK8W6tLwjqAgLwyQilKlY8o6
 tsitEWn+95/ikWEM3Kay6zhapCIretaGsKQs0TJ90vz6zPbjipcj8hCFrYDeSWjeMf
 ZisGMFOtFW9eGvg3lriVRWgngoso1NIYrL/p+0ew23mqCbuJTShK87vH+i5nXRq2/f
 sO06ifxp3yTyNy8EM8EHG8hJE5xfvrOlYtkcbkSyRcTDuLzM718YL84p1JPEHyvSW9
 yxQ0jimrYoTm/BI2ZerhbcWucAj224pjtysR3okPIx2MZBMpmOnGOnFW4aOpKq75fJ
 hdcmXFoxfDTWA==
Message-ID: <b42b161d-cd5d-45dc-8e84-c2b28eb632e5@kernel.org>
Date: Mon, 15 Sep 2025 16:36:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 open list <linux-kernel@vger.kernel.org>
References: <20250909134418.502922-1-liaoyuanhong@vivo.com>
 <20250909134418.502922-3-liaoyuanhong@vivo.com>
Content-Language: en-US
In-Reply-To: <20250909134418.502922-3-liaoyuanhong@vivo.com>
X-Headers-End: 1uy4hx-0000zz-Bf
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: Enhance the subsequent logic of
 valid_thresh_ratio to prevent unnecessary background GC
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/9/25 21:44, Liao Yuanhong wrote:
> When the proportion of dirty segments within a section exceeds the
> valid_thresh_ratio, the gc_cost of that section is set to UINT_MAX,
> indicating that these sections should not be released. However, if all
> section costs within the scanning range of get_victim() are UINT_MAX,
> background GC will still occur. Add a condition to prevent this situation.

For this case, f2fs_get_victim() will return 0, and f2fs_gc() will use unchanged
segno for GC?

Thanks,

> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  fs/f2fs/gc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 4a8c08f970e3..ffc3188416f4 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -936,6 +936,11 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
>  		}
>  	}
>  
> +	if (f2fs_sb_has_blkzoned(sbi) && p.min_cost == UINT_MAX) {
> +		ret = -ENODATA;
> +		goto out;
> +	}
> +
>  	/* get victim for GC_AT/AT_SSR */
>  	if (is_atgc) {
>  		lookup_victim_by_age(sbi, &p);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
