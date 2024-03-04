Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BC8C48BF6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:28:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rgx7s-0003cz-Lp;
	Mon, 04 Mar 2024 01:28:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rgx7r-0003cs-8M
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Mar 2024 01:28:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KS2t3X2x/N0cF8rwnb74rrQmnOVt6RMpfqor/sAB510=; b=NkqmF7DhF5lSAmtePEyChCyxwR
 t0Nn9GZwqNmIbE85QVwdXAA8kVf1u7uWweEFDWIplD8TTmrXaSB+lwf8CP8FWNLS/Ah64dxCN2Hg9
 xyl/NjYpzMzxw8kc67FzoycGu2+nKpgUwcClmErrOP42MBRJhGWhSGaB2kXkwn1VSi0Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KS2t3X2x/N0cF8rwnb74rrQmnOVt6RMpfqor/sAB510=; b=T/tcTySWOUJQD74pGMiCVSNThq
 8cP6ge0wQTasuSXXj78C9JvHyHEy+p3V2Aoq9vY1mg7kfY0xkthkpm3+ZMZfK6yHZ5GxW5BNxyfVt
 zEiBvxZ5g66OCvlGFRN/j5GaSqEBwN0C5zWd3p7tlMN4xWaBApgDeWcn1w+qi01RQ/AE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rgx7g-0001zv-MO for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Mar 2024 01:28:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 64D796010E;
 Mon,  4 Mar 2024 01:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBCAC433F1;
 Mon,  4 Mar 2024 01:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709515684;
 bh=dfi6Q19o4dtW5X91PjmnXBLO706D9dkUvPeGb9h+fM0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Nz29fLeJg+Usw8Crmrfb+4d9bClJ5zrgPI9LizBUHJL7PoIi4RW+Dsn3qimX+zpUH
 0rtSimQcwEyNA/G+sk6thdQ8DYySOFyrHMlz3IuhtnJRvhBfm00+D8QW+kkUK/cHz5
 R83PpJw1cDO4B/5ta/Jp6gNiNrBxfgEALAgEQfkotCds4iYuluddciuqmC2mjt1x0O
 CanSonz0YjFZ0ERgJs5HjgC+lSXFVQEzXTwt4SsT7dmOQ0o9q+XuCfkGqKIIsSL6NP
 1pZfC2Y6Kuiw53kVUUTmvczzE6OdLnAGz3MDZsCi1WHlD+UNdn2kpfOSiCX/0Ze9In
 ixd7VHC3hewxw==
Message-ID: <4ee229e6-53d6-41a0-99a3-49b8f99ea7f2@kernel.org>
Date: Mon, 4 Mar 2024 09:27:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1709281555-11373-1-git-send-email-zhiguo.niu@unisoc.com>
 <1709281555-11373-2-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1709281555-11373-2-git-send-email-zhiguo.niu@unisoc.com>
X-Headers-End: 1rgx7g-0001zv-MO
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: fix to check return value of
 f2fs_gc_range
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
Cc: hongyu.jin@unisoc.com, ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/3/1 16:25, Zhiguo Niu wrote:
> f2fs_gc_range may return error, so its caller
> f2fs_allocate_pinning_section should determine whether
> to do retry based on ist return value.
> 
> Also just do f2fs_gc_range when f2fs_allocate_new_section
> return -EAGAIN, and check cp error case in f2fs_gc_range.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
