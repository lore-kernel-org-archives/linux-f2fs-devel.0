Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE04E77188
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jan 2025 06:27:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tVPXj-00042U-1S;
	Wed, 08 Jan 2025 06:27:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tVPXh-00042O-Iz
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Jan 2025 06:27:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:Cc:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qOYIDk1xuN5Ffk9Tx7StR2zQNcPJepXscQ7KwbarCtw=; b=SzQ3H2eNvq8an039fQV6DIOI0V
 eUOkbDwR7IR84px/8jgNmy9rEjQiTdQQdpAeogGX2F7vXGAoOHYytnXdNeW+mTWaRyhcy77oMrF2P
 wfKAGNa+NUpiUTEULEtXy6vN0UlK0liqnkI28SMA6J0FhGadoWiSzjRZdOKK9BzQEk2M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qOYIDk1xuN5Ffk9Tx7StR2zQNcPJepXscQ7KwbarCtw=; b=elmR0I5H3TzmfQHI5eaqhntUDv
 Waq8Fg4MzC5FcX7VBZkUpiQu0XU45CAoL/hO5oPwltJcb4FXwC3qlYh7XTVLU26Cq4GdvT4TRwDN7
 P7FpQX0sNK+T7eqKt97skSJ2rM4taculApc2rA85lAQRe4zR5yI7ozW9SxrtVbU9SJIU=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tVPXg-0007nF-C3 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Jan 2025 06:27:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id F273BA402AF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  8 Jan 2025 06:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7532AC4CED0;
 Wed,  8 Jan 2025 06:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736317662;
 bh=a2yAQY2KOPfDKjwBNr/1FmjUUktElYewr4hbpJmgr5w=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
 b=EOnchAc6x+zw0g7tLKmxdlHsVJYLqJkKlcVY3tMXWPVN2VQABAxk8AfuOcBsjqxMJ
 csdJ3AvLcjwX4kmdV+eSTCvqbMPPuWfObtwbX7COCzxxQRAm8Vd3l7Agmyv6Udycg8
 H6f9hnYcELYHex99hPPIMwLNZK8BjP0cIfpVxJNCebJhgHDQmhFL5TDqsF82amDgUS
 L+8i1+iN63s0Nw+HsmT0z9NNRJMwwWQ9ZIvdu5Sd4RhZhDFWh38Z/fsTKuY1Mj7zX8
 BrpEAXXK1cIDCsrDCntV5wm61+MPJDZedfPQLFMoOF7HMU/gFhUbG3mprDGqcLFMS1
 1vgO+Lnv3jDuQ==
Message-ID: <240d5a92-23a3-4494-8cb8-ac564a4782f5@kernel.org>
Date: Wed, 8 Jan 2025 14:27:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20250107023248.3702924-1-jaegeuk@kernel.org>
 <Z3173YjGWtV5r_W8@google.com>
Content-Language: en-US
In-Reply-To: <Z3173YjGWtV5r_W8@google.com>
X-Headers-End: 1tVPXg-0007nF-C3
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: don't call block truncation for
 aliased file
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2025/1/8 03:09, Jaegeuk Kim via Linux-f2fs-devel wrote:
> This patch should avoid the below warning which does not corrupt the metadata
> tho.
> 
> [   51.508120][  T253] F2FS-fs (dm-59): access invalid blkaddr:36
> [   51.508156][  T253]  __f2fs_is_valid_blkaddr+0x330/0x384
> [   51.508162][  T253]  f2fs_is_valid_blkaddr_raw+0x10/0x24
> [   51.508163][  T253]  f2fs_truncate_data_blocks_range+0x1ec/0x438
> [   51.508177][  T253]  f2fs_remove_inode_page+0x8c/0x148
> [   51.508194][  T253]  f2fs_evict_inode+0x230/0x76c
> 
> Fixes: 128d333f0dff ("f2fs: introduce device aliasing file")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
