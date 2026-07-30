Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4226FC5516D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OpvqUJvCkRr20ajFcKD8TL+gvO2JLz7px118g1bxeqs=; b=RjNYEFc+mMgw7D4rjFI0VNdAJu
	+12pexZh/ggRrs5UzE6gxGg+UxC3yS2kExj3J9tmioLoUbmMe5rSJMIBWpt5p8IaswrAlx147tkO1
	TSwiY+q6lHrBPRFeDMZf05QuV3sFXDMR3K5HzRMPd0QKixF3izs4hgwhE2zKHSHnMSJ4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wpXOO-0000Bt-TU;
	Thu, 30 Jul 2026 20:30:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wpXON-0000Bl-Qi
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 20:30:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0u6gw/MrFBT1/QNrPa7nLjvLVHSDimbPCCINT1jLXiU=; b=ENXHpCdWiyGWVKd3TbtKo2EZR/
 6UEoqiDXd/yPtnTwDGAVt/XP99AphnDxpGdmBT7G58P2eZ1NtwoZCnAezmAox7DkG3vPmiVMI/i2p
 B3JFGQBcxAxOSVxJgclbOvC8DDypz6bMPqOenkxcvBVAGLHqCrtfy1ARpKy5C/hRvx6s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0u6gw/MrFBT1/QNrPa7nLjvLVHSDimbPCCINT1jLXiU=; b=Z3wNt/yr36QhqBAExQ6+w7oIRb
 98sKoYwrPCa3uK44Bewf4Re17fSc7EfUHcyEOuHIdmqMvbipiGPg9WsTdfMiUwJV+iXbcgAs/Hyae
 2AvlFl+p+VgZyT470LNBu4pIvwr3xAcGknVoRPHzwVa4I2d4UkDHkinxTbWD91fZcslk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpXOQ-0004FQ-QU for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 20:30:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A1AA66004E;
 Thu, 30 Jul 2026 20:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57C31F000E9;
 Thu, 30 Jul 2026 20:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785443405;
 bh=0u6gw/MrFBT1/QNrPa7nLjvLVHSDimbPCCINT1jLXiU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hFcsGnLovWPcFi+YkFwXfujpvSBlB3iFd7TIwz6cMigymfDKsbs8+aVqBQftTS/Qu
 1hZlGC2QGQAmc9tlfq8EeyI0yzWmfdfg/4SRB9JmulIAJRqlKp78KxAeBd6CpjMWjA
 ZzLb6YKmWZwiQ0PQdUG+NckRDmJwdf3ZYIyLPX5wEfHj7EwJohV7fQqRzAzfk6fcaW
 46rrLmUDHXq1kFeu4lRdAs5HrO2gkrT95BMqbHyLUhf9uMEqaMGfA4hg8gN/vKCD8I
 JVu6aVSWUfm/WQnFqobITKGHVuPzXNwIhKdA74nXROb9GzBc6/rvfSbhgsEEnUNA6N
 Rmn+CdkioS94w==
Date: Thu, 30 Jul 2026 20:30:03 +0000
To: Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20260730203003.GA2459987@google.com>
References: <20260730184853.48347-1-ebiggers@kernel.org>
 <20260730125327.11fc9227d04f659a59136cdd@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260730125327.11fc9227d04f659a59136cdd@linux-foundation.org>
X-Headers-End: 1wpXOQ-0004FQ-QU
Subject: Re: [f2fs-dev] [PATCH] mm/swap: reject swapon() on filesystem-level
 encrypted files
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
 Chris Li <chrisl@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-mm@kvack.org, linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jul 30, 2026 at 12:53:27PM -0700, Andrew Morton wrote:
> On Thu, 30 Jul 2026 11:48:53 -0700 Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > ext4 and f2fs don't prevent filesystem-level encrypted files from being
> > set up directly as swap files.  In this case, encryption is bypassed.
> > 
> > No one should be doing this, vs. the methods of encrypted swap that
> > actually do work (such as swapping to a dm-crypt device, or swapping to
> > a loopback device on top of a filesystem-level encrypted file).
> > 
> > Nevertheless, to prevent user error, make swapon() explicitly reject
> > this case.  Document this behavior in fscrypt.rst as well.
> > 
> > Fixes: 9bd8212f981e ("ext4 crypto: add encryption policy and password salt support")
> > Fixes: f424f664f0e8 ("f2fs crypto: add encryption policy and password salt support")
> 
> Ouch.  We are going to break ten year old setups?  I don't think we can
> do this!

That assumes anyone is actually depending on this bug, which they
probably aren't.  Encrypted swap is done in other ways.

> I think the best we can do is to emit loud warnings which point the
> operator to some Documentation/ which tells operator that this
> deprecated configuration will be disallowed in, umm, 2029.

... and if they are, they'll want to fix it right away anyway, not in
2029.

Other fixes to explicitly disallow swapfile activation in various cases
have been merged without a deprecation period, e.g. 36e4d95891ed,
377eeaa8e11f, 51cc3a6620a6, d15cab975459.

I think we should try just doing this instead of dragging it out over
several years.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
