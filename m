Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D46ECC6B34
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lStISenYXvu3dwf0BsUT18IyZrmeex/zzTI31xDcLOQ=; b=K4ThOffteMH2TN+OUGuYHJ03gc
	KrvqnrA2RYQSCPfaFgGjHa1jHWE4Ax2z3MbDZrzOldICI59Xl6fMIC9Fcb8dN9wiCJsLUET6ZdUKn
	OV4zbmExBfb0Kl3RPA+PbweK2big6gsewA9JL4UocO8swmKmrQwubKgbZUrm7WpoV9UE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHLbL-0005t3-Am;
	Thu, 15 Oct 2026 13:34:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xHLbK-0005sx-0p
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 13:34:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wL0pcDUdhO+6B3feeMzk1v/C02vcc6EjWkQgbU5Zed0=; b=RJ9UCZR0MGKYsKgpEOVQU6+m+j
 GtVcEX57cvgWiJvqMtbAN07jhwOV2ZbfNYTpTRD3447KBkYk3kxHBZDs7RqNaj0tS5K6oehwUW2vE
 QU5fw+u9HR/4sDTfMclUoYHin+c90tIznLRWDtSjJc5xB0AtypMnSdKaXd5pgyHXwmNs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wL0pcDUdhO+6B3feeMzk1v/C02vcc6EjWkQgbU5Zed0=; b=lP8Kk+1KLr8InsnBAcCvlDGSOh
 ssgYcvmlbSQk8P90PzrUWv4Qs5DJ9Zoo+Pj1YMBhKbarF/sKLNJOYUNn6bzzreoQtQrE6W1p7fud7
 N2epUBhGgehhu4OYtheol7v8euxVankOp6eKMmddGfm8Xj0LgoM7k9iAQMDHKyptGg88=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHLbF-0007it-Os for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 13:34:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 208F560120;
 Thu, 15 Oct 2026 13:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BDE1F000C4;
 Thu, 15 Oct 2026 13:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792071259;
 bh=wL0pcDUdhO+6B3feeMzk1v/C02vcc6EjWkQgbU5Zed0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=TNcoUQ0tDACV9eoxyyNp8hZJ3O5LXYmtHvu9Ct5s53NbEcHhjn3TbTpNBK7ApkF2M
 ZKwm0B9R4oSdi+tD/HutwwqyKD9kmbXcZ405Y3irbXJAYD2aUYnRwX1TaapEm9Xss0
 Gqnn1Nsm0A28xT2nmUr4ZV0HNrv1E6IpyZWLMDm/pLbTFV25E1UalCUvWHQphjvXvN
 3Et4HCDLoMrXDKouc+bVcYWr73vPuSbiHUZqLCykUkfAg6K8a5lInCyCNbNna0zdSw
 +dWH0EduXK6Dz+hyDYHtbQ/EUtvkXyFtXv5lh3cszJCUeGwX2CP5OPq0i59CH6BORb
 C2v9kz18r08Lg==
Message-ID: <e80cc65e-22aa-45ca-892f-d13f2b1ae12d@kernel.org>
Date: Thu, 15 Oct 2026 21:34:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
 <20261014064445.2835813-11-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20261014064445.2835813-11-zhaonanzhe@xiaomi.com>
X-Headers-End: 1xHLbF-0007it-Os
Subject: Re: [f2fs-dev] [PATCH v5 10/16] f2fs: support partial uptodate
 large folio read
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Dev Jain <Dev.Jain@arm.com>,
 David Hildenbrand <David.Hildenbrand@arm.com>, linux-kernel@vger.kernel.org,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/14/26 14:44, Nanzhe Zhao wrote:
> Buffered write can have write bytes smaller than folio
> size for cases when folio minimum order is not zero.
> This can left partially uptodate folio in page cache.
> So we skip uptodate subpage read in read_data_large_folio.
> Also mark hole subpage uptodate in uptodate bitmap.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>   fs/f2fs/data.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 87 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 59346b61615b..b9f2054f514f 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -148,6 +148,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
>   		struct folio *folio = fi.folio;
>   		unsigned nr_pages = fi.length >> PAGE_SHIFT;
>   		bool finished = true;
> +		bool uptodate = bio->bi_status == BLK_STS_OK;
>   
>   		if (!folio_test_large(folio) &&
>   		    f2fs_is_compressed_page(folio)) {
> @@ -163,6 +164,9 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
>   				(struct f2fs_folio_state *)folio->private;
>   
>   			spin_lock_irqsave(&ffs->state_lock, flags);
> +			if (bio->bi_status == BLK_STS_OK)

if (uptodate)

Thanks,




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
