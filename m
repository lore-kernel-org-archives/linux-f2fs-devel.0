Return-Path: <SRS0=kpNU=UR=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA7CC31E5B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:59:00 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1C120B1F;
	Tue, 18 Jun 2019 16:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="QI8vSQ3H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="N0d79Lwa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LE7EIq6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1C120B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hdHRl-0003tQ-9u; Tue, 18 Jun 2019 16:59:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hdHRk-0003tD-6l
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Jun 2019 16:59:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ba0gztegHdc3FcAtZ2vVMJRPI3+wba7mPsv30HD/IZY=; b=QI8vSQ3HVL8A5muUUu5bYGFKpl
 ucYv0+qQk6qIC7U4b4iGWUt99e7NeWix05h9/JP92UM36LhSdxDE8TJRsfoS3egUbLmMppZ+lJvqZ
 pyVX1Nmg1136WT2qG13b1TUS5P6cgVXo6F0RaV/3wDWkvlDIlIpYBSR6v1eMesICarTI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ba0gztegHdc3FcAtZ2vVMJRPI3+wba7mPsv30HD/IZY=; b=N0d79Lwa2Qowz/LwdWs3cD4X+R
 1upVrDPDcbJD8zzVmR3ebjjXM6oSLaC42w96t3TWQBy5hKzurhFe1FspwhzsPHPPzNrpLVgrgy2sg
 EIyGi4ZdzrR0T1pgW8N4mMF8WX3eStClSWxyotGmNQwWcOJu4/yKfvL//Gph9v4C73oc=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hdHRh-003HPv-Aw
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Jun 2019 16:58:59 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5F52B206E0;
 Tue, 18 Jun 2019 16:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1560877131;
 bh=3vKBeAv0ShrIxat0BRxsGm3sPQZrnnaIEz4l4EoSWqQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LE7EIq6eA2PpxpOB1likILRe0O8eGxX/GDvOgCYGT38/kRS9NlSM1Kuz5tGlTlTm0
 wnaCikRm2uhxP3Pv2kbqMbs6aaqTTjd2hbYAt5k4w08SaLKVg8D7DsKU3aBQjBmY56
 Inj4c3YclM86a8bTlmUILWCHPZboeq+XH8FsmLDM=
Date: Tue, 18 Jun 2019 09:58:49 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Message-ID: <20190618165849.GE184520@gmail.com>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-14-ebiggers@kernel.org>
 <20190615152143.GN6142@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190615152143.GN6142@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1hdHRh-003HPv-Aw
Subject: Re: [f2fs-dev] [PATCH v4 13/16] fs-verity: support builtin file
 signatures
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
Cc: "Darrick J . Wong" <darrick.wong@oracle.com>, linux-api@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-integrity@vger.kernel.org,
 linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, Victor Hsieh <victorhsieh@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Jun 15, 2019 at 11:21:43AM -0400, Theodore Ts'o wrote:
> On Thu, Jun 06, 2019 at 08:52:02AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > To meet some users' needs, add optional support for having fs-verity
> > handle a portion of the authentication policy in the kernel.  An
> > ".fs-verity" keyring is created to which X.509 certificates can be
> > added; then a sysctl 'fs.verity.require_signatures' can be set to cause
> > the kernel to enforce that all fs-verity files contain a signature of
> > their file measurement by a key in this keyring.
> 
> I think it might be a good idea to allow the require_signatures
> setting to be set on a per-file system basis, via a mount option?  We
> could plumb it in via a flag in fsverity_info, set by the file system.

Perhaps, but this is something that can be added later, so I think we should
hold off on it until someone needs it.

> 
> Other than this feature request, looks good; you can add:
> 
> Reviewed-off-by: Theodore Ts'o <tytso@mit.edu>
> 

I assume you mean "Reviewed-by" :-)

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
