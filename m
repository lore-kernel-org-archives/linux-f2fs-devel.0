Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC4AC46CD2
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Jan 2024 03:05:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rSq3m-0005oG-UU;
	Thu, 25 Jan 2024 03:05:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1rSq3m-0005o4-09
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Jan 2024 03:05:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R7lVZpcxIo/fskWnBX7E++DalAuH+CS+W2ZfJ0YRyJs=; b=ghTQXa3YXhAPatmH2xffTnf9jp
 sNH7gBhVlgr3u4Z4vAP9MkbPO/40/X9/KY6AY9z9kPaUYHuwOXCH1bv2qYv3fAV1OyMy1AkcD4qZP
 66vXs9waXx1bNemvVjZ/VraGejCGaHT7fjA8RNmbH6DCxtSRfKww7gVpSv57hAmMm92o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=R7lVZpcxIo/fskWnBX7E++DalAuH+CS+W2ZfJ0YRyJs=; b=TRY8WtdyCzzNz6b6avIxUrM0to
 wo3MEq3D0Tfrtv/3M/Gbg6eEIu0oyaZsP78gPUmEpqwdu1Nj/0Guos6uv5kWvh4fqHRFTzQKlo/et
 5UmfbO6pCJn0cpQjW6sr93wzn2HHzkDYRziAkASjhjxoUktTLjaRtD3/Nt8O1j3BOsks=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rSq3l-0005eG-43 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Jan 2024 03:05:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D5FE4CE09E4;
 Thu, 25 Jan 2024 03:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F35DC433F1;
 Thu, 25 Jan 2024 03:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706151932;
 bh=k/lcg2zazVrlN5kWliEtrgP95ZsgX1rocgc1aIdg3L4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C2MBZ2Ii8noSNTJIR9GJXA/gpybC54e7/5EkfmuEekhstUGgZBwcYYV7cn5pvnmFj
 mnI91/Enut3AM5eLngfH35zaZXbp/aaoypZPhVJ1csin1MBrgy1J8zlfKF6RkWFC4H
 1038qtJRm8ANP8twzH7GGrGr1boqXCBxtwCCkVX2qDaZgUvmE9Z8jwz9/ByhXw8OLI
 bCXBsupFXihzmYcAyHi5K8rxJiuj3XFotYLULPttjSAmSl9fQQP418LAvDWHBG04Yf
 xqvaNZ/pqPLly+hnluO8JNn141QNZl3ge17G7QrHsO/LGe6z9UlDV48Tf6fyK8j3je
 HFIW9zCxGXjDg==
Date: Wed, 24 Jan 2024 19:05:30 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Message-ID: <20240125030530.GB52073@sol.localdomain>
References: <20240119184742.31088-1-krisman@suse.de>
 <20240119184742.31088-3-krisman@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240119184742.31088-3-krisman@suse.de>
X-Headers-End: 1rSq3l-0005eG-43
Subject: Re: [f2fs-dev] [PATCH v3 02/10] fscrypt: Share code between
 functions that prepare lookup
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
Cc: tytso@mit.edu, amir73il@gmail.com, linux-f2fs-devel@lists.sourceforge.net,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jan 19, 2024 at 03:47:34PM -0300, Gabriel Krisman Bertazi wrote:
> To make the patch simpler, we now call fscrypt_get_encryption_info twice
> for fscrypt_prepare_lookup, once inside fscrypt_setup_filename and once
> inside fscrypt_prepare_lookup_dentry.  It seems safe to do, and
> considering it will bail early in the second lookup and most lookups
> should go to the dcache anyway, it doesn't seem problematic for
> performance.  In addition, we add a function call for the unencrypted
> case, also during lookup.

Unfortunately I don't think it's correct.  This is basically undoing my fix
b01531db6cec ("fscrypt: fix race where ->lookup() marks plaintext dentry as
ciphertext") from several years ago.

When a lookup is done, the filesystem needs to either treat the name being
looked up as a no-key name *or* as a regular name, depending on whether the
directory's key is present.  We shouldn't enable race conditions where, due to
the key being concurrently added, the name is treated as a no-key name for
filename matching purposes but a regular name for dentry validation purposes.
That can result in an anomaly where a file that exists ends up with a negative
dentry that doesn't get invalidated.

Basically, the boolean fscrypt_name::is_nokey_name that's produced by
fscrypt_setup_filename() should continue to be propagated to DCACHE_NOKEY_NAME.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
