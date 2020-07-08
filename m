Return-Path: <SRS0=VsZi=AT=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395F8C433E1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:35:08 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01CE6206F6;
	Wed,  8 Jul 2020 17:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="bLhM7H97";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="X0r7ikzS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjBbRT/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CE6206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jtDyM-0002ne-Tn; Wed, 08 Jul 2020 17:35:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jtDyM-0002nX-GU
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Jul 2020 17:35:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ayBfljLvFMqbXkyr399Dq06k0B+LKcGGmBvZCgJVThY=; b=bLhM7H97CowDmfw9JrBRMRZwR+
 0mqYd/WcM/5NMwJ6svOg11b3znhCvAw7I7N8JKOzMNwH4PoWXJy4BbGuZl1+w2h5qUhuMBNU0+9Vd
 3qrAS+2sryWNH+C9TfGPo57IcmRybLGbq88AMWqyy7r/a0NS9iB6+GO9iUzMLEz8AIuY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ayBfljLvFMqbXkyr399Dq06k0B+LKcGGmBvZCgJVThY=; b=X0r7ikzSHbYf6m2sGmcEcazOJx
 Qvy+MRcFk4PcBdoq4B+a9LAKY27DWgCLlqX+QVsEdjScYqwLkfJ0awD1mtP0lU0XgOWhv0xGa8eoW
 JKRb3eLujkwlxHcPtkGVIajcJf7jscWmXTLrMBaf4ku0EYQRENSHwvz1EBWE0NxIbaf0=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jtDyF-00ENQf-Gu
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Jul 2020 17:35:06 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EE22B206F6;
 Wed,  8 Jul 2020 17:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594229694;
 bh=n09ugl6WfqWNGruKtsGDgvdM0O8WqlobftThyJ0oyVo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tjBbRT/biosB1x+FYkug66Yhj2kJWisFl+iImfCbRhGlPgbns+b6Uh4j/OzMF/AKW
 VcfyCcgyvEWJ2cCIBonSl2YoUxIRw/2lRpkpreN+9TTP/QpLNM15VBmodOee2mP43J
 hW7JXhguxafrj1Ttet7Lj2FtiQQXTEqFd/WGYrGc=
Date: Wed, 8 Jul 2020 10:34:52 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: tytso@mit.edu
Message-ID: <20200708173452.GA32199@sol.localdomain>
References: <20200702015607.1215430-1-satyat@google.com>
 <20200702015607.1215430-5-satyat@google.com>
 <20200708171812.GF1627842@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200708171812.GF1627842@mit.edu>
X-Headers-End: 1jtDyF-00ENQf-Gu
Subject: Re: [f2fs-dev] [PATCH v4 4/4] ext4: add inline encryption support
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
Cc: linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jul 08, 2020 at 01:18:12PM -0400, tytso@mit.edu wrote:
> On Thu, Jul 02, 2020 at 01:56:07AM +0000, Satya Tangirala wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Wire up ext4 to support inline encryption via the helper functions which
> > fs/crypto/ now provides.  This includes:
> > 
> > - Adding a mount option 'inlinecrypt' which enables inline encryption
> >   on encrypted files where it can be used.
> > 
> > - Setting the bio_crypt_ctx on bios that will be submitted to an
> >   inline-encrypted file.
> > 
> >   Note: submit_bh_wbc() in fs/buffer.c also needed to be patched for
> >   this part, since ext4 sometimes uses ll_rw_block() on file data.
> > 
> > - Not adding logically discontiguous data to bios that will be submitted
> >   to an inline-encrypted file.
> > 
> > - Not doing filesystem-layer crypto on inline-encrypted files.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > Co-developed-by: Satya Tangirala <satyat@google.com>
> > Signed-off-by: Satya Tangirala <satyat@google.com>
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> 

Thanks Ted.  I've applied this patch to fscrypt.git#master for 5.9.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
