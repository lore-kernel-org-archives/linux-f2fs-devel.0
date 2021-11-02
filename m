Return-Path: <SRS0=51XN=PV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20705C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  2 Nov 2021 07:36:19 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D223460C51;
	Tue,  2 Nov 2021 07:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D223460C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mhoLB-0003pJ-TJ; Tue, 02 Nov 2021 07:36:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1mhoLA-0003pC-Kl
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Nov 2021 07:36:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tCymKZxM1K0P2bGwd1aIVkDe8O2JKIWpZbldXvxKrYs=; b=k0oXF5lal9lSqZj4PIg42Avvtr
 FtW7jx1a/hW5HukNV5tQ0mvchOo4mxBz0mpLg5vkS8/Pm2j63xR3sqYZq+416tACgKVx/5qCHULej
 6IkFsxYQhgX3kaB0zynmDPk2k61vZkLsljnIRZQe3tTjRByirMYBzdyoGpXdxzn1gP1c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tCymKZxM1K0P2bGwd1aIVkDe8O2JKIWpZbldXvxKrYs=; b=kmwRSf8CE2Nf7X0Lz6EVlEVOP6
 IUAwANy0vYYvcNommSrOScQlcnkis2p3NqJW2J3gfqAaNoPhtQskrZLIsDD423o1YxgdKUrPrfcYN
 H/cIwAgoIXVmC3hEXOA2T3xUo/PNgPH+2FLaU76aO3zBGud9vOdxjO924w3DrqiHera4=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mhoLA-0003PY-3a
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Nov 2021 07:36:16 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4C4A60EB8;
 Tue,  2 Nov 2021 07:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635838570;
 bh=E0ffIejdumv1RC0pKbIxm0RZVYMo3MKph+prxcwMGlU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MBqM7NOGsv5CRd9fXjWUpiLJyBboJX6EhA5ls6iSoQFlruMVWgONtIO52dMnDunlD
 5f70COA/MArLTyI1XBEScaKSYzHIjyv6gcyO3bB1lrVbfvI9LwqoaWw1Fvi+/DKw3E
 XAUh90H//Wl9REfS/aKRH2OQiwHn/IhSYyQTuZ8k7mlS366fiTq3Lidrbmu4qro9nS
 2Q94oHzTXQpVuYCsdWQsdf3N/Lcit73nGOpbsG11GDXVy9SXGnPsHUERWNxd4Je8Nw
 U5D8ECrCc4testNtX0Z9rlbNLmJS00wRlBCe1uyzS2WtReNGTIQt8f0oIa6UM5NL0E
 OLYsf31jectiw==
Message-ID: <037676b3-4f66-c749-5c8b-ac0c1ef7facf@kernel.org>
Date: Tue, 2 Nov 2021 15:36:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To: Hyeong-Jun Kim <hj514.kim@samsung.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <CGME20211102071004epcas1p4d6422cb2ccaa6af495cee4f041f63048@epcas1p4.samsung.com>
 <20211102071002.71823-1-hj514.kim@samsung.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211102071002.71823-1-hj514.kim@samsung.com>
X-Headers-End: 1mhoLA-0003PY-3a
Subject: Re: [f2fs-dev] [PATCH v4] F2FS: invalidate META_MAPPING before
 IPU/DIO write
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/11/2 15:10, Hyeong-Jun Kim wrote:
> Encrypted pages during GC are read and cached in META_MAPPING.
> However, due to cached pages in META_MAPPING, there is an issue where
> newly written pages are lost by IPU or DIO writes.
> 
> Thread A - f2fs_gc()            Thread B
> /* phase 3 */
> down_write(i_gc_rwsem)
> ra_data_block()       ---- (a)
> up_write(i_gc_rwsem)
>                                  f2fs_direct_IO() :
>                                   - down_read(i_gc_rwsem)
>                                   - __blockdev_direct_io()
>                                   - get_data_block_dio_write()
>                                   - f2fs_dio_submit_bio()  ---- (b)
>                                   - up_read(i_gc_rwsem)
> /* phase 4 */
> down_write(i_gc_rwsem)
> move_data_block()     ---- (c)
> up_write(i_gc_rwsem)
> 
> (a) In phase 3 of f2fs_gc(), up-to-date page is read from storage and
>      cached in META_MAPPING.
> (b) In thread B, writing new data by IPU or DIO write on same blkaddr as
>      read in (a). cached page in META_MAPPING become out-dated.
> (c) In phase 4 of f2fs_gc(), out-dated page in META_MAPPING is copied to
>      new blkaddr. In conclusion, the newly written data in (b) is lost.
> 
> To address this issue, invalidating pages in META_MAPPING before IPU or
> DIO write.
> 
> Fixes: 6aa58d8ad20a ("f2fs: readahead encrypted block during GC")
> Signed-off-by: Hyeong-Jun Kim <hj514.kim@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
