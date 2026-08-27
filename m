Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAEBC61DB9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Aug 2026 03:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ksnwBa2yH325BqxG6N40RfmwzxxHEUVfINcUiFcx1bg=; b=VsWzLvo39miBN/xNB4OdG2C4/0
	BRJndhokaOHeHtDBCoeg0vQ0p+QM4lTdq5MEJLWtVh/p8ckUt5bK2e6+PIWRsKtH9f6ZpvomYRPEK
	yqD8cYO6pwSOhlNxc49QlrO6+pBdA1EC1v99MHYqooAoI4/qIriv8C0V7kWLcjpfXWvQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzQy3-0007cj-HO;
	Thu, 27 Aug 2026 03:39:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wzQy1-0007ca-KW
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 03:39:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6Sbv1lPOHsKI0SbemAvzpnjd3AMXsypdj2b6qA+OQtk=; b=CqI0h4QiFm2OdJRlhqaRXpMsWy
 hbObsajcPp5z6Isj8glx/kGT5y5iE1LGHPsoXgDMvjOTrXCxKX93ySwTwgh7cWsEoQnyGsuJpmAhJ
 S3Bapuwja/aUI25ZsjgWNSoup968T+q14D7jZCMoeegFgJcvgTk2jAGXLWDdoRM1Byk4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6Sbv1lPOHsKI0SbemAvzpnjd3AMXsypdj2b6qA+OQtk=; b=Rh1eeGoZondzK0esBgkvj5T9N8
 rj5X0051pkXkkwiJ+gVvYiwFp59rWqhZgVkSjEZJsm9iLfkgFM5ft7xUM2S67bkxIYS3F+Ew0v2ax
 HFRuiDv2HenV2qZFTDr0GC7Sv0iMtzocH2ddN/fvLUTuV8t+t0RmCXioZumEQfkDzNiY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzQxy-0006Kl-N6 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 03:39:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 14B97600DB;
 Thu, 27 Aug 2026 03:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DA81F000E9;
 Thu, 27 Aug 2026 03:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787801984;
 bh=6Sbv1lPOHsKI0SbemAvzpnjd3AMXsypdj2b6qA+OQtk=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=fur76tLsou539OlHWRlqQAj47SSzQsRc/2C4mqrF3pz4U1vaMdtOarOEvXRFXO4PC
 QkQWfqxSNbwNlXIFWGx7dGLj7VlYDPTKJK+37Raz1ZwsdCcEch3VaSh421vGuYq8WQ
 GhG69G7rkEXs9QzRN+dt5NWb2TGGB5Tqn1nkJRZbAogEpinhklYgYm5RyIA8xbjh6a
 Gxl5NyoOkW/bVGtHhWQIi3yyYisvnfTgveRUNHAPYB2uf2fQM2oCG+e7qsYKbefUYw
 +yz+dKJ6zFxqIE33t+/sjTZOz9qAc7ZjHb/zDItOkgRhGOpDRokZFT46FyO2uZJgbZ
 giWnMJ0DpTxnw==
Message-ID: <ed48c7f2-1649-430b-a2bc-f44d1d80a632@kernel.org>
Date: Thu, 27 Aug 2026 11:39:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Xinping Zhang <zhangxp1998@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <CAH=xXfFVAwQ3r_NdUDtmXhtg6Lw8kDWoNTzGL5oy4mwHMsJLJw@mail.gmail.com>
 <CAH=xXfG2Hzc-kNAPqEUsTJ4hwrQ-gYEnFrXHGxL7qpYpggkLUQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAH=xXfG2Hzc-kNAPqEUsTJ4hwrQ-gYEnFrXHGxL7qpYpggkLUQ@mail.gmail.com>
X-Headers-End: 1wzQxy-0006Kl-N6
Subject: Re: [f2fs-dev] [PATCH 1/5] f2fs: avoid underflow when counting free
 NIDs
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/27/26 05:39, Xinping Zhang wrote:
> __count_free_nids() subtracts the retention threshold before checking
> whether the cached count exceeds it. The operands are unsigned, so a
> smaller cache wraps before the result is assigned to long.
> 
> The PAGE_SIZE-derived threshold happens to make this an unsigned long
> subtraction, whose wrapped result becomes negative when converted to
> long by supported toolchains. Do not rely on operand width or
> unsigned-to-signed conversion. Compare values before subtracting.
> 

Cc: stable@kernel.org
Fixes: 1b38dc8e74a3 ("f2fs: shrink nat_cache entries")
Fixes: 02110a4fd531 ("f2fs: avoid casted negative value as shrink count")

> Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
