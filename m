Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA4BC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Mar 2022 02:49:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nOsZq-0005Hg-G7; Tue, 01 Mar 2022 02:49:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nOsZp-0005HX-4V
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 01 Mar 2022 02:49:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TA/IKlIqF/ZB/3Xjc8dyc73+Nb3FOMWpHWau/EBuciQ=; b=OlOOZXqzqxVlhYUqJnLGPKiJdQ
 Y1bBQa5En483ExUo206VvhE2VpvoUTU6/+dHcm6TF6Nhho7PIAap0KLPmZ63nzU8Cig83QMsHj5sI
 F22xBfQG7w+RaRJ6jNlrowND+LZXE9jL0P11kdmoIJ8pMDOUiMC3tasETpYACqUaij2Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TA/IKlIqF/ZB/3Xjc8dyc73+Nb3FOMWpHWau/EBuciQ=; b=bCucqbpv6cSHd8Vd6M9cK80grc
 o4Ssnzp32iG8Tkm99B6CKSkF3FdpnKnxpHWTiZYmEudQT/6DGK2NZf19WQql5vNUQ7vtm/7KOvDkJ
 6dBsKDeRGV0ptP2dlyr2e+nFUsbfraP7EmbaUDKUI1iaLw14hmWXvB4ZRz5jYxbRTqXY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nOsZf-000k7o-Ku
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 01 Mar 2022 02:49:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 42E676160B;
 Tue,  1 Mar 2022 02:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA988C340FA;
 Tue,  1 Mar 2022 02:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646102950;
 bh=KBM7Zi6UaFQwiF1vKbsCZWoDlDUJvqp3nrY82ducTY4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=P+1ZEZpHYdKhEC/GWzAkoI/qtNS7jj8rgLjWkdzynrxE1yfM8h9McK8HeuH9B5Ob9
 0jKYEj9zxjHH+Y3exJcgnUTq2RWPqpB3ar9RX5xcHvviWKqufg5aDLCD2w7FWmPYWT
 tMUn+N5tjk1H4Mz8sT3T9ukivXZBiZt27OLaqwMuqLizDFG6fcBbS7S6zsFQx6DmRb
 djFo7rOkGXNBL6ggN7ZdX31Q+Pw0rOY45Y3IajzvhURO+0fLK0LmuTvBp3/pnRJj5o
 4qzo1bCFNXsQEhB6Wt7TAp/TZ2iSoW02NP07W/I+AwayRuRpIUv/XVr12MC31hWhCH
 WwInl4n9XgbdQ==
Message-ID: <782226e0-5e7a-aec8-b9aa-e7fd7b3110a7@kernel.org>
Date: Tue, 1 Mar 2022 10:49:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220228124123.856027-1-hch@lst.de>
 <20220228124123.856027-3-hch@lst.de>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220228124123.856027-3-hch@lst.de>
X-Headers-End: 1nOsZf-000k7o-Ku
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: pass the bio operation to
 bio_alloc_bioset
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/2/28 20:41, Christoph Hellwig wrote:
> Refactor block I/O code so that the bio operation and known flags are set
> at bio allocation time.  Only the later updated flags are updated on the
> fly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
