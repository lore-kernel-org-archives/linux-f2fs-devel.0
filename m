Return-Path: <SRS0=v3Bs=UY=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18696C48BD4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Jun 2019 17:52:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E130720663;
	Tue, 25 Jun 2019 17:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="I1RMYF9P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="R/Kgch3X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjAOE5lD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E130720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hfpcK-0006cS-MQ; Tue, 25 Jun 2019 17:52:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hfpcJ-0006cK-NQ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 25 Jun 2019 17:52:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EcWPrq2o5lkGnZTGHuqWaNWdoelkSdjwjAmnzxHCn/U=; b=I1RMYF9PAbLb784SWFG/9aQrCC
 BSpwT+lOHc5QXTw+0dGCt/KY0a8bVBHVMnX4FbZKAHLw/PcxFCch90vcPjKLQrBcZvO3NBU38vso+
 ywVGndvCgEbE4kbCTauQCo1vDW5FRa1XVF7ur6aOsJ7l/TKTylYLzjWv4rG4sxMCyfpE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EcWPrq2o5lkGnZTGHuqWaNWdoelkSdjwjAmnzxHCn/U=; b=R/Kgch3XKlRzcnGEd9Vchsd6IM
 F+dp0KlISoENJKcDe6dUGbC0P0PTsCxpXsSQdsPctLD93L9HOwW0mHg0mV7GLEZElYPo+2nSUb4ra
 xh5+zVkaSnL714WI9NtlTNtLsZMaO2I/q+09pFMKAB2bO790UXJpLQfJw7/5VW9hM/lU=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hfpcQ-00DQlZ-7b
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 25 Jun 2019 17:52:35 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2756320663;
 Tue, 25 Jun 2019 17:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1561485148;
 bh=wyycSt+pI2DJX5K8aByDIu1qndou0ZcC3vKhYC0f3bM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DjAOE5lDyE7nFLOiJ/TjmGzmXakZCqaiO7KZ4EjtP6/qEVCgSX/Fym0WfDE8dHEU7
 TVqGc4cKyWEW9szMmQezxKmszLdo28xETW3HIk2BO5u49SUH1z9G3kxm/PyvTbUZla
 rhLWkPZS8pNpuwPX5N2EHJ5EymKNGv0664ZbxDz8=
Date: Tue, 25 Jun 2019 10:52:26 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20190625175225.GC81914@gmail.com>
References: <20190620205043.64350-1-ebiggers@kernel.org>
 <20190620205043.64350-17-ebiggers@kernel.org>
 <90495fb1-72eb-ca42-8457-ef8e969eda51@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <90495fb1-72eb-ca42-8457-ef8e969eda51@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1hfpcQ-00DQlZ-7b
Subject: Re: [f2fs-dev] [PATCH v5 16/16] f2fs: add fs-verity support
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
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>,
 "Darrick J . Wong" <darrick.wong@oracle.com>, linux-api@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-integrity@vger.kernel.org,
 linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, Victor Hsieh <victorhsieh@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao, thanks for the review.

On Tue, Jun 25, 2019 at 03:55:57PM +0800, Chao Yu wrote:
> Hi Eric,
> 
> On 2019/6/21 4:50, Eric Biggers wrote:
> > +static int f2fs_begin_enable_verity(struct file *filp)
> > +{
> > +	struct inode *inode = file_inode(filp);
> > +	int err;
> > +
> 
> I think we'd better add condition here (under inode lock) to disallow enabling
> verity on atomic/volatile inode, as we may fail to write merkle tree data due to
> atomic/volatile inode's special writeback method.
> 

Yes, I'll add the following:

	if (f2fs_is_atomic_file(inode) || f2fs_is_volatile_file(inode))
		return -EOPNOTSUPP;

> > +	err = f2fs_convert_inline_inode(inode);
> > +	if (err)
> > +		return err;
> > +
> > +	err = dquot_initialize(inode);
> > +	if (err)
> > +		return err;
> 
> We can get rid of dquot_initialize() here, since f2fs_file_open() ->
> dquot_file_open() should has initialized quota entry previously, right?

We still need it because dquot_file_open() only calls dquot_initialize() if the
file is being opened for writing.  But here the file descriptor is readonly.
I'll add a comment explaining this here and in the ext4 equivalent.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
