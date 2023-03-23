Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (unknown [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AF2C6FD1C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Mar 2023 22:15:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pfTD9-00035U-Tb;
	Thu, 23 Mar 2023 22:15:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pfTD9-00035O-32
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Mar 2023 22:15:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qXNWJfyUItrRDuAMEpPJlWIv3Fg4IgJLJve+sAdgYfo=; b=HAPq/q+MMzTXNn83E6W8Du0lqS
 ClVnyKE8q2GsQ3d0J8k9kLc150WlTDQxyTRlnE1epfm5Zl3X+x4aR9MSXObcqlxsS4tVlTbfSm5Cf
 4UBTRRXkkfiGIQhEAe2zIw4Mc9gpOjqfy+Risf3huquhQ/ZYqgOHy9Bsh2Y3sJeoPs38=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qXNWJfyUItrRDuAMEpPJlWIv3Fg4IgJLJve+sAdgYfo=; b=kF/F1e60NIQ1aLGCSMDuha3sGH
 JZWx0zV+vBWLTsq4FSYlo2uVSnPo7/zM+euNB0/9wotWeHBYaxb1SIL9UNw15CQWlii2rtXQ6WLgE
 Exg+drAHaXnXo30YNQmBIWVuNpH5T4WtwP+9cWzvph9OrZdj+5mU5aTlGTJNC49z1/kA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pfTD9-000kWj-5p for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Mar 2023 22:15:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B8706628E4;
 Thu, 23 Mar 2023 22:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE53AC433EF;
 Thu, 23 Mar 2023 22:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1679609701;
 bh=M6e/PTV4/QD41rNo3Hf88nH85pNImdOy2sC2f6czaF8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pdHQIosAxULsZ71ZQ4M3a/+6nA4JelE9m3heqzN1jm33f09xdvn5BM51j2+5ZgtGh
 ozKAK44ifABBqfHW6A11+OPzBa5Hdro61rFw/XqZTTed/Vv3Q/HfAzLZI3kCEAYyth
 Cq5yxS4T2CCakoiydzTReEchAQWFlbxpUYdKDXvvU1DtEayvqCHCECdn2XC0AVaEat
 DSQvgZ1qYGZWPkf/De7ZlnVYnQVChVNH1lSeGeUNbndJdhpH0bzmFvqHLSjOCitxdZ
 zA+t5V7dU6H91Khi7uFbevcWmfWNttqpEbg1r/8ix20xNIO+CKuW9yWHqDLj0sZShN
 WLSTM/iexVZ4w==
Date: Thu, 23 Mar 2023 15:14:59 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <ZBzPYwcoLXkFngz8@google.com>
References: <20230220122004.26555-1-hans.holmberg@wdc.com>
 <ZBhisCo7gTitmKeO@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZBhisCo7gTitmKeO@infradead.org>
X-Headers-End: 1pfTD9-000kWj-5p
Subject: Re: [f2fs-dev] [RFC PATCH] f2fs: preserve direct write semantics
 when buffering is forced
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
Cc: damien.lemoal@wdc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 03/20, Christoph Hellwig wrote:
> On Mon, Feb 20, 2023 at 01:20:04PM +0100, Hans Holmberg wrote:
> > A) Supporting proper direct writes for zoned block devices would
> > be the best, but it is currently not supported (probably for
> > a good but non-obvious reason). Would it be feasible to
> > implement proper direct IO?
> 
> I don't think why not.  In many ways direct writes to zoned devices
> should be easier than non-direct writes.
> 
> Any comments from the maintainers why the direct I/O writes to zoned
> devices are disabled?  I could not find anything helpful in the comments
> or commit logs.

The direct IO wants to overwrite the data on the same block address, while
zoned device does not support it?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
