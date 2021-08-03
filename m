Return-Path: <SRS0=VCJL=M2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306E5C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Aug 2021 01:35:00 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB98C60FA0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Aug 2021 01:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DB98C60FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mAjKc-0002wK-Oc; Tue, 03 Aug 2021 01:34:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1mAjKb-0002wE-Ow
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Aug 2021 01:34:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UCIEEI9xeNj7CuW+8boHUUKyhEr5iyMtPTIlbrWDHKs=; b=SJ+WJSRVE/wTNCT/wOBudRoa2F
 fqk5oYZqEmhNrsMuaLw2HD47mY3Gco6V+zuFdIuYTDBgdF9VqDVm8NRWIvblfr8s4nqtfcKrJj4/C
 7j/gryTFvFiUWI6+ivG/CWxIQflHy4zKP0DrnI9WFaTFEedkQ1P0RbCBMGBEZY4Ezmao=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UCIEEI9xeNj7CuW+8boHUUKyhEr5iyMtPTIlbrWDHKs=; b=nTGy+s0RmXXt0wbxTmXf2pqgMh
 egtSFuKs9GOwThIaXVVTJUXjMJ2957jquySsV6Ob0nDUKNI376GBI2fDNsjtD85KRfJ0QV5hcwwsV
 SJ6XBX1KUUNN+9cVFg+XMMCE0mPj/FswZFCel2pW+gxUUmzZw4p77B2GMfW5qFFLh46E=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mAjKZ-00AhYY-Qz
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Aug 2021 01:34:57 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 455F560FA0;
 Tue,  3 Aug 2021 01:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627954490;
 bh=XRzA3NrzzEUgpsOEuNtbvyLKsenWMKiE5wFIrQcFx2Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tgaDKnP+hbvLQZXYzSVAUGYqbB3FuLq4omTfeTO1Pz2y32jDuHV8nhRUAqcWqs/U8
 l9fxboTiygfUKWrPbdU2gPVKZ5EiE0dmufn9LUwj5TeVckseuoOpXlnFPFxCqpSWXw
 NrIqvKK42kChEo+AYluJ0WNaV7fEM6L0H42L2jz05c6ng5C/bTf8V9yXAW4GK1k1k9
 va2C/Tf/5t5TcblLTTwde6RrRCTQHgkLbApoz36qVbG6ARjcaEspeo7DUr6OIVyAKP
 XRU9hp2Es1zy/7Grmi+ZlG6sfEfajF7w97x601rGidAkJi4oSY/WxOkzqU/qEH2bqC
 hhImbvyDtRTQA==
Date: Mon, 2 Aug 2021 18:34:48 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YQidOD/zNB17fd9v@google.com>
References: <20210728015154.171507-1-ebiggers@kernel.org>
 <YQRQRh1zUHSIzcC/@gmail.com> <YQS5eBljtztWwOFE@mit.edu>
 <YQd3Hbid/mFm0o24@sol.localdomain>
 <a3cdd7cb-50a7-1b37-fe58-dced586712a2@kernel.org>
 <YQg4Lukc2dXX3aJc@google.com>
 <b88328b4-db3e-0097-d8cc-f250ee678e5b@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b88328b4-db3e-0097-d8cc-f250ee678e5b@kernel.org>
X-Headers-End: 1mAjKZ-00AhYY-Qz
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove broken support for allocating
 DIO writes
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
Cc: Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 08/03, Chao Yu wrote:
> On 2021/8/3 2:23, Jaegeuk Kim wrote:
> > On 08/02, Chao Yu wrote:
> > > On 2021/8/2 12:39, Eric Biggers wrote:
> > > > On Fri, Jul 30, 2021 at 10:46:16PM -0400, Theodore Ts'o wrote:
> > > > > On Fri, Jul 30, 2021 at 12:17:26PM -0700, Eric Biggers wrote:
> > > > > > > Currently, non-overwrite DIO writes are fundamentally unsafe on f2fs as
> > > > > > > they require preallocating blocks, but f2fs doesn't support unwritten
> > > > > > > blocks and therefore has to preallocate the blocks as regular blocks.
> > > > > > > f2fs has no way to reliably roll back such preallocations, so as a
> > > > > > > result, f2fs will leak uninitialized blocks to users if a DIO write
> > > > > > > doesn't fully complete.
> > > > > 
> > > > > There's another way of solving this problem which doesn't require
> > > > > supporting unwritten blocks.  What a file system *could* do is to
> > > > > allocate the blocks, but *not* update the on-disk data structures ---
> > > > > so the allocation happens in memory only, so you know that the
> > > > > physical blocks won't get used for another files, and then issue the
> > > > > data block writes.  On the block I/O completion, trigger a workqueue
> > > > > function which updates the on-disk metadata to assign physical blocks
> > > > > to the inode.
> > > > > 
> > > > > That way if you crash before the data I/O has a chance to complete,
> > > > > the on-disk logical block -> physical block map hasn't been updated
> > > > > yet, and so you don't need to worry about leaking uninitialized blocks.
> > > 
> > > Thanks for your suggestion, I think it makes sense.
> > > 
> > > > > 
> > > > > Cheers,
> > > > > 
> > > > > 					- Ted
> > > > 
> > > > Jaegeuk and Chao, any idea how feasible it would be for f2fs to do this?
> > > 
> > > Firstly, let's notice that below metadata will be touched during DIO
> > > preallocation flow:
> > > - log header
> > > - sit bitmap/count
> > > - free seg/sec bitmap/count
> > > - dirty seg/sec bitmap/count
> > > 
> > > And there is one case we need to concern about is: checkpoint() can be
> > > triggered randomly in between dio_preallocate() and dio_end_io(), we should
> > > not persist any DIO preallocation related metadata during checkpoint(),
> > > otherwise, sudden power-cut after the checkpoint will corrupt filesytem.
> > > 
> > > So it needs to well separate two kinds of metadata update:
> > > a) belong to dio preallocation
> > > b) the left one
> > > 
> > > After that, it will simply checkpoint() flow to just flush metadata b), for
> > > other flow, like GC, data/node allocation, it needs to query/update metadata
> > > after we combine metadata a) and b).
> > > 
> > > In addition, there is an existing in-memory log header framework in f2fs,
> > > based on this fwk, it's very easy for us to add a new in-memory log header
> > > for DIO preallocation.
> > > 
> > > So it seems feasible for me until now...
> > > 
> > > Jaegeuk, any other concerns about the implementation details?
> > 
> > Hmm, I'm still trying to deal with this as a corner case where the writes
> > haven't completed due to an error. How about keeping the preallocated block
> > offsets and releasing them if we get an error? Do we need to handle EIO right?
> 
> What about the case that CP + SPO following DIO preallocation? User will
> encounter uninitialized block after recovery.

I think buffered writes as a workaround can expose the last unwritten block as
well, if SPO happens right after block allocation. We may need to compromise
at certain level?

> 
> Thanks,
> 
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > - Eric
> > > > 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
