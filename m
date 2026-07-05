Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720BFC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  5 Jul 2026 20:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qzmIgKVoU8FCLrTH3+alsP8q93QO4SdfQ/w02/k2M9Y=; b=FXI0+j/gCMvnvvGk/U1uyRigtT
	pMN0RprI4bu6TBunj6qMcOiClX1HT1XHc64/hbWG1SP3/MxWo+5YZQpQ7pkNuoWYr/QL5jtl3teaW
	H7v/vq6iA4fRn5rWfgIWjwk2kLIUAUpcL3Wovc20bibqzIChE3zHWLlfouqCCUi92kU8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wgT8i-00062W-9P;
	Sun, 05 Jul 2026 20:08:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wgT8g-00062F-Dr
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 05 Jul 2026 20:08:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9CM2wVbhyHLDtHdcSbwHJ5tP/f8SZ6JkBBSxBmdPEIY=; b=Za6OGdN0WQOvMBtEG3hQzUuSZy
 92nxN5IHkmX7pFCPG06WaayNKprOgLp1eAMHEntUgRJMkuMGTSBiF/uItemMukL2otErtopf/exwo
 KCg5KoiZ24SBAvRNBbsbdfw7RLvaXZok05hyzyaUPu8bxFlRSRcJ7BNem6s34d/XlN0c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9CM2wVbhyHLDtHdcSbwHJ5tP/f8SZ6JkBBSxBmdPEIY=; b=VPBIm9uEy07U/dTnf3qBh63CXs
 KMQLdP382iIyc4VGF8S8Yfw/7zfg3vxJdxKEwnXnD5reGaANBXdwq0jmRS/aZXcQTFSX+NLhL/joi
 U7G9m+d/kYjwI0RIrtHvG77OwbCbLbDgJo8V0G5zRxyZRTIfOIN5QB/N4T4esAP0a+9U=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wgT8g-00051N-BM for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 05 Jul 2026 20:08:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7FA4D411F7;
 Sun,  5 Jul 2026 20:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998341F000E9;
 Sun,  5 Jul 2026 20:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783282100;
 bh=9CM2wVbhyHLDtHdcSbwHJ5tP/f8SZ6JkBBSxBmdPEIY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=AGFGOhk/VoXIOfqZakNksTm9cB9kUoQy3LTGkLM0HcAPxl6/kIl3CzWgnpVmQX247
 uX66+jr6L+LgeQifhoIeIf/X9WbbF4u6YO2O224FtIdR88BYvhJXgBVErqAv1qYAQG
 BrBPNqqepnxhkahgILgJluwb8nqXRvfTpdmd7b0PCOPPOfWJt2NqqupFD8aebiy8XU
 88n644xK/cTr98yc1ql5fZt0ZouO3k+FieKZI8yxhs49BQY3tFy6EP5duynfslihcy
 QaJ7HPjV3Mobx0ZWqgxUl2C7b+E2QguMK5ODWC/FI2mMgzvTwY/ybiqGJcQg+fd5wc
 891wd3RQZ/kUA==
Date: Sun, 5 Jul 2026 13:08:17 -0700
To: linux-fscrypt@vger.kernel.org
Message-ID: <20260705200817.GF41916@quark>
References: <20260705194555.75030-1-ebiggers@kernel.org>
 <20260705194555.75030-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260705194555.75030-3-ebiggers@kernel.org>
X-Headers-End: 1wgT8g-00051N-BM
Subject: Re: [f2fs-dev] [PATCH v2 02/17] blk-crypto: Fold
 __blk_crypto_cfg_supported() into its caller
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
 Zhang Yi <yi.zhang@huawei.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, Baokun Li <libaokun@linux.alibaba.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Jul 05, 2026 at 12:45:39PM -0700, Eric Biggers wrote:
> __blk_crypto_cfg_supported() is called only by
> blk_crypto_config_supported_natively(), so fold it in.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  block/blk-crypto-profile.c | 22 ----------------------
>  block/blk-crypto.c         | 23 +++++++++++++++++++++--
>  2 files changed, 21 insertions(+), 24 deletions(-)

Sashiko pointed out that I forgot to remove the prototype of
__blk_crypto_cfg_supported().  I'll fix that in the next version.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
