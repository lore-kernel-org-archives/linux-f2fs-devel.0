Return-Path: <SRS0=4l6L=LE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D609C48BDF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Jun 2021 22:57:51 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0DEF613E7
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Jun 2021 22:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0DEF613E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lrTcP-0004hQ-FK; Thu, 10 Jun 2021 22:57:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1lrTcN-0004hJ-Tq
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Jun 2021 22:57:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GcyB3ZAoJTR6u5KARIiAeEFmH9OCUx8sDi6gyfwhhaQ=; b=d8aJ+h1Rp+xP4HKNSftKT6BRdP
 1Va3wZlT9F0D2XRcAeGF87OyMJPxy1waV01ORSYuBlpieN/2CU2Xysu7u7gO61PF5WMrx5RdOlSP/
 f8OpAYDcNH2G9v2qU/uj8mHsC0O0+9Gvfsv7ZXJ8ZksFq1mj3A8tmKOMJ1PiVnKxp8VU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GcyB3ZAoJTR6u5KARIiAeEFmH9OCUx8sDi6gyfwhhaQ=; b=ZPbz+07W1TY3tQCZiAlAUHtlCR
 R9c9vJlBPQyZVydY/Ymoi5BCfTwetVXUYqm5tv/nk4SonY/oR1i3BtQIA7lerN0tK+YAV7IThBo6K
 U0U2tlgygO04WVSByoA4rSpP6sBALVHVJW7NreJgsMLFtjDXxMfD+hNghBwYQ0Hvbs9k=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lrTcG-00045p-Na
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Jun 2021 22:57:46 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id E79A6613E1;
 Thu, 10 Jun 2021 22:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623365849;
 bh=2qdiKDsyqPFhDYPrvVgVTKvPw/sEvqf7zh726VLz6oY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p4QOnH+iB2+HQX/xjqiXTm6GkBuwf0HXl0tubPc4tqIchX5M/JPj+0aXJc4H1dRc6
 iHWYY3W8LfE5UR7maDeWIoS6+BDG9TL7DGJJg6qkreFBER7x77XoctmWwnojk2UFTn
 CWszSxnOAGk9zOy+uPvvMeBKFVAwEhMD0Bmf3K7ZGcRSSN2XGBZ2lBo68IqOYOGt5N
 aJWUBo+VrJ+mMlsxJ1pGQviVSJ7lgBZJORUm/c+fp+1rm+Z4Zf0oNPPW9fNKeplWxP
 OlDA9s+Uw9M/4C3csHao6xW3id36sDPefwShQ0sD4KNpbO1xMCcc1pXBa7RxF8EQN3
 HTXjdy0o2gCeg==
Date: Thu, 10 Jun 2021 15:57:27 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YMKY11PC5y/EfZYf@gmail.com>
References: <20210608000022.5509-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210608000022.5509-1-chao@kernel.org>
X-Headers-End: 1lrTcG-00045p-Na
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce f2fs_casefold_name slab
 cache
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jun 08, 2021 at 08:00:22AM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Add a slab cache: "f2fs_casefold_name" for memory allocation
> of casefold name.

Commit message should say "f2fs_casefolded_name", not "f2fs_casefold_name".

> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> - change slab cache name to "f2fs_casefolded_name"
> - add a "f2fs_" prefix for slab cache variable name
>  fs/f2fs/dir.c      | 17 +++++++++++------
>  fs/f2fs/recovery.c |  6 +++++-
>  fs/f2fs/super.c    | 24 ++++++++++++++++++++++++

Otherwise this looks good.

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
