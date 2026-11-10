Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFDE606A332
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Nov 2026 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HceDQj4i;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hVeOV3n6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PT2nyQ6a;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opyKExCr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XzjbldwaVhv8wT2VterTHG1V6JcwpSpJ6ylDoWTo8ow=; b=HceDQj4iGXMjgk1voAN07MEdkx
	i/Id+1nta43Orr7G1cnQCxVjuHqf4IPAhz3dyJF0ya+2NiAqvI2O1fW4kew057DKjW4UMgG4DGplZ
	GdAgs1f9UICJ+dgUu7T7GtcorhTaWZKqjEvs9noq+DNqxFGwV+HK21Cd2OmK5qacjsLc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xQuRE-000000004Ah-1lwt;
	Tue, 10 Nov 2026 22:35:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ebiggers@kernel.org>) id 1xQuRD-000000004AZ-0Rew
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 22:35:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ym20+7Wv/4wi7Ep6FbeFDDNft2D0SHfj7IADfm8Ryp4=; b=hVeOV3n6uAj6vauLCqAgwLvCad
 R9lvhUsIFuCgabnyXXh1hj38R+I+VT9eIJ7OAmwJiMtddjl/NLGPedqTCzuOD8qnb9UDJd0bsxBEh
 Z3QK1LSUhiqSoTgetaNpnxJhbBchKIHh4BM3y9Ti9fe07v18zZbu1Lo/ytkDsd2XXHlU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ym20+7Wv/4wi7Ep6FbeFDDNft2D0SHfj7IADfm8Ryp4=; b=PT2nyQ6ajjEN8reoG3hQ1AZ/GT
 HiMzOIEitqSTBVsEbHzzHrF3w98KCq6PiBEKgA7hX3iv3CAd7l+OQrGr3EL+alSI53wQsmYlWpPWl
 G2z3FBzLEZxe/U0rVBQhcR9KJoIA8CAlM9Pf6FEbb8NvWwYrTBsq93YmXmKC9cACpqGE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQuRB-000000003p5-2MRE
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 22:35:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1D4704069D;
 Tue, 10 Nov 2026 22:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED9C1F008A2;
 Tue, 10 Nov 2026 22:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794350128;
 bh=Ym20+7Wv/4wi7Ep6FbeFDDNft2D0SHfj7IADfm8Ryp4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=opyKExCr5bYGHhFaW47e6loGVMMkBUzHRHaWRXIs3Sa0HtTR3Xn9AKilhTpNDjhto
 oFsxxKG/KoJfP3RmQR5MBL79mRo/ei3ewFv893ASanogpgi7b2RFz5mgHgG6zdMxOY
 YR0MlRSD038sPylWG2DBpdTEPx3URt0uOWLAnxDPkh6CjE0X4jZr/dPIdkVAxBBIJM
 w2VK8mMZTff08FVCq+psm4FfyQz5Mt27WIb95r6xeP6FCaJdgdbTIEjQ0sQ0MzgAfM
 7xAA/NMtxOqNxcBHLQEA7yZ+io7L5v+VGrE0M6VRBmE9bDVgWBdTCMoy3M5yKUEalj
 Q2nqqeL1HZISA==
Date: Tue, 10 Nov 2026 14:35:26 -0800
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20261110223526.GD1907@quark>
References: <20261105115532.613467-1-aalbersh@kernel.org>
 <20261105115532.613467-3-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261105115532.613467-3-aalbersh@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQuRB-000000003p5-2MRE
Subject: Re: [f2fs-dev] [PATCH v2 2/5] fsverity: add I_VERITY_BUILDING inode
 state flag
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, brauner@kernel.org, tytso@mit.edu,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com,
 jaegeuk@kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 12:55:27PM +0100, Andrey Albershteyn wrote:
> +	} else if (inode_state_read_once(inode) & I_VERITY_BUILDING) {

fsverity_is_building()?

> +static inline bool fsverity_is_building(const struct inode *inode)
> +{
> +	return inode_state_read_once((struct inode *)inode) & I_VERITY_BUILDING;
> +}

It would make more sense for inode_state_read_once() itself to take
'const struct inode *'.  Then the cast wouldn't be needed.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
