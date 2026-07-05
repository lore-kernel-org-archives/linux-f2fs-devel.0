Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC9EC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  5 Jul 2026 20:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/0djBAz6K5Y1JS7XkL0klddXCws9KLqps/H8uxtoQSs=; b=JFM3Boy3zfZU6jVL9IRX8V1RV1
	goSmX7Tkj8gyzkHvXXBkMLmYfNNulOhu3DQONq8IxBpPjatNgqPWNuIPksiSda7p5P9xp64T1gTBY
	YohKXuMu+6gPUVZdfnvG9ucxBwyLl83bJVhGy9IZC6w/r2Z9BJqSIgihRVIvH/xgaCX8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wgT9n-0006ZA-DL;
	Sun, 05 Jul 2026 20:09:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wgT9m-0006Z4-7k
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 05 Jul 2026 20:09:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gadYmpHWMY+QGts0VFp3QV5k1w9S9s1LXnjC9dd9XPk=; b=IndW8jp8KLnXQZ3OVPIvBm8VmQ
 ZPWE1Jg5x5Pn6pU2vGynfMOZ/H+ulcWbdEAOjJTQ26Dz0zeUOrE5gYsSn/YosNUmb9NCU10WnGNew
 bE9/ZECw8641DUlY7qTvSfFQP05N4IDWbrUpNQhjoEtdQ+biHS9UavSyg3pBnwj3e+ug=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gadYmpHWMY+QGts0VFp3QV5k1w9S9s1LXnjC9dd9XPk=; b=lv8SV2+lPCLXz+BOMxvunPtddH
 16N8TbljvL/ExxTBiCP0RwVn/GDz4C0ghiqKm6mEl58D7jxym9xf+wXF2snKfcVY9Sd1D7+hVsP57
 oewEDFTQMpcP1phHZ658gUOkwpRzEynyR3Fm0BwT4Rjr1cFDaNDBo45Y6fJrwuzf93Mk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wgT9m-0005H0-24 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 05 Jul 2026 20:09:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 33AF941369;
 Sun,  5 Jul 2026 20:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B67E1F000E9;
 Sun,  5 Jul 2026 20:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783282168;
 bh=gadYmpHWMY+QGts0VFp3QV5k1w9S9s1LXnjC9dd9XPk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Mm/3bpFDGGDAGn3pagwlLTUG35H5lJ4MXl3YOHWMDBAJxy9n/uOUvNMI2FFfPBVwA
 JWqBpp/jC0w0M65gRN5Dro4yiKAaYTh0HQPp8k4zROzc/krdtQXymwOiPtaZFGDJ1Q
 Qqvk8RUSrWENgFXhy138Ulv8okFBVX1TCvIQWusjSrarWvhwrRRlP4i3TEi+44Xrqd
 BOKfYdZi6sSs8pLZqIBANG9DZetNes4FEWsFLGxNxNxNjBf7DSVApyDntS7c33mfpd
 gx/jqHR65l01YM7u/E/+nTKU4w+/yfTwF6+9K7/Jbslmb+wb/yYpbXoBmCI4W5EMQA
 OhW4w/1qwMquw==
Date: Sun, 5 Jul 2026 13:09:26 -0700
To: linux-fscrypt@vger.kernel.org
Message-ID: <20260705200926.GG41916@quark>
References: <20260705194555.75030-1-ebiggers@kernel.org>
 <20260705194555.75030-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260705194555.75030-4-ebiggers@kernel.org>
X-Headers-End: 1wgT9m-0005H0-24
Subject: Re: [f2fs-dev] [PATCH v2 03/17] blk-crypto: Allow control over
 whether hardware is used
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

On Sun, Jul 05, 2026 at 12:45:40PM -0700, Eric Biggers wrote:
>  /**
>   * struct blk_crypto_config - an inline encryption key's crypto configuration
>   * @crypto_mode: encryption algorithm this key is for
> @@ -76,13 +85,14 @@ enum blk_crypto_key_type {
>   *	ciphertext.  This is always a power of 2.  It might be e.g. the
>   *	filesystem block size or the disk sector size.
>   * @dun_bytes: the maximum number of bytes of DUN used when using this key
> - * @key_type: the type of this key -- either raw or hardware-wrapped
> + * @flags: BLK_CRYPTO_CFG_* flags
>   */

Sashiko pointed out that I accidentally deleted the @key_type line here.
I'll fix that in the next version.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
