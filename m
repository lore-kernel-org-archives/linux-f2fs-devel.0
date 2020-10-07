Return-Path: <SRS0=f5/U=DO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC68C4363C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Oct 2020 21:21:23 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17072083B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Oct 2020 21:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="hpvEob5T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="YUbrKaRy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBsJfroY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17072083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kQGsD-0000nZ-UG; Wed, 07 Oct 2020 21:21:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kQGsC-0000nS-PY
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 07 Oct 2020 21:21:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fBDs+1TPjLqEYaeFm5/JMUStUPXgazOh4AUSsrJjilQ=; b=hpvEob5Tw5wILrGhFWhBi1QJ2C
 MwTEnTEtkXO9x6Cwt8yHWo9NqppM3naxGOyPUYGve2F9mp6F4F68u3sZMXpxcyoCnrtAh6OV13h1g
 5XDbUF6twBSCQz3TYK03nMqXvm6Gep4tuQORF8fhP2X21ONcS1sASw/s3Z7NV2aa3dY8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fBDs+1TPjLqEYaeFm5/JMUStUPXgazOh4AUSsrJjilQ=; b=YUbrKaRyLfPnVnRRFdMhpABNr8
 95hvkohBo8iIkMcSRJ+fi5RsTYfIL7UkKK7pHJmn8+gwPXdIiDIubn4gJE01W2/DTEX9JhGjrpiWB
 5MEUjYKfUEy6/u44OmXlrYvNs/Mq1FmtaSRnF+Id9MvzvmzpUivHWwM5s0/ZAONO6SZM=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kQGry-006UAT-Kr
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 07 Oct 2020 21:21:20 +0000
Received: from gmail.com (unknown [104.132.1.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C08952083B;
 Wed,  7 Oct 2020 21:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602105654;
 bh=zenTSMmmb5eoRKiXCYgBR26ANJMtA08lFO4cBuL9ebw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mBsJfroYtovwhJx/hZzE6EiVmQp8z2bwboXPwbY3mPrt7JG9O2mySDQHT+Tm5qxzP
 O674Ww+cCnufqlNRk6YUyA9CXZj6VKEJkOqik4Qa/nQ9+xpWDXFfZyBueAKFMCTKE/
 7zImGzySs7JGLKEhB9Zm41gorW65f8m9A46g8EwI=
Date: Wed, 7 Oct 2020 14:20:52 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20201007212052.GC1530638@gmail.com>
References: <20201005073606.1949772-1-satyat@google.com>
 <20201005073606.1949772-4-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201005073606.1949772-4-satyat@google.com>
X-Headers-End: 1kQGry-006UAT-Kr
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: Add metadata encryption support
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
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Oct 05, 2020 at 07:36:06AM +0000, Satya Tangirala wrote:
> Wire up metadata encryption support with the fscrypt metadata crypt
> additions.
> 
> Introduces a new mount option for metadata encryption -
> metadata_crypt_key=%s. The argument to this option is the key descriptor of
> the metadata encryption key in hex. 

It's unclear what "key descriptor in hex" means in this context.  Keys in the
Linux keyrings subsystem can be specified either by an integer ID or by a string
"description".

fscrypt_policy_v1 has an 8-byte binary master_key_descriptor, which specifies a
keyring key with description "fscrypt:" + ToHex(master_key_descriptor).  So I'm
guessing that's where this terminology is coming from.

However, here the value passed to metadata_crypt_key is just a key description
that's passed directly to the Linux keyrings subsystem.  I don't see why it has
to be a hex string (and it fact, it seems it's not enforced?).

The current proposal is also missing any sort of key verification.  The
filesystem will use any key that is provided, even if a different key was used
at format time.

In "fscrypt v2", we solved the equivalent problem by making the keys be
specified by a HKDF-derived master_key_identifier.

How about doing something similar for the metadata encryption key?  I.e. the
metadata encryption key could be used as input to HKDF to derive two subkeys:
metadata_key_identifier and the real metadata encryption key.  Then
metadata_key_identifier could be stored in the superblock.  Then the filesystem
could request the keyring key "fscrypt:" + ToHex(metadata_key_identifier) at
mount time, which would eliminate the need for a mount option.

> Direct I/O with metadata encryption is also not supported for now.
> Attempts to do direct I/O on a metadata encrypted F2FS filesystem will fall
> back to using buffered I/O (just as attempts to do direct I/O on fscrypt
> encrypted files also fall back to buffered I/O).

What would it take to get direct I/O working?

> +#ifdef CONFIG_FS_ENCRYPTION_METADATA
> +	if (metadata_crypt_alg &&
> +	    !fscrypt_metadata_crypted(sb)) {
> +		f2fs_err(sbi, "Filesystem has metadata encryption. Please provide metadata encryption key to mount filesystem");
> +		return -EINVAL;
> +	}
> +#endif

Please try to avoid #ifdefs.  It looks like some of these could be replaced with
IS_ENABLED() or the use of stub functions.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
