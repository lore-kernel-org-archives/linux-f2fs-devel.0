Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65581C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Jan 2022 09:04:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nATMq-0000ah-IM; Thu, 20 Jan 2022 09:04:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1nATMp-0000ab-NG
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Jan 2022 09:04:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rmXc3oNZu1+BkAlGkUyo9VOhcB8K3UU/OZLIIt/S3WY=; b=Y3Gv3jJZ9Q7D4aFZyBZcP1omp4
 0JLed91R9cSWb7I0L4qW8tfgtkB4K08OrdOc6nSUQk6BNYJWxH044FqCrmrw9yzWrUco68njEybgN
 TOext82EeD5SUO/uBsEtMO3R+75YxirP1mEco/E+ef+hIfLR++Q/vgTNcFPRJpVdwBTY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rmXc3oNZu1+BkAlGkUyo9VOhcB8K3UU/OZLIIt/S3WY=; b=RnA427d1QQUklo6Ap1Gc1cmEBU
 rYj6W+bcPcyBZWs/cW7xCIVGTA2x180zFZ9jcRsMc8PFuURtSPEByNCROqVmJv9vcgZZMBbcCZ6jd
 yf3IyJmuUS1NTrwsiBejO7zmbM0KGVBGPeCyrPAVxjU9mu400jqtAXxWKdQIQWYc1Rmg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1nATMn-004hhN-Nu
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Jan 2022 09:04:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 62A85617A5;
 Thu, 20 Jan 2022 09:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740ACC340E0;
 Thu, 20 Jan 2022 09:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642669459;
 bh=pfcthZCzooY2kl7Qa+cy/1Et4X5WXDRQLsSpT+07JNk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C4VrIZYfGPgn0lzFMGsDmv/5TJ65MtkSeLkZ/xugErRO7yEmM4T4FUpDKKp9LkDZy
 m8nHN+Zv9vYV74Fn9nFjB+k1iKKVZrT8SYKWQ9NloeIENKz9SjLn9ekr6svNGmlu9X
 9E/T5KZS/LphCPHQp879QSPVdpzM0XMkIV6e4DlDR+4VH2Q7Ri1v5lOHFotzeQeQEE
 nkI8FaSX9rs8WMHkIUd28GD0IzwAkP1FX+iX0Ha+d2y0f0pdnoTGc7N0JTJzMEBqcJ
 5y5fmKtLWxbDHNdHEGMtZRGwwHCJQOIca4mT4LQ3CanX8yoM1G7an7HiaMPVVWYm9E
 BXhiBw6TTdh+A==
Date: Thu, 20 Jan 2022 01:04:17 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <Yeklkcc7NXKYDHUL@sol.localdomain>
References: <20220120071215.123274-1-ebiggers@kernel.org>
 <20220120071215.123274-2-ebiggers@kernel.org>
 <YekdAa4fCKw7VY3J@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YekdAa4fCKw7VY3J@infradead.org>
X-Headers-End: 1nATMn-004hhN-Nu
Subject: Re: [f2fs-dev] [PATCH v10 1/5] fscrypt: add functions for direct
 I/O support
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
Cc: Satya Tangirala <satyat@google.com>, Theodore Ts'o <tytso@mit.edu>,
 "Darrick J . Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jan 20, 2022 at 12:27:45AM -0800, Christoph Hellwig wrote:
> > +/**
> > + * fscrypt_dio_unsupported() - check whether a DIO (direct I/O) request is
> > + *			       unsupported due to encryption constraints
> > + * @iocb: the file and position the I/O is targeting
> > + * @iter: the I/O data segment(s)
> > + *
> > + * Return: true if DIO is unsupported
> > + */
> > +bool fscrypt_dio_unsupported(struct kiocb *iocb, struct iov_iter *iter)
> 
> I always find non-negated functions easier to follow, i.e. turn this
> into fscrypt_dio_supported().
> 

I actually had changed this from v9 because fscrypt_dio_supported() seemed
backwards, given that its purpose is to check whether DIO is unsupported, not
whether it's supported per se (and the function's comment reflected this).  What
ext4 and f2fs do is check a list of reasons why DIO would *not* be supported,
and if none apply, then it is supported.  This is just one of those reasons.

This is subjective though, so if people prefer the old way, I'll change it back.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
