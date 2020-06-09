Return-Path: <SRS0=y0JV=7W=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E1EC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:28:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EBA7206C3;
	Tue,  9 Jun 2020 20:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="gKfzYz/R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="jYVwYvtf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4T3MvRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBA7206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jikrM-00040A-A1; Tue, 09 Jun 2020 20:28:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jikrK-0003zs-S7
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Jun 2020 20:28:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+nGOUuwUm4OFMEjc70BUu/umLDgPAvkbw28M/iO+29A=; b=gKfzYz/R0kXQGIfLr5Qu08/MUb
 Qan5pxLkkK9UDVyDJxl7WoTQk/X1RXyiBBFrTxDM5Km0IPdgIxxlQnmyo4nb8mKSz713Nd+A+dCWa
 kREMVGkwoJ3yTSOmuHPIHx0nRCFEGx1scmTuhOymaZlLXqWUmLm3moZiRsOYOX7xi7Yk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+nGOUuwUm4OFMEjc70BUu/umLDgPAvkbw28M/iO+29A=; b=jYVwYvtfw54A8CPV9uKZ5EjA3W
 5ifAToUGU0LYY0wl46ZEWyCtYFCdjYqyO4Le/vfzrvlRMC1110RLaW6xqPyPtyv22YNNijRRFPaE+
 ImGzsAS+v+3SdCNRBrz36JS/v+MQ2TF/sW3M5QHasKrAhdFWPV48o0+3N6Is2dT84fA0=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jikrJ-00F0LF-0S
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Jun 2020 20:28:34 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7DB8A206C3;
 Tue,  9 Jun 2020 20:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591734502;
 bh=H/1jyA2ENEl76fko3i9AUC1qpu0Coz7F0CswtYS3WFg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P4T3MvRrVMmtF3DbaNR6Vf9oaL5Jydxxzs2uKXV09TAGaRgb3FsE2ef7SwvZALph5
 oLzKqq/yk82ZVm20+xmwMUS0IlcojUDB+UExygverfwT7n9SSgELPQgUAZuSMTp3+/
 zSn333TkeHIJXbPbfcPqt0I9lUR/Dp6eiEyNsjFA=
Date: Tue, 9 Jun 2020 13:28:21 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Message-ID: <20200609202821.GB1105@sol.localdomain>
References: <20200601200543.59417-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200601200543.59417-1-ebiggers@kernel.org>
X-Headers-End: 1jikrJ-00F0LF-0S
Subject: Re: [f2fs-dev] [PATCH v2] ext4: avoid utf8_strncasecmp() with
 unstable name
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
Cc: Daniel Rosenberg <drosen@google.com>, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jun 01, 2020 at 01:05:43PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> If the dentry name passed to ->d_compare() fits in dentry::d_iname, then
> it may be concurrently modified by a rename.  This can cause undefined
> behavior (possibly out-of-bounds memory accesses or crashes) in
> utf8_strncasecmp(), since fs/unicode/ isn't written to handle strings
> that may be concurrently modified.
> 
> Fix this by first copying the filename to a stack buffer if needed.
> This way we get a stable snapshot of the filename.
> 
> Fixes: b886ee3e778e ("ext4: Support case-insensitive file name lookups")
> Cc: <stable@vger.kernel.org> # v5.2+
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Daniel Rosenberg <drosen@google.com>
> Cc: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> v2: use memcpy() + barrier() instead of a byte-by-byte copy.
> 
>  fs/ext4/dir.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Ted, could you take this through the ext4 tree as a fix for 5.8?
The f2fs patch has been merged already.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
