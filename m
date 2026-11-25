Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89786606A321
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Nov 2026 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UmRPdnOD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=m/5x0wmi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=E26tuMhe;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNqySscf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=R2JtCi57ylRdwwdkpYjCqQ8trP0uttUIrphmlSY/mAs=; b=UmRPdnODenNaLTs3wzSAKRiivl
	nbBSmuRYmIZcTjstkd26qhiaNng2ZQedCqGoFvxZc5YRAjbP6XFMU29PpDQOC18XHasB3He2W3OsR
	8az9Q0wwOoDi9xrPTIKsjDPMe8XdO6lvenybHVgCWqBDlNQo+MQbWCukVRoj4XYTdAJ4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xW24U-000000001Qj-0nK8;
	Wed, 25 Nov 2026 01:45:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ebiggers@kernel.org>) id 1xW24E-000000001QV-3zlK
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 01:45:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=75zW4Phu6PXTI9gPGLcPCmj4B7p94Zt/j+BgJVF3UqA=; b=m/5x0wmijRYzA3GBnIEl4NEMRt
 eVqm90aVPIKu3E//rZ7txn2le74Z/KcZQHc3kfl6S8SC8it+OuoD1zq1Ey91MJod/H6uymDe9njGN
 QCNLmxxeIlop4tQK0dMAqttYna5w47GiQd+t1UVWI6Y4BbjReON2cSNNkzosYQ81dqQY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=75zW4Phu6PXTI9gPGLcPCmj4B7p94Zt/j+BgJVF3UqA=; b=E26tuMheQ088oFR1jZxeVN5Za7
 5MR5e+5mUgsLZpVznOr4HaVse5Fes+E6QtkANNCSCAq2ID9W/CE7S/tWWCxPGhRo+6ySPGTfp8frL
 WXciKNdt7FFV/znBrPV3881N96NLTsFcSjv4Z0nTFoogNfgwmDr13eSkycHR0M88w7rU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xW24E-0000000030x-0RV9
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 01:45:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9BFCE43EEA;
 Wed, 25 Nov 2026 01:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF9E1F000D8;
 Wed, 25 Nov 2026 01:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795571096;
 bh=75zW4Phu6PXTI9gPGLcPCmj4B7p94Zt/j+BgJVF3UqA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ZNqySscfzxgbRoGmXo/aFHMB9RG4dr6QvIwOvsEPeXqKYDXXVz/4dy1RfzFWAD1AG
 IU1IVZxZNHy/VFxNPV4QKnlgVUviFdTfjubawhOuTzL/Lp4YWEjT/E5kOTvLMm8Fia
 U/+wfWCOBJui+jyFB6xn1USY0vUFK6owi2OmIHODoyPYAJjc8OAjlttKVXpO6nZuFG
 oD/uNWGmmA1umkGUrkf9/6oidX7PO37N5XweGHLbraUJ2soUALMqkVMo8UqDs1bp2i
 yyd3GpFHbm0Z+ypUeBnWr1JEjXeZfAWDo4aXXYt75ENtrJFen++bZ6B1zCWYc5VQO7
 SGEs4JBA1tI1Q==
Date: Tue, 24 Nov 2026 17:44:54 -0800
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Message-ID: <20261125014454.GA2461@sol>
References: <20261123181408.62972-1-laveeshb@laveeshbansal.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261123181408.62972-1-laveeshb@laveeshbansal.com>
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xW24E-0000000030x-0RV9
Subject: Re: [f2fs-dev] [PATCH v2] blk-crypto: use a NOIO scope while
 holding profile->lock
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
Cc: Jens Axboe <axboe@kernel.dk>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-crypto@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 syzbot+20d60aafd9a0d1f2a380@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 10:14:08AM -0800, Laveesh Bansal wrote:
> setkey allocates with GFP_KERNEL (Adiantum)

We should just fix that one:
https://lore.kernel.org/linux-crypto/20261125013553.94480-1-ebiggers@kernel.org/

We should still proceed with this patch, but there is really no need for
the crypto code to allocate memory in random places.  I've been working
on getting rid of cases like this.

> Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")
> Cc: stable@vger.kernel.org # v7.3+

The v7.3+ should not be there.

> @@ -53,11 +54,14 @@ static inline void blk_crypto_hw_enter(struct blk_crypto_profile *profile)
>  	if (profile->dev)
>  		pm_runtime_get_sync(profile->dev);
>  	down_write(&profile->lock);
> +	/* Reclaim evicts keys under this lock; don't recurse into the fs. */
> +	profile->memflags = memalloc_noio_save();
>  }

"don't recurse into the fs" describes memalloc_nofs_save(), but the code
actually uses memalloc_noio_save().  The code is right, so a better
comment might be:

        /* Avoid recursing into I/O or fs reclaim while holding profile->lock */

>  static inline void blk_crypto_hw_exit(struct blk_crypto_profile *profile)
>  	__releases(&profile->lock)
>  {
> +	memalloc_noio_restore(profile->memflags);

Storing the flags in blk_crypto_profile isn't necessary.  It should just
be a stack variable, returned by blk_crypto_hw_enter() and consumed by
blk_crypto_hw_exit().

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
