Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC7FC25B75
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:58:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sFCgp-0005uI-5m;
	Thu, 06 Jun 2024 12:57:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1sFCgl-0005u3-9H
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Jun 2024 12:57:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wTgnAQ+pKxAYFknJ3Qb4mN2BUWUuDM11bEhEheLrtn8=; b=D/vjCXw09P82PDooUKJhfpu+IB
 Fg7An8vkEz44GVlE5GW2UPd0cNNgyhGQsN7hhcRxspbtVn4AS+hFKwsPsGMuABTnaMdZZKi0rX7HN
 HlHkshmKR2MDK2tF7uRCmjLiWgixf/6ZSSiZ11ZhzshBG5Maq4ME0fvHvNJyY0Nhmh+g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wTgnAQ+pKxAYFknJ3Qb4mN2BUWUuDM11bEhEheLrtn8=; b=LlWSxXKxz5rlaPEHWExM8eOJ0+
 4oIewPr3Zzruv5r4XHKvQVF/xz9ONeBagHYnMHDcnl7BJbT3g6ZK88I7yvV/JHfa1ZFEmLY4OS0lG
 1QUMuEU/SGmm9LUzl4bnE+9WLB+qkA+F4ZzGUcMyHXIeHYb1Upjk2SL+m/p0qPEk811g=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sFCgl-0000YW-BP for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Jun 2024 12:57:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=wTgnAQ+pKxAYFknJ3Qb4mN2BUWUuDM11bEhEheLrtn8=; b=tnaMhI/busE8aGAHG/PxrF7UmB
 6Zhok6QfwzslX5poFwaFdTfywNDnbQcCPC7cF4smgnr2K5t+S7duTWug1nQklpcRKwMGbY4RH8Fa1
 +8ltCuaHgx+yCRWzbtvsLRnCavYO86FnkAik5P7zJrm6oTWA+0LKscjJi8TIvzHqiSN9x6UInbQt4
 HM71Ag6keJHCp8LTppHUsh1oZigC45fjo94Rt/gYHrXhiyKYAyRADCBIz/twwBaEOnRiHv1MfK3bM
 1UkA60YFZOhAdVWhod2JzyoGnMMNkW5/gAd9XVs8wUc3A9dtsEiGJLf2iFYJPpE23wREXRGiph2zS
 87HxemXA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1sFCNi-0000000EWBT-43Q7;
 Thu, 06 Jun 2024 12:38:14 +0000
Date: Thu, 6 Jun 2024 13:38:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <ZmGttup4xQM_jWky@casper.infradead.org>
References: <20240606095037.4086881-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240606095037.4086881-1-chao@kernel.org>
X-Headers-End: 1sFCgl-0000YW-BP
Subject: Re: [f2fs-dev] [PATCH] f2fs: get rid of buffer_head use
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jun 06, 2024 at 05:50:37PM +0800, Chao Yu wrote:
> For later folio conversion.

What tree is this against?

> @@ -3957,32 +3976,32 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
>  		return -ENOMEM;
>  
>  	for (block = 0; block < 2; block++) {
> -		bh = sb_bread(sb, block);
> -		if (!bh) {
> +		page = read_mapping_page(sb->s_bdev->bd_inode->i_mapping,
> +								block, NULL);

You need to use bd_mapping, not bd_inode->i_mapping (since May 21 in
Linus' tree).

And I don't think there's much point in switching to pages as an
intermediate step.  You may as well go straight to folios.

		folio = read_mapping_folio(sb->s_bdev->bd_mapping, block, NULL);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
