Return-Path: <SRS0=Hk9E=45=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E18C2BB1D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:43:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5610F206E7;
	Thu, 12 Mar 2020 15:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="UTftLU+g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="SrFbKXjH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yufD4+sb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5610F206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jCPzi-0008ES-Mp; Thu, 12 Mar 2020 15:43:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jCPzg-0008E1-VD
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Mar 2020 15:43:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7gXdx4b+RUVgjcQaMdLPaSs5WDDQCvi8Q2rkVU5v2b8=; b=UTftLU+gOzzuxNZfUmiyby56Jf
 biuYuFsLYbGEO6bZ0mkTwUAmDb5rlrt9eyuniZa77rmx5b+ruekf1TkpYrteLWYVXXuy0fiBhcJr2
 JezcFLf6/5pQ3QauSDqoAtyIX11v+x6SAhA3XcDPs8ZlIEfTmbRk1hmL2Om0RFeDtLGg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7gXdx4b+RUVgjcQaMdLPaSs5WDDQCvi8Q2rkVU5v2b8=; b=SrFbKXjHxHITtBXnSW2skZ0LOG
 Zy16KvbOmDTqf/6CTSEHwCD/t819eECWWkyTJIUEKSkqwI2Q2pGd1Pvlgq822tJQYHCVnYFycKvbu
 q6cnGb0TCJht05UVJbddhCaCNr3LAMyvySt9jlBb4FF4Ey2GRURDr4l8WGZjvogZFRcg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jCPzf-00Gsmv-NE
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Mar 2020 15:43:32 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BA917206E7;
 Thu, 12 Mar 2020 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584027802;
 bh=VQtgky7PW1tvUs1l8QX/WLz12evFl2QLUdddE9kEICg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yufD4+sbXQycOX49/e6v2hru1yblfC0agjLh+4R34+qGLX11eDg39p1t15UjxdZ6N
 GNUgsYTKL68U596iK/7PrGwtGz6o11L4L8kl4vkyJ6BNZnrZQtLQJeyTEdZcD2DYvX
 shaqLiEWxtKdCTE2YpSMpC1jMb6GLUt8MTeqeaBs=
Date: Thu, 12 Mar 2020 08:43:20 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20200312154320.GA6470@sol.localdomain>
References: <20200312080253.3667-1-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200312080253.3667-1-satyat@google.com>
X-Headers-End: 1jCPzf-00Gsmv-NE
Subject: Re: [f2fs-dev] [PATCH v8 00/11] Inline Encryption Support
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
Cc: linux-scsi@vger.kernel.org, Kim Boojin <boojin.kim@samsung.com>,
 Kuohong Wang <kuohong.wang@mediatek.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Mar 12, 2020 at 01:02:42AM -0700, Satya Tangirala wrote:
> This patch series adds support for Inline Encryption to the block layer,
> UFS, fscrypt, f2fs and ext4.
> 

This patch series can also be retrieved from

	Repo: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
	Tag: inline-encryption-v8

I based it on v5.6-rc2 (same base commit as v7) since it still applies cleanly
to it.  You can see what changed by:

	git diff inline-encryption-v7..inline-encryption-v8

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
