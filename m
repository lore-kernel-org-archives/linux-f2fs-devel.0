Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF29CD4855
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 07:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gJQzM5XiZifJD9nRqglSpJ0Nv6JvxXELK30TSjF+A6Q=; b=i2xCT4zfgleZ2qOgMsGFCq7Q2E
	szE7JEpYq4UaJ9QvKJvhRrcazUG/tT5jk2+Zzy8fOhbHcwuHZBjiNxhORmxMydnk0m3F/N1bt047P
	iTMePRm4cBpKP1OHhjaMPzdAASR+4nmVAkb6mYh6VkIciQRkmaOkcIsoPRMKLQR9XexE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMhRX-0005Nh-SE;
	Tue, 12 May 2026 07:22:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1wMhRJ-0005NN-Tk
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:22:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CbVlwsx6CEYMg77PXGLk2/geTVRI/zNjmS6aGPk9n0g=; b=YbHOTGVttG8W1n0EultPRjMkux
 SiQ8M5MV90UU+skbV52VPcgZuRVh42BtfyXhEcVq1nFgq6ApOuaRuQZIz/z2dwZBCwq2SqDJG1SOi
 zQhSjRka8Mbjz+SNw02okWKVv2+bY1qdX5WnXMM6T9QXSH9OlficmciZpPgQqtQXitTk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CbVlwsx6CEYMg77PXGLk2/geTVRI/zNjmS6aGPk9n0g=; b=jlkr1SqbNfq4/KJMs/wuvkDsrQ
 MfCi/H43VU38L7HjMvEHTH4VjVNLvLi0c4drpJON2Mr6Fs5MAEL17f22/VOIcnZ5LZUockugy/TSL
 c/Kt/G1sBjdQuQe3j5zCUPH9B0kJMB8C4gI+1YGqRYY5u38CKZT7aHA6b7PeLQryzeRU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMhRH-0001kG-Hh for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:22:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 46A4C60055;
 Tue, 12 May 2026 07:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F004C2BCB8;
 Tue, 12 May 2026 07:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778570514;
 bh=Xq9+eEnZyp37k7qXEaOdw0f0Snu5QZQtlvjD1+MYRu4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HpnCdujuSs0wcUGzR0lQTqIJ531e+c+TnGuoVAcjOUCcPqOGeNyWvcWsmYWSE3jxq
 mF9lVHlk8lkWBf0HidM6p3rU5VPTfQGMU6Po421XDufDTQigS16W5xwg2srgvuTKs/
 KXvnNJ/6OzLv9KM2ZGR1T2oxhsd+sSbbrbqvxmSKTihw1tl6w2uJS9X1KEKKjpadNN
 4nuq5EdnivRdW3Qm2oZhiQCb3YBa3DVhaw2PQmZBwhcU/a2lCEilJYilNG/IlNeDSI
 ro2YyO3EhmNbLo3hYTXPpvz/utb7tHvG+kyLD+U0Yk9qQMEGGIMuLHEz7RaJRZq/gj
 LeQ/tiiv2eo8A==
Message-ID: <217f91d9-4d5f-47a6-ad20-0404968b8e08@kernel.org>
Date: Tue, 12 May 2026 16:21:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@lst.de>, Andrew Morton
 <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-8-hch@lst.de>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260512053625.2950900-8-hch@lst.de>
X-Headers-End: 1wMhRH-0001kG-Hh
Subject: Re: [f2fs-dev] [PATCH 07/12] swap,
 block: limit swap file size to device size
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
From: Damien Le Moal via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Damien Le Moal <dlemoal@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.org>, linux-doc@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, linux-mm@kvack.org,
 Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/12/26 14:35, Christoph Hellwig wrote:
> Don't blindly pass the value from the swap header to swap_add_extent,
> but instead the device size rounded down to page granularity.  This
> activated the sanity checking in the core code that catches a too large
> value in the swap header.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me, though this maybe could be folded in the previous patch ?

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
