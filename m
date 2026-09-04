Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCF8C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Sep 2026 01:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DT+ItTMwoSb1aR4+0Kk9HxfH4R1NToeZ00iwYUTN6vA=; b=h0ZTS5g3AjXAesjQmc60eRjagV
	Mn4859chIpljQQ3FmX2r8+3c+C9He5eS6DJWHQugxMiiHVnIgDxGQ+ovU/a2l2e2he8VX97aRgblb
	kLCOs35n+rdpFon4vpxGAUnzkivMNnwXnFBK3zztFgPtOjlfwgRcHVp24AiNZOY/jxas=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2J9F-0003FG-Bn;
	Fri, 04 Sep 2026 01:55:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x2J9E-0003F7-2r
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 01:55:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lVKjIS0Eg5XrAPg/zdYHxfOR4gtQ/JfSPCvfuoElJzw=; b=kfx8c815xDZrur4lm4WaE6qTRV
 JN1M+rubeXJM1vwa3A+GBv4oJTKRRnKlP57bzoY40tN7Y4hKkQia/bGAw135+IXYPKEg1DKbj+jJN
 fPCd0CLPDei843F7RSrfpzoA3HJ7+2cPUn9+2F6I689h/Hu8TI/WDgLQezNN/TyZsCPw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lVKjIS0Eg5XrAPg/zdYHxfOR4gtQ/JfSPCvfuoElJzw=; b=Ih22uNhNNDJkxTTM9pItGoIIDR
 wTOeC8AxKPglKwbIpKW86NFRaSzsux4McCWDlV9ZwLXRAUhrsgMHU431FrMYzXa3932BNLSXflGn1
 lscWK7Jc08W9VSFWMMdc2wkrGGdca2M2W1csPIK2gBahMgTbg7jW8pD5BFf9APoz9gNc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2J9A-00057m-0q for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 01:55:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A2FAE413BC;
 Fri,  4 Sep 2026 01:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D4A1F000E9;
 Fri,  4 Sep 2026 01:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788486910;
 bh=lVKjIS0Eg5XrAPg/zdYHxfOR4gtQ/JfSPCvfuoElJzw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=KzKsuTnhbu08hAl35NHp5kRKiPwA9bs3Po95oJxzJTtR9AETBC6/3WG5B1/A7Ge+W
 Sis+Wk6cX7sVRJfCDDOyCPprL1OrW3ZOHjfOLYVyn/H1goWT+VTUvQSFRGetUIDYvO
 nzZEp0Xkc6ftQS8dV2wXVh3QyGlXEgkcP5SJaCV8a86JUgQkN8uwHae0NTVS/EnUC7
 rH+FSv5HG/OwlALrny2jzO2+1Sr8PmPktax6KtXrnQSA53YYyjBbZOar/ZBF7KGlNQ
 0gFSUpDqAbVu0m8i8075SIijHmIs9itigYZt/ivHydZdawzwXaZ2o+ckBO5HtE0MvI
 nS61xtVYegc+g==
Message-ID: <d988b67a-3b1f-43de-b317-375be828fa26@kernel.org>
Date: Fri, 4 Sep 2026 09:55:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kelvin Zhang <zhangxp1998@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1788479509.git.zhangxp1998@gmail.com>
 <f019fbdf97004b6dc2cbacd3a215b163a1761359.1788479509.git.zhangxp1998@gmail.com>
Content-Language: en-US
In-Reply-To: <f019fbdf97004b6dc2cbacd3a215b163a1761359.1788479509.git.zhangxp1998@gmail.com>
X-Headers-End: 1x2J9A-00057m-0q
Subject: Re: [f2fs-dev] [PATCH v9 03/11] f2fs: describe NAT block layout
 dynamically
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/4/26 07:56, Kelvin Zhang wrote:
> A NAT block is a filesystem-block-sized array of struct f2fs_nat_entry
> elements. The compile-time NAT_ENTRY_PER_BLOCK definition hardcodes the
> NAT capacity to a 4KB block size.
> 
> Replace the fixed array in struct f2fs_nat_block with a C flexible
> array member, and calculate sbi->nat_entries_per_block dynamically in
> init_sb_info().
> 
> Parameterize NAT geometry helpers (NAT_ENTRY_PER_BLOCK,
> NAT_BLOCK_OFFSET, f2fs_start_nid, NAT_BLK_CNT, and
> f2fs_nat_bitmap_size) with sbi. Update call sites across node management,
> checkpointing, GC, and sysfs.
> 
> This is a layout-only change without behavioral differences for 4KB
> blocks.
> 
> Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
