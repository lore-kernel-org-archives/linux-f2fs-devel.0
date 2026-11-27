Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DB9606A31E
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CZheUjyE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=X32NXM7b;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FWNLG5QA;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQDG1jY3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=q8/lGyaD0d+uOhGs1uJg8KnoAPL7X1hxjZ6juXJ0Uko=; b=CZheUjyEQNpcfyI0S8TseWyvYQ
	29cPCdYFCZ8VfNEAW0HARKMRX93qQXsCzCuLrMZoVl5DTGXr+y3Ev3o/cFJL9O+mbi5tUbCqLMqmI
	DYINMrizw9c3rA3N5rfYSegjjtsX64Nkw8Eypn6bQvBgPoaDJWifhMqMkfB/yXUdTEJs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xX0ze-000000007zX-2490;
	Fri, 27 Nov 2026 18:48:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ebiggers@kernel.org>) id 1xX0zd-000000007zR-2Iq7
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 18:48:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kTWfwLU9AK6CypFMW27FabInezsO4qPOmYZqmCY8gzk=; b=X32NXM7bKn239O/p/5enOAE2jK
 8XjeSSYqtdv0msWzKdCM7wvEOjSw13hFk2ezrQO2fLciCj5TNqtH35O8S2HBISiTht6On0lMxV44B
 /MBIOwvUCa599J6C7sGW9ilIYTpGO+zmVRanVhlWK9KTqby2/CHfFkDfOfRHvVPE0RYA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kTWfwLU9AK6CypFMW27FabInezsO4qPOmYZqmCY8gzk=; b=FWNLG5QAa7qh+wFopjXhlvrxi6
 iVvlHq5dRZQdv7qri3g9lZKwXZyNHUULoaK99gHD7ZmA0D93uBG4uzznvMBgL40IY7MJ2stQug13x
 pEorPBkg9/d3Tk6k4bQvIrKGckGWCdY+WjNtKztfaQlF97Z+cppI7dfahts30hmg0r4Q=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xX0zc-000000002oc-0DsS
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 18:48:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 69EAB60D12;
 Fri, 27 Nov 2026 18:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EA81F0089A;
 Fri, 27 Nov 2026 18:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795805294;
 bh=kTWfwLU9AK6CypFMW27FabInezsO4qPOmYZqmCY8gzk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RQDG1jY3KRmCfeLg/3+43yn0523AOmfpBepgIF+hHdw2zdHKqvTNN91SZVu3I6YzP
 CRvLyJfFDbxlmZ9s5IvhBXVJPZ57m3wu8fIqE2BpEmW8DS6hz/w/zlb8eA5+xan9BM
 z0juE95k+S0Q+uPUXtWCL/lu6KckkbcKRJ77qtNTrHp4DHwX3RMVlfuLWHZIPUH5Fp
 Xs5R4SWilSG1tnUm3jBvfqQ+U4HLHfI4rFRZbxDzK9QnnqUL+SDcuD0hWS/4LLUvQb
 9IAQZGkI19cxmbmnPJiMNfDo58kZnU68ep7drZem52tZ07boy0TwZxfqlTjkc9zsr4
 hiP7BEGw8vYnA==
Date: Fri, 27 Nov 2026 10:48:12 -0800
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Message-ID: <20261127184812.GC1974@quark>
References: <20261125081417.77674-1-laveeshb@laveeshbansal.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261125081417.77674-1-laveeshb@laveeshbansal.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xX0zc-000000002oc-0DsS
Subject: Re: [f2fs-dev] [PATCH v3] blk-crypto: use a NOIO scope while
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 12:14:17AM -0800, Laveesh Bansal wrote:
> Setting a key in blk-crypto-fallback can deadlock on profile->lock.
> blk_crypto_get_keyslot() holds it across keyslot_program, whose setkey
> allocates with GFP_KERNEL (Adiantum); direct reclaim can evict an fscrypt
> inode, and blk_crypto_evict_key() then takes profile->lock again. syzbot
> reports it as an fs_reclaim vs profile->lock cycle. Since
> commit 5acc6f649a68 ("fscrypt: Always use blk-crypto for contents on
> block-based filesystems") hitting it no longer needs -o inlinecrypt.
> 
> Enter a NOIO scope in blk_crypto_hw_enter() and leave it in
> blk_crypto_hw_exit(), so allocations made under the lock, by the
> fallback or a hardware driver, can't recurse into I/O or fs reclaim.
> blk_crypto_reprogram_all_keys() takes the lock directly, so it gets the
> same scope.
> 
> Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+20d60aafd9a0d1f2a380@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/6a9b25c3.b5d4176b.238c3e.0004.GAE@google.com
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Laveesh Bansal <laveeshb@laveeshbansal.com>

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
