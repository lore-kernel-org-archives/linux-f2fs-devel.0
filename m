Return-Path: <SRS0=GBMW=C7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B268C4727C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:02:01 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E94B2388B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="cLplDiI7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="OdttV5A2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIYsmBEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E94B2388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kKkjt-0002yf-Cr; Tue, 22 Sep 2020 16:01:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1kKkjs-0002yU-8J
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 22 Sep 2020 16:01:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U53o4Nf/mJvxOqSmrcekJr3kj4Ffi5I5PbQ32Cxwwfo=; b=cLplDiI7OS2Lq/KdEtmErPgMRs
 IAkhzL4BG3X7RMtVr+ktSAUsgiq51V1M7InWz1ec6GUJmlkIHhXGlX+ke5ywOOi7WuLR8EV+Jvbw/
 2tin+ZM8RCZk4HFhGuV+XeAsb6LaZ927V6pl13w5rKi9CrDcywTXiuugetyc5S4k9HK8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U53o4Nf/mJvxOqSmrcekJr3kj4Ffi5I5PbQ32Cxwwfo=; b=OdttV5A2P7xFq/KmWmirjNswGY
 C9Q3WI/KH9YYqBBoE+3Vlok5V/k8RifJGCbH25XtQ7B4C8YWQtssBNvvPWMaCfZ8pgNKcXDQZ2YGB
 tGQDw1I1WHyu/8rjvHZOCnCpTg0htOjDGAnbZYcv50YwXeDHrFn4DVkeFZUgekHzUGA0=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kKkjq-003NNd-46
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 22 Sep 2020 16:01:56 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B00672399A;
 Tue, 22 Sep 2020 16:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600790499;
 bh=+JbPuKTQwLYiRtLrv7dRgf3ndqTICplWlXGxANCBloY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UIYsmBEGgBG28a67cc36efeTmr+VyZEYubJkA1CnDNucRlSPGUUMf82astmsgTQ1B
 oNOuT+s12Ov2S/HKXGJWAeiuAaMlIRPqbOrYPRIKP1mi3oYwgjJ2ObNlSgaMEDeXVp
 P6br8rNFA/3F7DPqLISqW6RMXWF8Emrl79vwMOdQ=
Date: Tue, 22 Sep 2020 09:01:39 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20200922160139.GA3718581@google.com>
References: <20200922104807.912914-1-drosen@android.com>
 <20200922135940.GB5599@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200922135940.GB5599@sol.localdomain>
X-Headers-End: 1kKkjq-003NNd-46
Subject: Re: [f2fs-dev] [PATCH 0/5] Add support for Encryption and
 Casefolding in F2FS
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
Cc: kernel-team@android.com, "Theodore Y . Ts'o" <tytso@mit.edu>,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>,
 Daniel Rosenberg <drosen@android.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 09/22, Eric Biggers wrote:
> On Tue, Sep 22, 2020 at 03:48:02AM -0700, Daniel Rosenberg wrote:
> > These patches are on top of the f2fs dev branch
> > 
> > F2FS currently supports casefolding and encryption, but not at
> > the same time. These patches aim to rectify that. In a later follow up,
> > this will be added for Ext4 as well. I've included one ext4 patch from
> > the previous set since it isn't in the f2fs branch, but is needed for the
> > fscrypt changes.
> > 
> > The f2fs-tools changes have already been applied.
> > 
> > Since both fscrypt and casefolding require their own dentry operations,
> > I've moved the responsibility of setting the dentry operations from fscrypt
> > to the filesystems and provided helper functions that should work for most
> > cases.
> > 
> > These are a follow-up to the previously sent patch set
> > "[PATCH v12 0/4] Prepare for upcoming Casefolding/Encryption patches"
> > 
> > Daniel Rosenberg (5):
> >   ext4: Use generic casefolding support
> >   fscrypt: Export fscrypt_d_revalidate
> >   libfs: Add generic function for setting dentry_ops
> >   fscrypt: Have filesystems handle their d_ops
> >   f2fs: Handle casefolding with Encryption
> 
> I only received the cover letter, not the actual patches.  Same for the lore
> archives; they only have the cover letter.

Me too. :)

> 
> - Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
