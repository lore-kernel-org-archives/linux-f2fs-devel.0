Return-Path: <SRS0=nGR+=ZH=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6471DC432C3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 Nov 2019 23:04:48 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD07206D6;
	Fri, 15 Nov 2019 23:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="WbRePdvk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="b+6IOORw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcmHWP96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD07206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iVkdz-0006sM-PB; Fri, 15 Nov 2019 23:04:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1iVkdz-0006sD-CQ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Nov 2019 23:04:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=34MWm9/arBy3rZ22Hii4e6/buBtCWLT4gp7TAGqelfE=; b=WbRePdvkCxGdTWIn0MD3SAKKOY
 VANX7YWBRlJOuxEG06IkrC0WXcR0CCQSv5FZBAiz8s8GVgWtGxn9dEZ1qrUJpQCErROOo4fsjhXMd
 y79ueaojZ+FDfovOOQDF6fYrhVgrn/nujG5TNl7Vh/QgQ/EZs2k1wQjJvM+6e9ggJIZQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=34MWm9/arBy3rZ22Hii4e6/buBtCWLT4gp7TAGqelfE=; b=b+6IOORwKSKE2/lfxFI0ateNx5
 /65QmD1+eo21QZWcuErIINZ5h7dx21CFLzok0989iAyJ17r/+qvzRBwCNxu+mcVNq9yeinVy8WGqd
 PzAs6BwLpfbCD1wVEPF438wYXdaOlAg1JAYdRXZ0aAROOUZ/EWiCmbTGYGQuI7+JgYe4=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iVkdv-006CgG-H3
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Nov 2019 23:04:47 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9D6BD206D6;
 Fri, 15 Nov 2019 23:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573859073;
 bh=nxGyncx9ocQNd0mwb5/JHfFenJwa+LxTO/zcASHHirU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UcmHWP96PV3X+9Z8lt/hRwUwOl1NvZ1sHgtSW8m35ozmeWnMRBMIR4qTYi7vl3nRG
 CcvfsfzewHxFXDROgORR2myIWoZySz7VrbqAAvv75gLUfc5HMkmqLw2snJ6hWwzP3c
 AGGdixiWm0BZjeY5KVrn+ndhBxOpU4+XC9y0rzz4=
Date: Fri, 15 Nov 2019 15:04:31 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Message-ID: <20191115230430.GA217050@gmail.com>
References: <20191107001259.115018-1-ebiggers@kernel.org>
 <20191115172832.GA21300@linux.intel.com>
 <20191115192227.GA150987@sol.localdomain>
 <20191115225319.GB29389@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191115225319.GB29389@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1iVkdv-006CgG-H3
Subject: Re: [f2fs-dev] [PATCH] fscrypt: support passing a keyring key to
 FS_IOC_ADD_ENCRYPTION_KEY
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
Cc: David Howells <dhowells@redhat.com>, "Theodore Y . Ts'o" <tytso@mit.edu>,
 Ondrej Mosnacek <omosnace@redhat.com>, linux-f2fs-devel@lists.sourceforge.net,
 Paul Lawrence <paullawrence@google.com>, linux-fscrypt@vger.kernel.org,
 keyrings@vger.kernel.org, linux-mtd@lists.infradead.org,
 Ondrej Kozina <okozina@redhat.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org, Paul Crowley <paulcrowley@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Nov 16, 2019 at 12:53:19AM +0200, Jarkko Sakkinen wrote:
> 
> > I'm working on an xfstest for this:
> > 
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/xfstests-dev.git/commit/?h=fscrypt-provisioning&id=24ab6abb7cf6a80be44b7c72b73f0519ccaa5a97
> > 
> > It's not quite ready, though.  I'll post it for review when it is.
> > 
> > Someone is also planning to update Android userspace to use this.  So if there
> > are any issues from that, I'll hear about it.
> 
> Cool. Can you combine this patch and matching test (once it is done) to
> a patch set?
> 

xfstests is developed separately from the kernel (different git repo and
maintainer), so combining kernel and xfstests patches into the same patchset
doesn't make sense.  I can certainly send them out at the same time, though.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
